import 'package:flutter/material.dart';
import 'package:sunpower_website/models/product.dart';
import 'package:sunpower_website/utils/AppColors.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      onHover: (hover){
        setState(() {
          this.hover = hover;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: hover ? AppColors.primaryColor.withAlpha(100) : Colors.black12,
                spreadRadius: 1,
                blurRadius: 5
            )
          ]
        ),
        child: Row(
          children: [
            Expanded(
              child: Image.network(
                widget.product.image.first,
                // "https://firebasestorage.googleapis.com/v0/b/baharka-library-e410f.appspot.com/o/ProductImg%2F2023-02-08%2015%3A34%3A02.582?alt=media&token=73f12a37-f8fd-41d8-b5c1-cc53b3eb7534",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(
              // flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedContainer(
                    duration: Duration(
                      milliseconds: 400
                    ),
                    child: Text(
                      widget.product.name,
                      // "Number Plate Lamp Red - Bulb - Made in Poland",
                      style: TextStyle(
                          fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: hover ? AppColors.primaryColor : Colors.black
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.product.itemCode,
                    // "Number Plate Lamp Red - Bulb - Made in Poland",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.product.price+"\$",
                    // "Number Plate Lamp Red - Bulb - Made in Poland",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  /*Expanded(
                    child: SizedBox(
                      // color: Colors.black,
                      width: double.infinity,
                      *//*child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8
                            ),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(15),
                                  bottomStart: Radius.circular(15),
                                )
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8
                              ),
                              child: Text("See Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.white),),
                            ),
                          )
                        ],
                      ),*//*
                    ),
                  )*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
