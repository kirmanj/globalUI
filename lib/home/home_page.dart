import 'package:flutter/material.dart';
import 'package:sunpower_website/home/widgets/about_us.dart';
import 'package:sunpower_website/home/widgets/features_section_widgets.dart';
import 'package:sunpower_website/home/widgets/home_app_bar.dart';
import 'package:sunpower_website/home/widgets/main_categories_widget.dart';

import 'widgets/image_slider.dart';
import 'widgets/sub_pages_app_bar.dart';
import 'widgets/vision_section_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ScrollController _scrollController = ScrollController();
  bool _showSecondSection = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 500 && !_showSecondSection) {
      setState(() {
        _showSecondSection = true;
      });
    } else if (_scrollController.offset <= 500 && _showSecondSection) {
      setState(() {
        _showSecondSection = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              Stack(
                children: [
                  HomePageImageSlider(),
                  SubPageAppBar()
                ],
              ),

              // SubPageAppBar(),
              /*SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(
                  minHeight: 60.0,
                  maxHeight: 60.0,
                  child: Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text(
                      "Second Top Section",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),*/

              AboutUs(),
              MainCategoriesWidget(),
              FeaturesSectionWidgets(),
              VisionSectionWidget(),
              Container(
                height: 1500,
                //color: Color.fromARGB(255, 242, 242, 242),
              )
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            top: _showSecondSection ? 0 : -90,
            left: 0,
            right: 0,
            child: AppBarSubView(),
          ),
        ],
      ),
    );
  }
}
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}