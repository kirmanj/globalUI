import 'package:flutter/material.dart';
import 'package:sunpower_website/utils/site_constants.dart';

import 'category_card_widget.dart';

class MainCategoriesWidget extends StatefulWidget {
  const MainCategoriesWidget({super.key});

  @override
  State<MainCategoriesWidget> createState() => _MainCategoriesWidgetState();
}

class _MainCategoriesWidgetState extends State<MainCategoriesWidget> {
  final List<Color> _colors = [
    Color(0xffe30f3a),
    Color(0xffef7a1f),
    Color(0xfffdd021),
    Color(0xfff2e850),
    Color(0xff50af31),
    Color(0xff9ac43f),
    Color(0xff5ac0ed),
    Color(0xff156999),
    Color(0xff66398e),
    Color(0xff050607),
    Color(0xff7b7c7d),
    Color(0xfff4991d),
    Color(0xffa26537),
    Color(0xfffb62c7),
    Color(0xffffffff),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 1.2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          int _itemCount = 6;
          double availableHeight = height * 1.2;

          double itemWidth = constraints.maxWidth / 6; // Default column count

          print(constraints.maxWidth);
          if (constraints.maxWidth < SITE_MIN_WIDTH) {
            _itemCount = 2;
          } else if (constraints.maxWidth < SITE_MAX_WIDTH) {
            _itemCount = 3;
          } else {
            _itemCount = 6;
          }

          itemWidth = constraints.maxWidth / _itemCount;
          double itemHeight = availableHeight / 3; // Exactly 3 rows
          double aspectRatio = itemWidth / itemHeight;

          return GridView.builder(
            itemCount: _colors.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Prevent scroll

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _itemCount,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: aspectRatio,
            ),
            itemBuilder: (context, index) {
              return CategoryCardWidget(color: _colors[index % _colors.length]);
            },
          );
        },
      ),
    );
  }
}
