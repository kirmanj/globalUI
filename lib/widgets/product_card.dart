// import 'package:flutter/material.dart';
// import 'package:autotruckstore/models/product.dart';
// import 'package:autotruckstore/utils/AppColors.dart';
//
// class ProductCard extends StatefulWidget {
//   final Product product;
//   const ProductCard({super.key, required this.product});
//
//   @override
//   State<ProductCard> createState() => _ProductCardState();
// }
//
// class _ProductCardState extends State<ProductCard> {
//
//   bool hover = false;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){},
//       onHover: (hover){
//         setState(() {
//           this.hover = hover;
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//                 color: hover ? AppColors.primaryColor.withAlpha(100) : Colors.black12,
//                 spreadRadius: 1,
//                 blurRadius: 5
//             )
//           ]
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Image.network(
//                 widget.product.image.first,
//                 // "https://firebasestorage.googleapis.com/v0/b/baharka-library-e410f.appspot.com/o/ProductImg%2F2023-02-08%2015%3A34%3A02.582?alt=media&token=73f12a37-f8fd-41d8-b5c1-cc53b3eb7534",
//                 fit: BoxFit.contain,
//               ),
//             ),
//             const SizedBox(width: 8,),
//             Expanded(
//               // flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   AnimatedContainer(
//                     duration: Duration(
//                       milliseconds: 400
//                     ),
//                     child: Text(
//                       widget.product.name,
//                       // "Number Plate Lamp Red - Bulb - Made in Poland",
//                       style: TextStyle(
//                           fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: hover ? AppColors.primaryColor : Colors.black
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Text(
//                     widget.product.itemCode,
//                     // "Number Plate Lamp Red - Bulb - Made in Poland",
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     widget.product.price+"\$",
//                     // "Number Plate Lamp Red - Bulb - Made in Poland",
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       color: Colors.blue
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   /*Expanded(
//                     child: SizedBox(
//                       // color: Colors.black,
//                       width: double.infinity,
//                       *//*child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 8
//                             ),
//                             child: Container(
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: AppColors.primaryColor,
//                                 borderRadius: BorderRadiusDirectional.only(
//                                   topStart: Radius.circular(15),
//                                   bottomStart: Radius.circular(15),
//                                 )
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 8
//                               ),
//                               child: Text("See Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.white),),
//                             ),
//                           )
//                         ],
//                       ),*//*
//                     ),
//                   )*/
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:autotruckstore/models/product.dart';
import 'package:autotruckstore/utils/brands_service.dart';

class ProductCard extends StatelessWidget {
  final Product productListSnapShot;
  const ProductCard({Key? key, required this.productListSnapShot})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(1),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: AspectRatio(
                aspectRatio: 1.6,
                child: SizedBox(
                  child:
                      productListSnapShot['images'].isEmpty
                          ? Image.asset(
                            "images/category/emptyimg.png",
                            fit: BoxFit.contain,
                          )
                          : Image.network(
                            productListSnapShot['images'][0].toString(),
                            fit: BoxFit.cover,
                          ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    /*AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                      productListSnapShot['nameK'].toString().toUpperCase():
                      AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                      productListSnapShot['nameA'].toString().toUpperCase():*/
                    productListSnapShot['name'].toString().toUpperCase(),
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              '${_getPrice(productListSnapShot)} \$',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_getOldPrice(productListSnapShot).isNotEmpty &&
                                _getOldPrice(productListSnapShot) != '0' &&
                                _getOldPrice(productListSnapShot) != '0.0')
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: 4),
                                child: Text(
                                  '${_getOldPrice(productListSnapShot)}\$',
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
                        width: 45,
                        child:
                            BrandsService.getBrandImage(
                                  productListSnapShot['brand'],
                                ).isNotEmpty
                                ? Image.network(
                                  BrandsService.getBrandImage(
                                    productListSnapShot['brand'],
                                  ),
                                )
                                : null,
                      ),
                    ],
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Item code",
                                // AppLocalizations.of(context).trans("ItemCode"),
                                style: TextStyle(fontSize: 10),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  productListSnapShot['itemCode'].toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getOldPrice(dynamic product) {
    // if(FirebaseAuth.instance.currentUser != null){
    //   if(LocalStorageService.instance.user?.role == 1){
    //     return product['old wholesale price']?.toString()??'';
    //   }
    //   else {
    //     return product['old price']?.toString()??"";
    //   }
    // }
    return product['old price']?.toString() ?? "";
  }

  String _getPrice(dynamic product) {
    // if(FirebaseAuth.instance.currentUser != null){
    //   if(LocalStorageService.instance.user?.role == 1){
    //     return product['wholesale price']?.toString()??'';
    //   }
    //   else {
    //     return product['retail price']?.toString()??"";
    //   }
    // }
    return product['retail price']?.toString() ?? "";
  }
}
