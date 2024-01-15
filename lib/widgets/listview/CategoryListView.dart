import 'package:flutter/material.dart';
import 'package:studienarbeit/models/CategoryModel.dart';
import 'package:studienarbeit/models/ProductModel.dart';
import 'package:studienarbeit/widgets/items/ProductWidget.dart';

class CategoryListView extends StatelessWidget {
  final CategoryModel item;

  CategoryListView({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adjust padding as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.category,
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item.products.length,
              itemBuilder: (context, index) {
                //final element = item['products'][index];
                ProductModel product = item.products[index];

                // Replace this with your custom item widget
                return ProductWidget(
                    product: product
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
