import 'package:flutter/foundation.dart';
import 'product.dart';

/// Basit sepet (state) yonetimi. ChangeNotifier Flutter ile birlikte gelir,
/// ekstra paket gerekmez.
class Cart extends ChangeNotifier {
  Cart._();
  static final Cart instance = Cart._();

  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;
  double get total => _items.fold(0, (sum, p) => sum + p.price);

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
