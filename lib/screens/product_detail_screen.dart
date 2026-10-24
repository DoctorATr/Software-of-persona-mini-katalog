import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';
import 'home_screen.dart' show ProductImage;

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Route Arguments ile gelen urun alinir.
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        leading: TextButton.icon(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios, size: 16),
          label: Text('Geri'),
        ),
        leadingWidth: 90,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(height: 260, child: ProductImage(url: product.image)),
          SizedBox(height: 16),
          Text(product.title,style:TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(product.subtitle, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text("\TL${product.price.toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Açıklama',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 4),
          Text(product.description),
          SizedBox(height: 16),
          Text('Özellikleri',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: product.specs.entries
                .map((e) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.key.toUpperCase(),style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text(e.value,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 24),
          SizedBox(height: 50,child: FilledButton.icon
            (
              onPressed: () 
              {
                Cart.instance.add(product); // basit state guncelleme
                ScaffoldMessenger.of(context).showSnackBar
                (
                  SnackBar(content: Text('${product.title} sepete eklendi')),
                );
              },
              icon: Icon(Icons.add_shopping_cart),
              label: Text('Sepetine ekle'),
            ),
          ),
        ],
      ),
    );
  }
}
