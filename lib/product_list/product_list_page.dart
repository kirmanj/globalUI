import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower_website/categories/categories_provider.dart';
import 'package:sunpower_website/models/category.dart';
import 'package:sunpower_website/models/product.dart';
import 'package:sunpower_website/product_list/product_list_provider.dart';
import 'package:sunpower_website/widgets/product_card.dart';
import 'package:sunpower_website/widgets/sub_category_card.dart';
import '../home/widgets/home_app_bar.dart';
import '../home/widgets/sub_pages_app_bar.dart';

class ProductListPage extends StatefulWidget {
  final Color backgroundColor;
  const ProductListPage({super.key, required this.backgroundColor});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  final ScrollController _scrollController = ScrollController();


  bool _showSecondSection = false;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    productListProvider.getProducts();
    categoriesProvider.getCategories().then((value){
      WidgetsBinding.instance.addPostFrameCallback((timestamp){

      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 300 && !_showSecondSection) {
      setState(() {
        _showSecondSection = true;
      });
    } else if (_scrollController.offset <= 300 && _showSecondSection) {
      setState(() {
        _showSecondSection = false;
      });
    }
  }

  final productListProvider = ProductListProvider();
  final categoriesProvider = CategoriesProvider();

  @override
  Widget build(BuildContext context) {

    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: widget.backgroundColor,//  Color(0xffe30f3a),
      body: Stack(
        children: [
          ChangeNotifierProvider<CategoriesProvider>.value(
            value: categoriesProvider,
            child: ChangeNotifierProvider<ProductListProvider>.value(
              value: productListProvider,
              child: ListView(
                controller: _scrollController,
                children: [
                  SubPageAppBar(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                        vertical: 24
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.05
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Position lamps / clearance lights",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 60,
                                    color: Colors.white,
                                    height: 1.1
                                ),
                              ),
                              Text(
                                "186 series of lamps",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 30,
                                    color: Colors.white,
                                    height: 1.1
                                ),
                              ),
                            ],
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context,constrains) {

                            int childCount = 3;
                            int filterChildCount = 2;
                            double filterWidth = 48 + 160;
                            double containerWidth = constrains.maxWidth - 20 - (48 + 160) -1;
                            if (constrains.maxWidth < 850){
                              childCount = 2;
                            }
                            if (constrains.maxWidth < 650){
                              childCount = 1;
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
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Consumer<CategoriesProvider>(
                                    builder: (context,snapshot,child) {
                                      if(snapshot.categories == null){
                                        return const SizedBox();
                                      }
                                      CategoryModel category = snapshot.categories!.firstWhere((element){return element.id == '477d53d0-bda6-11ed-af13-1569568464b7';});

                                      print(category.id);
                                      print(category.name);
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8
                                            ),
                                            child: Text(
                                              "Filters",
                                              style: TextStyle(
                                                  fontSize: 32,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          GridView.builder(
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: filterChildCount,
                                                childAspectRatio: 1,
                                                crossAxisSpacing: 8,
                                                mainAxisSpacing: 8
                                            ),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 16
                                            ),
                                            itemCount: category.subCategories.length,//snapshot.categories!.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return SubCategoryCard(
                                                category: category.subCategories[index],
                                                onClick: (String name) {
                                                  if(name == selectedCategory){
                                                    setState(() {
                                                      selectedCategory = null;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      selectedCategory = name;
                                                    });
                                                  }

                                                },
                                                isSelected: category.subCategories[index].name == selectedCategory
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  ),
                                ),
                                Container(
                                  width: containerWidth,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Consumer<ProductListProvider>(
                                      builder: (context,snapshot,child) {
                                        if (snapshot.products == null){
                                          return const SizedBox();
                                        }
                                        List<Product> filteredList = snapshot.products!;
                                        if(selectedCategory != null){
                                          filteredList = snapshot.products!.where((element){return element.subCategory == selectedCategory;}).toList();
                                        }
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black.withAlpha(200)
                                                  ),
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                    vertical: 4
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.home,color: Colors.white,size: 13,),
                                                      Icon(Icons.arrow_right,color: Colors.red,size: 16,),
                                                      Text("Position lamps / clearance lights",style: TextStyle(
                                                        color: Colors.white,fontSize: 13,
                                                      ),),
                                                      if(selectedCategory != null)
                                                        Icon(Icons.arrow_right,color: Colors.red,size: 16,),
                                                      if(selectedCategory != null)
                                                        Text(selectedCategory!,style: TextStyle(
                                                          color: Colors.white,fontSize: 13,
                                                        ),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12,),
                                            GridView.builder(
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: childCount,
                                                  childAspectRatio: 2,
                                                  crossAxisSpacing: 16,
                                                  mainAxisSpacing: 16
                                              ),
                                              shrinkWrap: true,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 16
                                              ),
                                              itemBuilder: (context,index){
                                                return ProductCard(product: filteredList[index],);
                                              },
                                              itemCount: filteredList.length,
                                            ),
                                          ],
                                        );
                                      }
                                  ),
                                ),
                              ],
                            );
                          }
                        )
                      ],
                    ),
                  ),


                  SizedBox(
                    height: 200,
                    //color: Color.fromARGB(255, 242, 242, 242),
                  )
                ],
              )
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
        ],
      ),
    );
  }
}
