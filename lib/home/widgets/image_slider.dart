import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sunpower_website/widgets/image_button.dart';

class HomePageImageSlider extends StatefulWidget {
  const HomePageImageSlider({super.key});

  @override
  State<HomePageImageSlider> createState() => _HomePageImageSliderState();
}

class _HomePageImageSliderState extends State<HomePageImageSlider> {
  final List<String> imgList = [
    'assets/images/home_slider_0.jpg',
    'assets/images/home_slider_1.jpg',
    'assets/images/home_slider_2.jpg',
    'assets/images/home_slider_3.jpg',
    'assets/images/home_slider_4.jpg',
  ];

  int _currentIndex = 0;
  int _animationIndex = 0;

  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double imageHeight = width * 0.6;
    return Column(
      children: [
        SizedBox(
          height: imageHeight,
          width: width,
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                switchInCurve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  if (_animationIndex == 0) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  } else if (_animationIndex == 1) {
                    return MosaicImageReveal(
                      key: ValueKey<int>(_currentIndex),
                      imagePath: imgList[_currentIndex],
                    );
                  } else {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, -1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }
                },
                child:
                    _animationIndex == 1
                        ? const SizedBox.shrink()
                        : Image.asset(
                          imgList[_currentIndex],
                          key: ValueKey<int>(_currentIndex),
                          fit: BoxFit.cover,
                          width: double.infinity,
                      height: imageHeight,
                        ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex =
                              (_currentIndex - 1 + imgList.length) %
                              imgList.length;
                          _animationIndex = (_animationIndex + 1) % 3;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = (_currentIndex + 1) % imgList.length;
                          _animationIndex = (_animationIndex + 1) % 3;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: height * 0.15,
          width: width,
          child: ListView.builder(
            itemCount: imgList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                    _animationIndex = (_animationIndex + 1) % 3;
                  });
                },
                child: Container(
                  width: width / imgList.length,
                  margin: const EdgeInsets.symmetric(horizontal: 0.5),
                  child: Image.asset(imgList[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MosaicImageReveal extends StatefulWidget {
  final String imagePath;
  const MosaicImageReveal({super.key, required this.imagePath});

  @override
  State<MosaicImageReveal> createState() => _MosaicImageRevealState();
}

class _MosaicImageRevealState extends State<MosaicImageReveal>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  final int rows = 6;
  final int cols = 10;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      rows * cols,
      (_) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      )..forward(),
    );
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height * 0.8;

    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: List.generate(rows * cols, (index) {
          int row = index ~/ cols;
          int col = index % cols;

          double tileWidth = screenWidth / cols;
          double tileHeight = screenHeight / rows;

          return AnimatedBuilder(
            animation: _controllers[index],
            builder: (context, child) {
              return Positioned(
                top: row * tileHeight,
                left: col * tileWidth,
                child: Opacity(
                  opacity: _controllers[index].value,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment(
                        -1 + (2 * col / (cols - 1)),
                        -1 + (2 * row / (rows - 1)),
                      ),
                      widthFactor: 1 / cols,
                      heightFactor: 1 / rows,
                      child: Image.asset(
                        widget.imagePath,
                        width: screenWidth,
                        height: screenHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
