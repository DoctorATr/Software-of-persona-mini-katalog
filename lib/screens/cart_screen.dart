import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'home_screen.dart' show ProductImage;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Sepetim')),
      body: ListenableBuilder(
        listenable: Cart.instance,
        builder: (context, _) {
          final items = Cart.instance.items;
          if (items.isEmpty) {
            return  Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined,size: 64, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Sepetin boş',style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Sepetine ürün ekleyerek alışverişine başla',style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final p = items[i];
                    return ListTile(
                      leading: SizedBox(
                        width: 56,
                        height: 56,
                        child: ProductImage(url: p.image),
                      ),
                      title: Text(p.title,maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text("\TL${p.price.toStringAsFixed(2)}"),
                      trailing: IconButton(icon: Icon(Icons.remove_circle_outline),onPressed: () {Cart.instance.remove(p);},
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Toplam',style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("\TL${Cart.instance.total.toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                      onPressed: () {Cart.instance.clear();ScaffoldMessenger.of(context).showSnackBar
                        (
                          SnackBar(content: Text('Siparis alindi (simulasyon)')),
                        );
                        },
                        child:Text('Ödeme'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
