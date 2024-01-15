import 'package:flutter/material.dart';
import 'package:studienarbeit/models/CategoryModel.dart';
import 'package:studienarbeit/models/ProductModel.dart';
import 'package:studienarbeit/widgets/items/ProductWidget.dart';

class QRCategoryListView extends StatelessWidget {
  final CategoryModel item;

  QRCategoryListView({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adjust padding as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              item.category,
              style: Theme.of(context).textTheme.titleLarge!,
            ),
          ),
         Expanded(
           child: ListView.builder(
             scrollDirection: Axis.vertical,
             shrinkWrap: true,
             itemCount: item.products.length,
             itemBuilder: (context, index) {
               ProductModel product = item.products[index];
               return Padding(
                 padding: const EdgeInsets.only(bottom: 5),
                 child: SizedBox(
                   height: 225,
                   child: ProductWidget(
                     product: product,
                   ),
                 ),
               );
             },
           ),
         ),
        ],
      )
    );
  }
}
