import 'package:flutter/material.dart';
import 'package:autotruckstore/utils/AppColors.dart';

class ProductTypeWidget extends StatefulWidget {
  final String type;
  final Function(String name) onClick;
  final bool isSelected;
  const ProductTypeWidget({
    super.key,
    required this.type,
    required this.onClick,
    required this.isSelected,
  });

  @override
  State<ProductTypeWidget> createState() => _ProductTypeWidgetState();
}

class _ProductTypeWidgetState extends State<ProductTypeWidget> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick(widget.type);
      },
      borderRadius: BorderRadius.circular(15),
      onHover: (value) {
        setState(() {
          hovered = value;
        });
      },
      child: Container(
        // width: 70,
        // height: ,
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
        child: Center(
          child: SizedBox(
            width: 35,
            child: Image.asset(
              "assets/icons/${widget.type}.png",
              color:
                  widget.isSelected
                      ? AppColors.primaryColor
                      : Colors.grey.shade600,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
