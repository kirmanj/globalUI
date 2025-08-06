import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sunpower_website/categories/categories_provider.dart';
import 'package:sunpower_website/utils/AppColors.dart';
import 'package:sunpower_website/utils/helper.dart';
import 'package:sunpower_website/utils/site_constants.dart';

import 'category_card_widget.dart';

class MainCategoriesWidget extends StatefulWidget {
  const MainCategoriesWidget({super.key});

  @override
  State<MainCategoriesWidget> createState() => _MainCategoriesWidgetState();
}

class _MainCategoriesWidgetState extends State<MainCategoriesWidget> {

  CategoriesProvider categoriesProvider = CategoriesProvider();

  @override
  void initState() {
    categoriesProvider.getMainCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<CategoriesProvider>.value(
      value: categoriesProvider,
      child: SizedBox(
        // height: height * 1.2,
        child: LayoutBuilder(
          builder: (context, constraints) {
            int itemCount = 6;
            double availableHeight = height * 1.2;

            double itemWidth = constraints.maxWidth / 6; // Default column count

            if (constraints.maxWidth < SITE_MIN_WIDTH) {
              itemCount = 2;
            } else if (constraints.maxWidth < SITE_MAX_WIDTH) {
              itemCount = 3;
            } else {
              itemCount = 6;
            }

            itemWidth = constraints.maxWidth / itemCount;
            double itemHeight = availableHeight / 3; // Exactly 3 rows
            double aspectRatio = itemWidth / itemHeight;

            return Consumer<CategoriesProvider>(
              builder: (context,snapshot,child) {
                if(snapshot.categories == null){
                  return _mainCategoriesLoader(itemCount,aspectRatio,15);
                }
                return GridView.builder(
                  itemCount: snapshot.categories!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Prevent scroll
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: itemCount,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: aspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryCardWidget(
                      color: AppColors.categories[
                        index % AppColors.categories.length
                        // Helper.uuidToNumber(snapshot.categories![index].id)
                      ],
                      index: index,
                      category: snapshot.categories![index],
                    );
                  },
                );
              }
            );
          },
        ),
      ),
    );
  }

  Widget _mainCategoriesLoader(int itemCount,double aspectRatio,int count) {
    return GridView.builder(
      itemCount: count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Prevent scroll
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemCount,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, index) {
        return Shimmer(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey.shade300,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    categoriesProvider.dispose();
    super.dispose();
  }
}
