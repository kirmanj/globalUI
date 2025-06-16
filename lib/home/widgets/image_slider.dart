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
    'assets/images/home_slider_4.jpg'
  ];


  final CarouselSliderController _carouselSliderController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final double toolBarHeight = MediaQuery.of(context).size.width * (1000/1920);
    return Column(
      children: [
        SizedBox(
          height: toolBarHeight,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              CarouselSlider(
                carouselController: _carouselSliderController,
                disableGesture: true,
                items: imgList.map<Widget>((e){
                  return Image.asset(e,fit: BoxFit.cover,);
                }).toList(),
                options: CarouselOptions(
                  height: toolBarHeight,
                  viewportFraction: 1,
                  scrollPhysics: NeverScrollableScrollPhysics()
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
                        onPressed: (){
                          _carouselSliderController.previousPage();
                        },
                        icon: Icon(Icons.arrow_back_ios_outlined , color: Colors.white,size: 50,)
                    )
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
                        onPressed: (){
                          _carouselSliderController.nextPage();
                        },
                        icon: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,size: 50,)
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 12,),
        SizedBox(
            height: (MediaQuery.of(context).size.width/5)*(9/16),
            child: ListView.builder(
                itemCount: imgList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return ButtonImage(
                    image: Image.asset(
                      imgList[index],
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      _carouselSliderController.jumpToPage(index);
                    },
                  );
                }
            )
        )
      ],
    );
  }
}
