import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:autotruckstore/home/widgets/sub_pages_app_bar.dart';
import 'package:autotruckstore/utils/AppColors.dart';
import 'package:autotruckstore/widgets/social_media_button.dart';

class AppBarSubView extends StatefulWidget {
  final ItemScrollController? scrollController;

  const AppBarSubView({super.key, this.scrollController});

  @override
  State<AppBarSubView> createState() => _AppBarSubViewState();
}

class _AppBarSubViewState extends State<AppBarSubView> {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;

    return Container(
      height: 90.0,
      color: Colors.black87,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Image.asset('assets/icons/logo_icon.png'),
            ),
            const SizedBox(width: 48),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SocialMediaButton(socialType: 'Youtube', link: ''),
                      const SizedBox(width: 8),
                      SocialMediaButton(socialType: 'Facebook', link: ''),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          GoRouter.of(context).go('/');
                        },
                        icon: Container(
                          width: 30,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.home,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      AppBarButton(name: 'Home', smallButton: true),
                      AppBarButton(
                        name: 'About Us',
                        smallButton: true,
                        onPressed: () {
                          if (widget.scrollController != null) {
                            widget.scrollController!.scrollTo(
                              index: 1,
                              duration: Duration(seconds: 1),
                            );
                            // .animateTo(
                            //   width * 0.4 + (width / 5 * (9 / 16)) - 90,
                            //   duration: Duration(seconds: 1),
                            //   curve: Curves.linear,
                            // );
                          }
                        },
                      ),
                      AppBarButton(
                        name: 'Categories',
                        smallButton: true,
                        onPressed: () {
                          if (widget.scrollController != null) {
                            widget.scrollController!.scrollTo(
                              index: 2,
                              duration: Duration(seconds: 1),
                            );
                            // .animateTo(
                            //   width * 0.4 + (width / 5 * (9 / 16)) - 90,
                            //   duration: Duration(seconds: 1),
                            //   curve: Curves.linear,
                            // );
                          }
                        },
                      ),
                      AppBarButton(
                        name: 'Services',
                        smallButton: true,
                        onPressed: () {
                          if (widget.scrollController != null) {
                            widget.scrollController!.scrollTo(
                              index: 3,
                              duration: Duration(seconds: 1),
                            );
                            // .animateTo(
                            //   width * 0.4 + (width / 5 * (9 / 16)) - 90,
                            //   duration: Duration(seconds: 1),
                            //   curve: Curves.linear,
                            // );
                          }
                        },
                      ),
                      AppBarButton(
                        name: 'Contact Us',
                        smallButton: true,
                        onPressed: () {
                          if (widget.scrollController != null) {
                            widget.scrollController!.scrollTo(
                              index: 6,
                              duration: Duration(seconds: 1),
                            );
                            // .animateTo(
                            //   width * 0.4 + (width / 5 * (9 / 16)) - 90,
                            //   duration: Duration(seconds: 1),
                            //   curve: Curves.linear,
                            // );
                          }
                        },
                      ),
                    ],
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
