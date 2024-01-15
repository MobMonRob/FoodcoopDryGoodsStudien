import 'package:studienarbeit/models/ProductModel.dart';

class CartItem {
  final ProductModel product;
  int amount;

  void setAmount(int amount) {
    this.amount = amount;
  }

  CartItem({required this.product, required this.amount});
}