import 'package:flutter/material.dart';
import 'package:autotruckstore/utils/site_constants.dart';

class VisionSectionWidget extends StatefulWidget {
  const VisionSectionWidget({super.key});

  @override
  State<VisionSectionWidget> createState() => _VisionSectionWidgetState();
}

class _VisionSectionWidgetState extends State<VisionSectionWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.5,
      child: LayoutBuilder(
        builder: (context, constrains) {
          bool isSmall = constrains.maxWidth < SITE_MIN_WIDTH;
          bool isMid = !isSmall && constrains.maxWidth < SITE_MAX_WIDTH;
          return AspectRatio(
            aspectRatio: 2.7,
            child: Image.asset(
              'assets/images/backWeb2.jpg',
              fit: BoxFit.cover,
            ),
          );
          if (constrains.maxWidth < SITE_MIN_WIDTH) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/podmape.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(color: Colors.blue),
            );
          }
        },
      ),
    );
  }
}
