import 'package:flutter/material.dart';

class CategoryCardWidget extends StatefulWidget {
  final Color color;
  const CategoryCardWidget({super.key, required this.color});

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {

  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          _isHover = !_isHover;
          print(_isHover);
        });
      },
      onHover: (value){
        setState(() {
          _isHover = value;
          print(_isHover);
        });
      },
      child: AnimatedContainer(
        color: _isHover ? Colors.white : widget.color,
        duration: Duration(
          milliseconds: 400
        ),
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
                      top: BorderSide(
                        color: widget.color,
                        width: 1
                      ),
                      start: BorderSide(
                          color: widget.color,
                          width: 1
                      ),
                    )
                  ),
                )
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
                        bottom: BorderSide(
                            color: widget.color,
                            width: 1
                        ),
                        end: BorderSide(
                            color: widget.color,
                            width: 1
                        ),
                      )
                  ),
                )
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
                      'assets/icons/truck.png',
                      color: _isHover ? widget.color : Colors.white,
                      width: _isHover ? 150 : 100,
                    ),
                  ),

                  Text(
                    "Warning lamps",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: _isHover ? Colors.black54 : Colors.white
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text("See more",style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
