import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower_website/product_list/product_list_provider.dart';
import 'package:sunpower_website/widgets/product_card.dart';
import '../home/widgets/home_app_bar.dart';
import '../home/widgets/sub_pages_app_bar.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  final ScrollController _scrollController = ScrollController();


  bool _showSecondSection = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    productListProvider.getProducts();
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

  final productListProvider = ProductListProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe30f3a),
      body: Stack(
        children: [
          ChangeNotifierProvider<ProductListProvider>.value(
            value: productListProvider,
            child: ListView(
              controller: _scrollController,
              children: [
                SubPageAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: 24
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
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
                      const SizedBox(height: 20,),
                      Container(
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
                              return GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.7,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16
                                ),
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16
                                ),
                                itemBuilder: (context,index){
                                  return ProductCard(product: snapshot.products![index],);
                                },
                                itemCount: snapshot.products!.length,
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),


                Container(
                  height: 1500,
                  //color: Color.fromARGB(255, 242, 242, 242),
                )
              ],
            )
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
