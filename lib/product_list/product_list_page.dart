import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autotruckstore/categories/categories_provider.dart';
import 'package:autotruckstore/models/category.dart';
import 'package:autotruckstore/models/product.dart';
import 'package:autotruckstore/product_list/product_list_provider.dart';
import 'package:autotruckstore/utils/AppColors.dart';
import 'package:autotruckstore/utils/helper.dart';
import 'package:autotruckstore/widgets/product_card.dart';
import 'package:autotruckstore/widgets/product_type.dart';
import 'package:autotruckstore/widgets/sub_category_card.dart';
import '../home/widgets/home_app_bar.dart';
import '../home/widgets/sub_pages_app_bar.dart';

class ProductListPage extends StatefulWidget {
  // final Color backgroundColor;
  final String? id;
  final String? subCategory;
  final int index;

  const ProductListPage({
    super.key,
    this.id,
    required this.index,
    this.subCategory,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ScrollController _scrollController = ScrollController();

  bool _showSecondSection = false;
  String? selectedCategory;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.id != null && widget.id!.isNotEmpty) {
      productListProvider.getProducts(widget.id!);
      categoriesProvider.getMainCategory(widget.id!);
    }
    selectedCategory = widget.subCategory;
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

  final productListProvider = ProductListProvider();
  final categoriesProvider = CategoriesProvider();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

    Color backgroundColor =
        AppColors.categories[Helper.uuidToNumber(widget.id ?? "")];
    return Scaffold(
      backgroundColor: backgroundColor, //  Color(0xffe30f3a),
      body: Stack(
        children: [
          ChangeNotifierProvider<CategoriesProvider>.value(
            value: categoriesProvider,
            child: ChangeNotifierProvider<ProductListProvider>.value(
              value: productListProvider,
              child: ListView(
                controller: _scrollController,
                children: [
                  SubPageAppBar(showSearch: false),
                  Consumer2<CategoriesProvider, ProductListProvider>(
                    builder: (
                      context,
                      categorySnapshot,
                      productSnapshot,
                      child,
                    ) {
                      if (categorySnapshot.category == null) {
                        return const SizedBox();
                      }
                      if (productSnapshot.products == null) {
                        return const SizedBox();
                      }
                      CategoryModel category = categorySnapshot.category!;
                      List<Product> filteredList = productSnapshot.products!;
                      if (selectedCategory != null) {
                        filteredList =
                            productSnapshot.products!.where((element) {
                              return element.subCategory == selectedCategory;
                            }).toList();
                      }
                      if (selectedType != null) {
                        filteredList =
                            filteredList
                                .where(
                                  (element) =>
                                      element.type == selectedType ||
                                      element.type == 'Both',
                                )
                                .toList();
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                          vertical: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    categorySnapshot.category!.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 60,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                  /*Text(
                                    "186 series of lamps",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 30,
                                        color: Colors.white,
                                        height: 1.1
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                            LayoutBuilder(
                              builder: (context, constrains) {
                                int childCount = 5;
                                int filterChildCount = 2;
                                double filterWidth = 48 + 160;
                                double containerWidth =
                                    constrains.maxWidth - 20 - (48 + 160) - 1;
                                if (constrains.maxWidth < 1145) {
                                  childCount = 4;
                                }
                                if (constrains.maxWidth < 900) {
                                  childCount = 3;
                                }
                                if (constrains.maxWidth < 780) {
                                  childCount = 2;
                                }
                                if (constrains.maxWidth < 700) {
                                  childCount = 3;
                                  filterChildCount = 3;
                                  filterWidth = constrains.maxWidth;
                                  containerWidth = constrains.maxWidth;
                                }

                                if (constrains.maxWidth < 560) {
                                  childCount = 2;
                                  filterChildCount = 3;
                                  filterWidth = constrains.maxWidth;
                                  containerWidth = constrains.maxWidth;
                                }

                                return Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    Container(
                                      width: filterWidth,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              "Filters",
                                              style: TextStyle(
                                                fontSize: 32,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Divider(color: Colors.grey.shade300),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              "Product Type",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 16,
                                            ),
                                            child: GridView.count(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 8,
                                              shrinkWrap: true,
                                              children: [
                                                ProductTypeWidget(
                                                  type: 'Car',
                                                  onClick: (String name) {
                                                    if (name == selectedType) {
                                                      setState(() {
                                                        selectedType = null;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        selectedType = name;
                                                      });
                                                    }
                                                  },
                                                  isSelected:
                                                      selectedType == 'Car',
                                                ),
                                                ProductTypeWidget(
                                                  type: 'Truck',
                                                  onClick: (String name) {
                                                    if (name == selectedType) {
                                                      setState(() {
                                                        selectedType = null;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        selectedType = name;
                                                      });
                                                    }
                                                  },
                                                  isSelected:
                                                      selectedType == 'Truck',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(color: Colors.grey.shade300),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              "Sub Categories",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      filterChildCount,
                                                  childAspectRatio: 1,
                                                  crossAxisSpacing: 8,
                                                  mainAxisSpacing: 8,
                                                ),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 16,
                                            ),
                                            itemCount:
                                                category
                                                    .subCategories
                                                    .length, //snapshot.categories!.length,
                                            itemBuilder: (
                                              BuildContext context,
                                              int index,
                                            ) {
                                              return SubCategoryCard(
                                                category:
                                                    category
                                                        .subCategories[index],
                                                onClick: (String name) {
                                                  if (name ==
                                                      selectedCategory) {
                                                    setState(() {
                                                      selectedCategory = null;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      selectedCategory = name;
                                                    });
                                                  }
                                                },
                                                isSelected:
                                                    category
                                                        .subCategories[index]
                                                        .name ==
                                                    selectedCategory,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: containerWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black.withAlpha(
                                                    200,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4,
                                                    ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.home,
                                                      color: Colors.white,
                                                      size: 13,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_right,
                                                      color: Colors.red,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      category.name,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    if (selectedCategory !=
                                                        null)
                                                      Icon(
                                                        Icons.arrow_right,
                                                        color: Colors.red,
                                                        size: 16,
                                                      ),
                                                    if (selectedCategory !=
                                                        null)
                                                      Text(
                                                        selectedCategory!,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: childCount,
                                                  childAspectRatio: 0.73,
                                                  crossAxisSpacing: 16,
                                                  mainAxisSpacing: 16,
                                                ),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                            itemBuilder: (context, index) {
                                              return ProductCard(
                                                productListSnapShot:
                                                    filteredList[index],
                                              );
                                            },
                                            itemCount: filteredList.length,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            top: _showSecondSection ? 0 : -90,
            left: 0,
            right: 0,
            child: AppBarSubView(),
          ),

          Positioned(
            right: width * 0.05,
            top: height * 0.13,
            child: SizedBox(
              height: height * 0.3,
              child: Image.asset(
                'assets/icons/cat_icon_${(widget.index % 2) + 1}.png',
                fit: BoxFit.fitHeight,
                height: height * 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
