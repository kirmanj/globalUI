import 'package:flutter/material.dart';

class ButtonImage extends StatefulWidget {
  final Widget image;
  final VoidCallback onTap;
  const ButtonImage({super.key, required this.image, required this.onTap});

  @override
  State<ButtonImage> createState() => _ButtonImageState();
}

class _ButtonImageState extends State<ButtonImage> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value){
        setState(() {
          _hover = value;
        });
      },
      onTap: widget.onTap,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: widget.image
          ),
          Positioned.fill(
            child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
              color: _hover ? Colors.white38 : Colors.transparent
            ),
          )
        ],
      ),
    );
  }
}
