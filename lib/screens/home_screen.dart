import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/cart.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _all = [];
  String _query = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // JSON simulasyonu: assets/products.json dosyasindan veri okunur.
  Future<void> _loadProducts() async {
    final raw = await rootBundle.loadString('assets/products.json');
    final List<dynamic> data = jsonDecode(raw);
    setState(() {_all = data.map((e) => Product.fromJson(e)).toList();_loading = false;});
  }

  List<Product> get _filtered => _all
      .where((p) => p.title.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title:Text('Keşfet',style: TextStyle(fontWeight: FontWeight.bold)),
            actions: [ListenableBuilder(listenable: Cart.instance,
                builder: (context, _) => IconButton(
                onPressed: () { Navigator.pushNamed(context, '/cart');},
                  icon: Badge(label: Text('${Cart.instance.count}'),
                  isLabelVisible: Cart.instance.count > 0,
                  child: Icon(Icons.shopping_bag_outlined),
                  ),
            ),
          ),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kendi tarzını bul.',style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 12),
                  TextField(onChanged: (v) => setState(() => _query = v),decoration: 
                  InputDecoration(
                      hintText: 'Ürün ara',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: 
                    SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: _filtered.isEmpty
                        ? Center(child: Text('Ürün bulunamadi'))
                        : GridView.builder(
                            itemCount: _filtered.length,
                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.72,
                            ),
                            itemBuilder: (context, i) =>_ProductCard(product: _filtered[i]),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Route Arguments ile urun detay sayfasina veri tasinir.
      onTap: () {Navigator.pushNamed(context, '/detail', arguments: product);},
      child: Card(
        elevation: 0,
        color: Colors.grey.shade50,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ProductImage(url: product.image)),
            Padding(
              padding:EdgeInsets.all(8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: 
                [
                  Text(product.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(product.subtitle,maxLines: 1,overflow: TextOverflow.ellipsis,style:  TextStyle(color: Colors.grey, fontSize: 11)),
                  SizedBox(height: 4),
                    Text("\TL${product.price.toStringAsFixed(2)}",
                      style:TextStyle(
                      color: Colors.blue, 
                      fontWeight: FontWeight.bold)
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Internet yoksa veya gorsel yuklenemezse ikon gosterir.
class ProductImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  const ProductImage({super.key, required this.url, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Image.network(url,fit: fit,errorBuilder: (context, error, stack) => Center
        (     
              child: Icon(Icons.image_not_supported_outlined,
              size: 40, color: Colors.grey),
        ),
          loadingBuilder: (context, child, progress) => progress == null
            ? child
            : Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
    );
  }
}
