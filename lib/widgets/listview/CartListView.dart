import 'package:flutter/material.dart';
import 'package:studienarbeit/widgets/items/CartItemWidget.dart';
import '../../models/CartItem.dart';
import '../../models/CartModel.dart';

class CartListView extends StatelessWidget {
  final List<CartItem> cartItems;
  final CartModel cartModel;

  CartListView({required this.cartItems, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = cartItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: CartItemWidget(cartItem: cartItem, cartModel: cartModel,),
        );
      },
    );
  }
}