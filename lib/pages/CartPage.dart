import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studienarbeit/models/CartModel.dart';
import 'package:studienarbeit/widgets/listview/CartListView.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              'im Einkaufswagen ${provider.price}€',
              style: Theme.of(context).textTheme.titleLarge!,
            ),
          ),
        ),
        Expanded(
          child: CartListView(cartItems: provider.items, cartModel: provider,),
        ),
      ],
    );
  }
}
