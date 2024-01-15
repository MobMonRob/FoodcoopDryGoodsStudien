import 'package:flutter/cupertino.dart';
import 'CategoryModel.dart';

class DataModel extends ChangeNotifier {
  List<CategoryModel> categories = [];

  DataModel();

  void setCategories(List<CategoryModel> categories) {
    this.categories = categories;
    notifyListeners();
  }
}