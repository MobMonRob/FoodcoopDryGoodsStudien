import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studienarbeit/models/CartModel.dart';
import 'package:studienarbeit/models/ProductModel.dart';

import '../../models/CartItem.dart';
import '../../utils.dart';
import 'ProductImageWidget.dart';

class ProductDetailsWidget extends StatefulWidget {
  ProductModel product;

  ProductDetailsWidget({required this.product});

  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {

    final dataProvider = Provider.of<CartModel>(context);



    void addItem() {
      setState(() {
        itemCount++;
      });
    }

    void removeItem() {
      if (itemCount > 0) {
        setState(() {
          itemCount--;
        });
      }
    }

    void addToCart() {
      if (itemCount > 0) {
        dataProvider.addProduct(widget.product, itemCount);
        setState(() {
          itemCount = 0;
        });
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produktansicht',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 25, bottom: 50, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ProductImageWidget(
                    assetName: widget.product.imageName,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: removeItem,
                ),
                SizedBox(
                    width: 75,
                    height: 50,
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: color1,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            '$itemCount',
                            style: Theme.of(context).textTheme.titleLarge!,
                          ),
                        )
                    )
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addItem,
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 5,),
            SizedBox(
              width: 275,
              child: Text(
                widget.product.type,
                style: Theme.of(context).textTheme.titleLarge!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              widget.product.name,
              style: Theme.of(context).textTheme.bodyLarge!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 10,),
            Text(
              '${double.parse((widget.product.price).toStringAsFixed(2))}€',
              style: Theme.of(context).textTheme.bodyLarge!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    addToCart();
                  },
                  child: Text(
                    'in den Einkaufswagen',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'zurück',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
