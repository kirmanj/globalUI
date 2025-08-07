import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:autotruckstore/models/category.dart';

class CategoryCardWidget extends StatefulWidget {
  final Color color;
  final int index;
  final CategoryModel category;
  const CategoryCardWidget({
    super.key,
    required this.color,
    required this.index,
    required this.category,
  });

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        GoRouter.of(
          context,
        ).push('/category/${widget.category.id}/${widget.index}');
      },
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: AnimatedContainer(
        height: height * 0.1,
        color: _isHover ? Colors.white : widget.color,
        duration: Duration(milliseconds: 400),
        child: Stack(
          children: [
            PositionedDirectional(
              top: 16,
              start: 16,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                width: _isHover ? 100 : 0,
                height: _isHover ? 200 : 0,
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    top: BorderSide(color: widget.color, width: 1),
                    start: BorderSide(color: widget.color, width: 1),
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 16,
              end: 16,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                width: _isHover ? 200 : 0,
                height: _isHover ? 100 : 0,
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(color: widget.color, width: 1),
                    end: BorderSide(color: widget.color, width: 1),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Image.asset(
                      'assets/icons/cat_icon_${(widget.index % 2) + 1}.png',
                      color:
                          _isHover
                              ? null
                              : widget.index % 2 == 0
                              ? null
                              : Colors.white,
                      width: _isHover ? 150 : 100,
                    ),
                  ),
                  Text(
                    widget.category.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: _isHover ? Colors.black54 : Colors.white,
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text(
                      "See more",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
