import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sunpower_website/home/widgets/image_slider.dart';
import 'package:sunpower_website/product_list/product_list_page.dart';
import 'package:sunpower_website/utils/AppColors.dart';
import 'package:sunpower_website/widgets/social_media_button.dart';

class SubPageAppBar extends StatefulWidget {
  const SubPageAppBar({super.key});

  @override
  State<SubPageAppBar> createState() => _SubPageAppBarState();
}

class _SubPageAppBarState extends State<SubPageAppBar> {
  @override
  Widget build(BuildContext context) {
    //final double toolBarHeight = 700;
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black,Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
            ),
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 24
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SocialMediaButton(
                    socialType: 'Youtube',
                    link: '',
                  ),
                  const SizedBox(width: 24,),
                  SocialMediaButton(
                    socialType: 'Facebook',
                    link: '',
                  ),
                ],
              ),
              Divider(
                thickness: 1.5,
                color: Colors.white24,
              ),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/logo_icon.png",
                        width: 200,
                      ),
                    ],
                  ),
                  const SizedBox(width: 48,),
                  Expanded(
                    flex: 2,
                    child: Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        IconButton(
                            onPressed: (){
                              GoRouter.of(context).go('/');
                            },
                            icon: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                    child: Icon(Icons.home,size: 16,color: Colors.white,)
                                )
                            )
                        ),
                        AppBarButton(name: 'Home',),
                        //AppBarButton(name: 'About Us',),
                        AppBarButton(name: 'Contact Us',),
                        AppBarButton(
                          name: 'Products',
                          onPressed: (){
                            GoRouter.of(context).push('/products');
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            //   return ProductListPage();
                            // }));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
class AppBarButton extends StatefulWidget {
  final String name;
  final bool smallButton;
  final VoidCallback? onPressed;
  const AppBarButton({super.key, required this.name, this.smallButton = false, this.onPressed});

  @override
  State<AppBarButton> createState() => _AppBarButtonState();
}

class _AppBarButtonState extends State<AppBarButton> {

  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if(hovered)
          AnimatedButtonWidget(height: 20, width: widget.name.length * 10 ),
        TextButton(
            onPressed: widget.onPressed,
            onHover: (value){
              setState(() {
                hovered = value;
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Corner radius
              ),
            ),
            child: Text(
              widget.name,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: widget.smallButton ? 12 : 18
              ),
            )
        ),
      ],
    );
  }
}

class AnimatedButtonWidget extends StatefulWidget {
  final double height;
  final double width;

  const AnimatedButtonWidget({super.key, required this.height, required this.width});

  @override
  State<AnimatedButtonWidget> createState() => _AnimatedButtonWidgetState();
}

class _AnimatedButtonWidgetState extends State<AnimatedButtonWidget> {
  bool _start = true;

  @override
  void initState() {
    print("initState");
    super.initState();

    print("Future.delayed");
    Future.delayed(Duration(milliseconds: 100)).then((value){
      print("Future.delayed done");
      _start = false;
      if(mounted){

        setState(() {

        });
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _start ? 0 : widget.height,
        width: widget.width,
        duration: Duration(
            milliseconds: 100
        ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}
