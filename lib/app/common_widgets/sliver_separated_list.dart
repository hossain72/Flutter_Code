import 'package:flutter/material.dart';

class SliverSeparatedList extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final int itemCount;
  final EdgeInsetsGeometry? padding;

  const SliverSeparatedList({
    super.key,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget list = SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final itemIndex = index ~/ 2;
        if (index.isEven) {
          return itemBuilder(context, itemIndex);
        } else {
          return separatorBuilder(context, itemIndex);
        }
      }, childCount: itemCount == 0 ? 0 : itemCount * 2 - 1),
    );

    if (padding != null) {
      return SliverPadding(padding: padding!, sliver: list);
    }
    return list;
  }
}
