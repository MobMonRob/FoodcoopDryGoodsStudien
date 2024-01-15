import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studienarbeit/models/CategoryModel.dart';
import 'package:studienarbeit/widgets/listview/CategoryListView.dart';

import '../models/DataModel.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataModel>(context);

    return dataProvider.categories.isEmpty ? Center(
      child: Column(
        children: [
          const Spacer(),
          Text(
            'Daten imporieren',
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          Text(
            '"+" Button oben rechts',
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          const Spacer(),
        ],
      )
    )
        :
    ListView.builder(
        itemCount: dataProvider.categories.length,
        itemBuilder: (context, index) {
          final CategoryModel item = dataProvider.categories[index];
          return CategoryListView(item: item);
        });
  }
}
