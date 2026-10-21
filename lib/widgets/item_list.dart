import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final String title;
  final String text;
  final double? padding;

  const ItemList({
    super.key,
    required this.title,
    required this.text,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding ?? 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          Text(
            text.isEmpty ? "Sin registrar" : text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
