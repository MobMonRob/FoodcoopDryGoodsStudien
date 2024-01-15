import 'package:excel/excel.dart';
import 'package:provider/provider.dart';
import 'package:studienarbeit/models/CategoryModel.dart';
import 'package:studienarbeit/models/DataModel.dart';
import 'package:studienarbeit/models/ProductModel.dart';

class ExcelData {


  // Constructor
  ExcelData() {}

  List<CategoryModel> processRawData(List<List<Data?>> _rawData) {
    List<List<Data?>> _rawListRemovedEmpty = [];
    List<List<dynamic>> _rawList = [];
    var _rawJsonData = {"data": []};
    Map<String, List<dynamic>> _jsonData = {"data": []};

    _rawData.forEach((element) {
      if (!areAllElementsNull(element)) {
        _rawListRemovedEmpty.add(element);
      }
    });
    _rawListRemovedEmpty.forEach((element) {
      var temp = [];
      element.forEach((el) {
        if (el != null) {
          temp.add(el.value);
        } else {
          temp.add(null);
        }
      });
      _rawList.add(temp);
    });
    _rawList.forEach((element) {
      Map<String, dynamic> temp = {};
      for (int index = 0; index < element.length; index++) {
        if (index == 0) {
          temp['group'] = element[index];
        }
        if (index == 1) {
          temp['product_type'] = element[index];
        }
        if (index == 2) {
          temp['product_name'] = element[index];
        }
        if (index == 3) {
          temp['product_price'] = element[index];
        }
        if (index == 4) {
          temp['product_amount'] = element[index];
        }
        if (index == 5) {
          temp['note'] = element[index];
        }
        if (index == 6) {
          temp['image'] = element[index];
        }
      }
      List? data = _rawJsonData['data'];
      data?.add(temp);
      _rawJsonData['data'] = data!;
    });
    List? data = _rawJsonData['data'];
    List categories = [];
    List products = [];
    List temp = [];
    data?.forEach((element) {
      if (element['group'] != null) { // is relevant
        if (element['group'].toString() == 'g' && element['product_name'] == null && element['product_price'] == null) { // category
          categories.add(element);
          if (temp.isNotEmpty) {
            products.add(temp);
            temp = [];
          }
        } else { // product
          temp.add(element);
        }
      }
    });
    if (temp.isNotEmpty) {
      products.add(temp);
    }
    data = [];
    if (categories.length == products.length) {
      for (int index = 0; index < categories.length; index++) {
        Map<String, dynamic> tempMap = {};
        tempMap['category'] = categories[index]['product_type'];
        tempMap['products'] = products[index];
        data?.add(tempMap);
      }
    }
    _jsonData['data'] = data!;


    return createProductModels(data!);
  }

  bool areAllElementsNull(List<Data?> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i] != null) {
        return false; // If any element is not null, return false
      }
    }
    return true; // All elements are null
  }

  List<CategoryModel> createProductModels(var jsonData) {
    List<CategoryModel> categories = [];
    for (var category in jsonData) {
      List<ProductModel> temp = [];
      for (var product in category['products']) {

        String type = product['product_type'] != null ? product['product_type'].toString() : '';
        String name = product['product_name'] != null ? product['product_name'].toString() : '';
        double price = product['product_price'] != null ? double.parse(product['product_price'].toString()) : 0.0;
        String imageName = product['image'] != null ? product['image'].toString(): '';

        ProductModel productModel = ProductModel(
          type: type,
          name: name,
          price: price,
          imageName: imageName,
        );
        temp.add(productModel);
      }
      String cat = category['category'].toString();
      categories.add(CategoryModel(category: cat, products: temp));
    }
    return categories;
  }

}
