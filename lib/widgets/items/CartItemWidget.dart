import 'package:flutter/material.dart';
import '../../models/CartItem.dart';
import '../../models/CartModel.dart';
import '../../utils.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  final CartModel cartModel;

  CartItemWidget({required this.cartItem, required this.cartModel});

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  bool edit = false;

  void addItem() {
    setState(() {
      widget.cartItem.amount++;
      widget.cartItem.setAmount(widget.cartItem.amount);
      widget.cartModel.calculateCartPrice();
    });
  }

  void removeItem() {
    if (widget.cartItem.amount > 0) {
      setState(() {
        widget.cartItem.amount--;
        widget.cartItem.setAmount(widget.cartItem.amount);
        widget.cartModel.calculateCartPrice();
      });
    }
  }

  void deleteItem() {
    widget.cartModel.removeProduct(widget.cartItem);
  }


  @override
  Widget build(BuildContext context) {
    double price =
    double.parse((widget.cartItem.amount * widget.cartItem.product.price).toStringAsFixed(2));

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: color5,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 75,
                  width: 50,
                  child: GestureDetector(
                    child: edit ? const Icon(Icons.check) : const Icon(Icons.more_vert),
                    onTap: () {
                      setState(() {
                        edit ? (edit = false) : (edit = true);
                      });
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.product.type,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    Text(
                      widget.cartItem.product.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
                    Container(
                      color: color1,
                      margin: const EdgeInsets.only(top: 2.5, bottom: 2.5),
                      height: 1,
                      width: 350,
                    ),
                    SizedBox(
                      height: 25,
                      width: 350,
                      child: Row(
                        children: [
                          Text(
                            '${widget.cartItem.amount} x Stückpreis je ${double.parse((widget.cartItem.product.price).toStringAsFixed(2))}€',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyMedium!,
                          ),
                          const Spacer(),
                          Text(
                            'gesamt $price€',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyMedium!,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            edit ? Row(
              children: [
                const SizedBox(height: 50, width: 50,),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: deleteItem,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: removeItem,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: addItem,
                  ),
                ),
                const SizedBox(height: 50, width: 50,)
              ],
            ) : Container()
          ],
        ),
      ),
    );
  }
}
