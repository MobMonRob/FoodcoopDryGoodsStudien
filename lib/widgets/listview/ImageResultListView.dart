import 'package:flutter/material.dart';
import 'package:studienarbeit/utils.dart';

class ImageResultListView extends StatelessWidget {
  final List items;

  ImageResultListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        var tmp = item['confidence'] * 100;
        final confidence = double.parse((tmp).toStringAsFixed(2));
        List<dynamic> list = item['label'].split(' ');
        tmp = '';
        for (int i = 1; i < list.length - 1; i++) {
          tmp += list[i] + ' ';
        }
        tmp += list[list.length - 1];
        final label = tmp;
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: color5,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              children: [
                Text('$confidence%'),
                SizedBox(
                  width: 25,
                ),
                Text('$label'),
              ],
            ),
          ),
        );
      },
    );
  }
}