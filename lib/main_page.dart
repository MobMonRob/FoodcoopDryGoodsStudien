import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studienarbeit/models/DataModel.dart';
import 'package:studienarbeit/pages/CartPage.dart';
import 'package:studienarbeit/pages/HomePage.dart';
import 'package:studienarbeit/pages/ImagePage.dart';
import 'package:studienarbeit/pages/QRCodePage.dart';
import 'package:studienarbeit/pages/SearchPage.dart';
import 'package:studienarbeit/utils.dart';
import 'dart:io';

import 'data_operations/excel_data.dart';
import 'models/CategoryModel.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List pages = [
    HomePage(),
    SearchPage(),
    CartPage(),
    QRCodePage(),
    ImagePage(),
  ];
  late ExcelData excelData;

  Future<void> importExcel(DataModel provider) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);

        if (await file.exists()) {
          final bytes = await file.readAsBytes();
          final excel = Excel.decodeBytes(bytes);

          final table = excel.tables[excel.tables.keys.first]!;
          final rows = table.rows;

          excelData = ExcelData();
          List<CategoryModel> categories =  excelData.processRawData(rows);
          setState(() {
            provider.setCategories(categories);
          });
        }
      }
    } catch (e) {
      print('Error importing Excel: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Foodcoop',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              importExcel(dataProvider);
            },
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar( //
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Startseite',
            tooltip: 'Startseite',
            backgroundColor: color3, // Background color of the navigation bar item
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: 'Suchen',
            tooltip: 'Suchen',
            backgroundColor: color3, // Background color of the navigation bar item
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            label: 'Einkaufswagen',
            tooltip: 'Einkaufswagen',
            backgroundColor: color3, // Background color of the navigation bar item
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.qr_code),
            label: 'QR Code',
            tooltip: 'QR Code',
            backgroundColor: color3, // Background color of the navigation bar item
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.camera_alt_outlined),
            label: 'Bild',
            tooltip: 'Bild',
            backgroundColor: color3, // Background color of the navigation bar item
          ),
        ],
      ),
    );
  }
}