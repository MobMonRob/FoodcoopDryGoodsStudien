import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studienarbeit/models/CategoryModel.dart';
import 'package:studienarbeit/models/ProductModel.dart';
import 'package:studienarbeit/widgets/CustomSearchBar.dart';
import 'package:studienarbeit/widgets/items/ProductWidget.dart';

import '../models/DataModel.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<CategoryModel> _categories;
  List<ProductModel> _searchResults = [];

  void _performSearch(String query) {
    setState(() {
      _searchResults = [];
    });
    query = query.toLowerCase();
    for (CategoryModel category in _categories) {
      for (ProductModel product in category.products) {
        if (product.type.toLowerCase().contains(query) || product.name.toLowerCase().contains(query)) {
          if (!_searchResults.contains(product)) {
            _searchResults.add(product);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataModel>(context);

    _categories = provider.categories;

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CustomSearchBar(onSearch: _performSearch),
            const SizedBox(height: 15.0),
            // Display search results here based on _searchText
            _searchResults.isEmpty ?
              Text(
                  'keine Suchergebnisse',
                  style: Theme.of(context).textTheme.bodyLarge!,
              )
                :
              Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: _searchResults?.length,
                    itemBuilder: (context, index) {
                      final ProductModel item = _searchResults[index];
                      return Container(
                        width: 200,
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 5,),
                        child: ProductWidget(product: item),
                      );
                    }),
              ),
          ],
        ),
    );
  }
}
