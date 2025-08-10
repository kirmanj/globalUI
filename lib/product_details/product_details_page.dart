import 'dart:math';

import 'package:autotruckstore/home/widgets/home_app_bar.dart';
import 'package:autotruckstore/home/widgets/sub_pages_app_bar.dart';
import 'package:autotruckstore/product_details/product_details_provider.dart';
import 'package:autotruckstore/utils/brands_service.dart';
import 'package:autotruckstore/utils/country_service.dart';
import 'package:autotruckstore/utils/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../utils/AppColors.dart';

class ProductDetailsPage extends StatefulWidget {
  final String uid;
  const ProductDetailsPage({super.key, required this.uid});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  final ScrollController _scrollController = ScrollController();

  final ProductDetailsProvider productDetailsProvider = ProductDetailsProvider();

  bool _showSecondSection = false;

  @override
  void initState() {
    productDetailsProvider.getProduct(widget.uid);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
    AppColors.categories[Helper.uuidToNumber(widget.uid)];
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: backgroundColor, //  Color(0xffe30f3a),
      appBar: width < 600 ? AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/icons/logo_icon.png", width: 150),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //         _scaffoldKey.currentState!.openDrawer();
        //       }, icon: Icon(Icons.menu,size: 16,color: Colors.white,))
        // ],
      ) : null ,
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            AppBarButton(
              name: 'Home',
              onPressed: () {
                // _scaffoldKey.currentState!.closeDrawer();
                context.go('/home');
              },
            ),
            AppBarButton(
              name: 'About Us',
              onPressed: () {
                // _scaffoldKey.currentState!.closeDrawer();
                context.go('/home?pos=1');
              },
            ),
            AppBarButton(
              name: 'Categories',
              onPressed: () {
                context.go('/home?pos=2');
              },
            ),
            AppBarButton(
              name: 'Services',
              onPressed: () {
                context.go('/home?pos=3');
              },
            ),
            AppBarButton(
              name: 'Contact Us',
              onPressed: () {
                context.go('/home?pos=6');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ChangeNotifierProvider<ProductDetailsProvider>.value(
            value: productDetailsProvider,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SubPageAppBar(showSearch: false),
                  Consumer<ProductDetailsProvider>(
                    builder: (
                        context,
                        productSnapshot,
                        child,
                        ) {
                      if (productSnapshot.product == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var productData = (productSnapshot.product!.doc as DocumentSnapshot).data() as Map<String,dynamic>;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                          vertical: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                MediaQuery.of(context).size.width * 0.05,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    productSnapshot.product!.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 60,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: min(500, width),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: AspectRatio(
                                          aspectRatio: 1.6,
                                          child: SizedBox(
                                            child:
                                            productSnapshot.product!.image.isEmpty
                                                ? Image.asset(
                                              "images/category/emptyimg.png",
                                              fit: BoxFit.contain,
                                            )
                                                : Image.network(
                                              productSnapshot.product!.image[0].toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    // AppLocalizations.of(context).locale.languageCode.toString() == 'ku'
                                    //     ? productSnapshot!['descK'] ?? ''
                                    //     : AppLocalizations.of(context).locale.languageCode.toString() ==
                                    //     'ar'
                                    //     ? productSnapshot!['descA'] ?? ''
                                    //     :
                                    productData['desc'] ?? '',
                                    style: TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              '${_getPrice(productData)} \$',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (_getOldPrice(productData).isNotEmpty &&
                                                _getOldPrice(productData) != '0' &&
                                                _getOldPrice(productData) != '0.0')
                                              Padding(
                                                padding: EdgeInsetsDirectional.only(start: 4),
                                                child: Text(
                                                  '${_getOldPrice(productData)}\$',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:130,
                                        child:
                                        BrandsService.getBrandImage(
                                          productData['brand'],
                                        ).isNotEmpty
                                            ?
                                        Image.network(
                                          BrandsService.getBrandImage(
                                            productData['brand'],
                                          ),

                                        )
                                            : null,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Specification",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Divider(
                                    height: 24,
                                    color: Colors.black12,
                                  ),
                                  GridView(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(
                                        bottom: 12
                                    ),
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0
                                    ),
                                    children: [
                                      // _specificationLine('Make', productSnapshot.product.mak),
                                      // _specificationLine('Model',     modelName.isEmpty ? '' : modelName),
                                      _specificationLine('Brand',     productSnapshot.product!.brand),
                                      _specificationLine('OEMCode',  productData['oemCode']),
                                      _specificationLine('piecesInBox',  productData['piecesInBox'],),
                                      _specificationLine('volt', productData['volt'],),
                                      _specificationLine('side',productData['side']),
                                      // _specificationLine('madeIn',productSnapshot!['country']),
                                      _specificationLine('color',productData['color']),
                                      _specificationLine('wires',productData['wires']),
                                      _specificationLine('set',productData['set']),
                                      _specificationLine('assembly',productData['assembly']),
                                      _specificationLine('weight',productData['weight']),
                                      _specificationLine('watt',productData['watt']),
                                      _specificationLine('kelvin',productData['kelvin']),
                                      _specificationLine('leds',productData['leds']),
                                      _specificationLine('sizes',productData['sizes']),
                                      _specificationLine('lumen',productData['lumen']),
                                      _specificationLine('functions',productData['functions']),
                                    ].where((e)=> e is! SizedBox).toList(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 200,
                    //color: Color.fromARGB(255, 242, 242, 242),
                  ),
                ],
              ),
            ),
          ),
          if(width >= 600)
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

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 150 && !_showSecondSection) {
      setState(() {
        _showSecondSection = true;
      });
    } else if (_scrollController.offset <= 150 && _showSecondSection) {
      setState(() {
        _showSecondSection = false;
      });
    }
  }

  List<Color> _getMappedColor(String color){
    final Map<String, List<Color>> colorOptions = {
      "Amber": [Colors.amber],
      "Yellow": [Colors.yellow],
      "Red": [Colors.red],
      "Blue": [Colors.blue],
      "Green": [Colors.green],
      "White": [Colors.white],
      "White/Amber": [Colors.white, Colors.amber],
      "White/Red": [Colors.white, Colors.red],
      "White/Blue": [Colors.white, Colors.blue],
      "White/Green": [Colors.white, Colors.green],
      "Red/Blue": [Colors.red, Colors.blue],
      "Graphite": [Colors.grey],
      "Black": [Colors.black],
      "Smoke": [Colors.grey[400]!],
    };
    return colorOptions[color]??[Colors.transparent];
  }


  Widget _specificationLine(String key, var value) {
    if (value != null && ((value is String && value.isNotEmpty) || (value is bool && value))) {
      return Container(

        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical:0, horizontal: 8),

          decoration: BoxDecoration(
            border:  //AppLocalizations.of(context).locale.languageCode.toString() == 'en'?
            Border(
              left: BorderSide(color: AppColors.primaryColor, width: 1),
            )
            //       : Border(
            //   right: BorderSide(color: AppColors.primaryColor, width: 1),
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                key,
                // AppLocalizations.of(context).trans(key),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),

              if (key == 'color' && value !="")
                Wrap(
                  spacing: 4,
                  children: [
                    for (Color color in _getMappedColor(value))
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: color,
                          border: Border.all(color: Colors.black38),
                        ),
                      ),
                  ],
                )

              else if (key == 'madeIn')
                Row(
                  children: [
                    if (value.toString().length == 2)
                      CountryFlag.fromCountryCode(
                        value.toString().toUpperCase(),
                        height: 20,
                        width: 30,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      CountryService.getCountryName(context, value.toString().toLowerCase()),
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                )

              else if ((key == 'assembly' || key == 'set') && value)
                  Icon(Icons.done, color: Colors.green, size: 20)

                else if (key != 'color' && key != 'madeIn' && value.toString() != "true")
                    Text(
                      value,
                      // AppLocalizations.of(context).trans(value.toString()),
                      style: TextStyle(fontSize: 14),
                    ),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }

  String _getOldPrice(dynamic product) {
    return product['old price']?.toString() ?? "";
  }

  String _getPrice(dynamic product) {
    return product['retail price']?.toString() ?? "";
  }

}
