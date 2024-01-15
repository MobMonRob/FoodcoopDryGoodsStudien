import 'package:flutter/material.dart';
import 'package:studienarbeit/models/ProductModel.dart';
import 'package:studienarbeit/utils.dart';
import 'package:studienarbeit/widgets/items/ProductDetailWidget.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:studienarbeit/widgets/items/ProductImageWidget.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  ProductWidget({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {




    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsWidget(
                      product: product,
                ),
              ),
            );

          },
          child: Container(
            padding: const EdgeInsets.all(10),
            color: color5,
            width: 250,
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                      SizedBox(
                      width: 100,
                      height: 100,
                      child: ProductImageWidget(
                        assetName: product.imageName,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'je ${double.parse((product.price).toStringAsFixed(2))}€',
                      style: Theme.of(context).textTheme.titleSmall!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(width: 25,)
                  ],
                ),

                const SizedBox(height: 5,),
                Text(
                  product.type,
                  style: Theme.of(context).textTheme.titleSmall!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyMedium!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const Spacer(),
                Row(children: [
                  const Spacer(),
                  Text(
                    'klicken für Details',
                    style: Theme.of(context).textTheme.bodySmall!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
