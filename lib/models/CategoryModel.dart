import 'package:studienarbeit/models/ProductModel.dart';

class CategoryModel {
  final String category;
  final List<ProductModel> products;

  CategoryModel({
    required this.category,
    required this.products,
  });
}