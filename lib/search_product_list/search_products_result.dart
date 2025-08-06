import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower_website/home/widgets/home_app_bar.dart';
import 'package:sunpower_website/home/widgets/sub_pages_app_bar.dart';
import 'package:sunpower_website/search_product_list/search_provider.dart';
import 'package:sunpower_website/utils/AppColors.dart';
import 'package:sunpower_website/utils/helper.dart';
import 'package:sunpower_website/widgets/product_card.dart';

class SearchProductsResult extends StatefulWidget {
  final String? searchKey;

  const SearchProductsResult({super.key, this.searchKey});

  @override
  State<SearchProductsResult> createState() => _SearchProductsResultState();
}

class _SearchProductsResultState extends State<SearchProductsResult> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColors.categories[Helper.uuidToNumber(widget.searchKey??"")];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ChangeNotifierProvider<SearchProductProvider>.value(
        value: SearchProductProvider()..getProducts(widget.searchKey??""),
        child: Consumer<SearchProductProvider>(
          builder: (context,value,child) {

            if(value.error != null){
              return const SizedBox();
            }

            if(value.products == null){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            double width = MediaQuery.of(context).size.width;
            int childCount = 5;
            // double containerWidth = width - 20 - (48 + 160) -1;
            if (width < 1145){
              childCount = 4;
            }
            if (width < 900){
              childCount = 3;
            }
            if (width < 780){
              childCount = 2;
            }
            if (width < 700){
              childCount = 3;
              // filterChildCount = 3;
              // filterWidth = width;
              // containerWidth = width;
            }

            if (width < 560){
              childCount = 2;
              // filterChildCount = 3;
              // filterWidth = constrains.maxWidth;
              // containerWidth = constrains.maxWidth;
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubPageAppBar(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.05,
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          widget.searchKey??'',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Colors.white,
                              height: 1.1
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                        vertical: 24
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: childCount,
                                  childAspectRatio: 0.73,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16
                              ),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16
                              ),
                              itemBuilder: (context,index){
                                return ProductCard(
                                  productListSnapShot: value.products![index],
                                );
                              },
                              itemCount: value.products!.length,
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
