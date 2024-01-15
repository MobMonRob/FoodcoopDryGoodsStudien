import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:studienarbeit/models/CategoryModel.dart';
import 'package:studienarbeit/widgets/listview/QRCategoryListView.dart';

import '../models/DataModel.dart';

class QRCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String result = '';
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late List<CategoryModel> categories;
  late CategoryModel categoryModel;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
      });
      controller.pauseCamera();
      Navigator.pop(context);
      findCategoryModel();
    });
  }

  void _showQRPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'bitte QR Code scannen',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'beenden',
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
        ],
      ),
    );
  }


  void findCategoryModel() {
    for (CategoryModel category in categories) {
      if (category.category == result) {
        setState(() {
          categoryModel = category;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final DataModel provider = Provider.of<DataModel>(context);
    categories = provider.categories;

    return Stack(
      children: [
        result != '' ?
        Positioned.fill(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: QRCategoryListView(item: categoryModel),
          ),
        ) :
        Center(
          child: Text(
            'QR Code scannen',
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: FloatingActionButton(
            child: const Icon(Icons.qr_code),
            onPressed: () {
              controller?.resumeCamera();
              _showQRPopup(context);
            },
          ),
        ),
      ],
    );
  }




}
