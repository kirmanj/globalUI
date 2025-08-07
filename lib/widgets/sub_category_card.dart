import 'package:flutter/material.dart';
import 'package:autotruckstore/models/category.dart';
import 'package:autotruckstore/utils/AppColors.dart';

class SubCategoryCard extends StatefulWidget {
  final SubCategories category;
  final Function(String name) onClick;
  final bool isSelected;

  const SubCategoryCard({
    super.key,
    required this.category,
    required this.onClick,
    required this.isSelected,
  });

  @override
  State<SubCategoryCard> createState() => _SubCategoryCardState();
}

class _SubCategoryCardState extends State<SubCategoryCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick(widget.category.name);
      },
      borderRadius: BorderRadius.circular(15),
      onHover: (value) {
        setState(() {
          hovered = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color:
                  hovered
                      ? AppColors.primaryColor.withAlpha(100)
                      : Colors.black12,
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
          border:
              widget.isSelected
                  ? Border.all(color: AppColors.primaryColor, width: 0.5)
                  : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(widget.category.image, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
