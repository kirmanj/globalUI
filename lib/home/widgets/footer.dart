import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:autotruckstore/categories/categories_provider.dart';
import 'package:autotruckstore/models/category.dart';
import 'package:autotruckstore/utils/AppColors.dart';
import 'dart:math' as math;

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset("assets/images/footer.jpg", fit: BoxFit.cover),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          // color: AppColors.primaryColor, //Colors.black,
          // height: 500,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withAlpha(210),
          ),
          // padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Image.asset(
                  "assets/icons/logo_icon.png",
                  // color: Colors.white,
                ),
              ),
              // const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    SizedBox(
                      width: 230,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone Numbers",
                            // AppLocalizations.of(context).trans("phoneNumbers"),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sales Office: Arabic Language",
                                    // AppLocalizations.of(context).trans("SalesOA"),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  _buildColoredPhoneNumber('0772', '277 7000'),
                                  _buildColoredPhoneNumber('0775', '577 7000'),
                                ],
                              ),
                              SizedBox(height: 4),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sales Office: Kurdish Language",
                                    // AppLocalizations.of(context).trans("SalesOK"),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  _buildColoredPhoneNumber('0750', '297 7000'),
                                  _buildColoredPhoneNumber('0750', '033  3000'),
                                ],
                              ),
                              SizedBox(height: 4),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Social Media and Application",
                                    // AppLocalizations.of(context).trans("SocialMA"),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  _buildColoredPhoneNumber('0771', '299 3344'),
                                  _buildColoredPhoneNumber('0750', '033 3000'),
                                ],
                              ),
                              SizedBox(height: 4),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery & Service",
                                    // AppLocalizations.of(context).trans("deliveryS"),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  _buildColoredPhoneNumber('0773', '979 0909'),
                                ],
                              ),
                              SizedBox(height: 4),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Complains",
                                    // AppLocalizations.of(context).trans("complains"),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  _buildColoredPhoneNumber('0750', '077 7000'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Emails",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              // color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sales",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // _launchEmail("sales@autotruckstore.com");
                                },
                                child: SelectableText(
                                  'sales@autotruckstore.com',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customer care",
                                // AppLocalizations.of(context).trans("customerCare"),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // _launchEmail("info@autotruckstore.com");
                                },
                                child: SelectableText(
                                  'info@autotruckstore.com',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Address",
                            // AppLocalizations.of(context).trans("address"),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 5),
                          SelectableText(
                            "Iraq – Erbil – Northern Industrial Area – New Complex, G33 Building",
                            // AppLocalizations.of(context).trans("ourAddress"),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              // color: Colors.white70
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: math.max(
                        300,
                        MediaQuery.of(context).size.width - 430 - 32,
                      ),
                      child: CategoriesFooterWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColoredPhoneNumber(String orangePart, String blackPart) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          // _launchPhone("$orangePart$blackPart".replaceAll(' ', ''));
        },
        child: SelectableText.rich(
          TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: orangePart,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  // fontWeight: FontWeight.normal,
                ),
              ),
              TextSpan(
                text: " $blackPart",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesFooterWidget extends StatefulWidget {
  const CategoriesFooterWidget({super.key});

  @override
  State<CategoriesFooterWidget> createState() => _CategoriesFooterWidgetState();
}

class _CategoriesFooterWidgetState extends State<CategoriesFooterWidget> {
  final CategoriesProvider categoriesProvider = CategoriesProvider();

  @override
  void initState() {
    categoriesProvider.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoriesProvider>.value(
      value: categoriesProvider,
      child: Consumer<CategoriesProvider>(
        builder: (context, state, child) {
          if (state.categories == null) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children:
                    state.categories!.sublist(0, 15).map((element) {
                      return CategorySection(category: element);
                    }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final CategoryModel category;

  const CategorySection({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            context.go('/category/${category.id}');
          },
          child: Text(
            category.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 8),
        for (var item in category.subCategories.sublist(
          0,
          math.min(5, category.subCategories.length),
        ))
          FooterTextItem(
            onTap: () {
              context.go('/category/${category.id}?subCategory=${item.name}');
            },
            text: item.name,
          ),
      ],
    );
  }
}

class FooterTextItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  // final Widget child;

  const FooterTextItem({super.key, required this.text, required this.onTap});

  @override
  State<FooterTextItem> createState() => _FooterTextItemState();
}

class _FooterTextItemState extends State<FooterTextItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          _hovered = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: _hovered ? Colors.black54 : Colors.white70,
          ),
        ),
      ),
    );
  }
}
