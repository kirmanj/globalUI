import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:autotruckstore/home/widgets/about_us.dart';
import 'package:autotruckstore/home/widgets/download_app.dart';
import 'package:autotruckstore/home/widgets/features_section_widgets.dart';
import 'package:autotruckstore/home/widgets/footer.dart';
import 'package:autotruckstore/home/widgets/home_app_bar.dart';
import 'package:autotruckstore/home/widgets/main_categories_widget.dart';

import 'widgets/image_slider.dart';
import 'widgets/sub_pages_app_bar.dart';
import 'widgets/vision_section_widget.dart';

class HomePage extends StatefulWidget {

  final int? pos;

  const HomePage({super.key, this.pos});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final ScrollController _scrollController = ScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  bool _showSecondSection = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    /*_scrollController.addListener(_onScroll);*/
    scrollOffsetListener.changes.listen((offset) {
      //print(offset);
      // print(itemPositionsListener.itemPositions.value.first.index);
      _onScroll();
    });
    if(widget.pos != null){
      WidgetsBinding.instance.addPostFrameCallback((timestamp){
        if(widget.pos == 1 || widget.pos == 2 || widget.pos == 3 || widget.pos == 6){
          itemScrollController.scrollTo(index: widget.pos!, duration: Duration(milliseconds: 300));
        }
      });

    }

  }

  @override
  void dispose() {
    /*_scrollController.removeListener(_onScroll);
    _scrollController.dispose();*/
    super.dispose();
  }

  /*void _onScroll() {
    if (_scrollController.offset > 500 && !_showSecondSection) {
      setState(() {
        _showSecondSection = true;
      });
    } else if (_scrollController.offset <= 500 && _showSecondSection) {
      setState(() {
        _showSecondSection = false;
      });
    }
  }*/

  void _onScroll() {
    if (itemPositionsListener.itemPositions.value.first.index == 1 &&
        !_showSecondSection) {
      setState(() {
        _showSecondSection = true;
      });
    } else if (itemPositionsListener.itemPositions.value.first.index == 0 &&
        _showSecondSection) {
      setState(() {
        _showSecondSection = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> items = [
      Stack(
        children: [
          HomePageImageSlider(),
          SubPageAppBar(
            scrollController: itemScrollController, //_scrollController
            showSearch: true,
            isHome: true,
          ),
        ],
      ),
      AboutUs(),
      MainCategoriesWidget(),
      FeaturesSectionWidgets(),
      VisionSectionWidget(),
      SizedBox(height: 10),
      DownloadApp(),
      SizedBox(height: 10),
      FooterWidget(),
      Container(
        color: Color.fromARGB(255, 242, 242, 242),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text.rich(
                TextSpan(
                  text: "Powered by ",
                  style: TextStyle(fontSize: 18),
                  children: [
                    TextSpan(
                      text: "GUIDEWARE",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: width < 600 ? AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/icons/logo_icon.png", width: 150),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        // actions: [
        //   IconButton(
        //     onPressed: (){
        //       _scaffoldKey.currentState!.openDrawer();
        //     }, icon: Icon(Icons.menu,size: 16,color: Colors.white,))
        // ],
      ) : null ,
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            AppBarButton(
              name: 'Home',
              onPressed: () {
                _scaffoldKey.currentState!.closeDrawer();
                itemScrollController.jumpTo(
                  index: 0,
                ); //jumpTo(0);
              },
            ),
            AppBarButton(
              name: 'About Us',
              onPressed: () {
                _scaffoldKey.currentState!.closeDrawer();
                itemScrollController.scrollTo(
                  index: 1,
                  duration: Duration(seconds: 1),
                );
              },
            ),
            AppBarButton(
              name: 'Categories',
              onPressed: () {
                _scaffoldKey.currentState!.closeDrawer();
                itemScrollController.scrollTo(
                  index: 2,
                  duration: Duration(seconds: 1),
                );
              },
            ),
            AppBarButton(
              name: 'Services',
              onPressed: () {
                _scaffoldKey.currentState!.closeDrawer();
                itemScrollController.scrollTo(
                  index: 3,
                  duration: Duration(seconds: 1),
                );
              },
            ),
            AppBarButton(
              name: 'Contact Us',
              onPressed: () {
                _scaffoldKey.currentState!.closeDrawer();
                itemScrollController.scrollTo(
                  index: 6,
                  duration: Duration(seconds: 1),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ScrollablePositionedList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return items[index];
            },
            scrollOffsetController: scrollOffsetController,
            scrollOffsetListener: scrollOffsetListener,
            itemPositionsListener: itemPositionsListener,
            itemScrollController: itemScrollController,
          ),
          // SingleChildScrollView(
          //   controller: _scrollController,
          //   child: Column(
          //     children: items
          //   ),
          // ),

          if(width >= 600)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: _showSecondSection ? 0 : -90,
              left: 0,
              right: 0,
              child: AppBarSubView(
                scrollController: itemScrollController, //_scrollController,
              ),
          ),

          if (_showSecondSection)
            Positioned(
              bottom: 32,
              right: 32,
              child: GestureDetector(
                onTap: () {
                  scrollOffsetController.animateScroll(
                    offset: 0,
                    duration: const Duration(milliseconds: 500),
                  );
                  //_scrollController.
                  // animateTo(
                  //   0,
                  //   duration: const Duration(milliseconds: 500),
                  //   curve: Curves.easeInOut,
                  // );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.black87.withAlpha(150),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: Colors.white,
                          size: 12,
                        ),
                        Text(
                          "Top",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
