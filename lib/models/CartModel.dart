import 'package:flutter/cupertino.dart';
import 'package:studienarbeit/models/CartItem.dart';

class CartModel extends ChangeNotifier {
  List<CartItem> _items = [];
  double price = 0.0;
  List<CartItem> get items => _items;

  void addProduct(dynamic product, int amount) {
    for (CartItem item in items) {
      if (item.product == product) {
        item.amount += amount;
        return;
      }
    }
    CartItem cartItem = CartItem(product: product, amount: amount);
    items.add(cartItem);
    calculateCartPrice();
    notifyListeners();
  }

  void removeProduct(var product) {
    _items.remove(product);
    calculateCartPrice();
    notifyListeners();
  }

  void clearCart() {
    _items = [];
    calculateCartPrice();
    notifyListeners();
  }

  void calculateCartPrice() {
    double tmp = 0.0;
    for (CartItem item in _items) {
      tmp += item.amount * item.product.price;
    }
    price = double.parse((tmp).toStringAsFixed(2));
    notifyListeners();
  }

}