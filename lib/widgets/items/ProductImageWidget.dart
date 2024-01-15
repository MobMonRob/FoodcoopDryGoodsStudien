import 'package:flutter/material.dart';

import '../../utils.dart';

class ProductImageWidget extends StatelessWidget {
  final String assetName;

  ProductImageWidget({
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/productimages/$assetName.jpg',
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.shopping_cart_outlined,
          size: 75,
          color: color2,
        );
      },
    );
  }
}
