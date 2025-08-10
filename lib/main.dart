import 'package:autotruckstore/product_details/product_details_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:autotruckstore/utils/brands_service.dart';

import 'firebase_options.dart';
import 'home/home_page.dart';
import 'product_list/product_list_page.dart';
import 'search_product_list/search_products_result.dart';
import 'utils/AppColors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  BrandsService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return HomePage();
        },
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final String? id = state.pathParameters['id'];
          return ProductDetailsPage(uid: id??"");
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          String? posParam = state.uri.queryParameters['pos'];

          int? pos = int.tryParse(posParam??"");
          print(pos);
          return HomePage(
            pos: pos,
          );
        },
      ),
      GoRoute(
        path: '/category/:id/:index',
        builder: (context, state) {
          String? id = state.pathParameters['id'];
          int index = int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
          String? subCategory = state.uri.queryParameters['subCategory'];

          return ProductListPage(
            id: id,
            index: index,
            subCategory: subCategory,
          );
        },
      ),
      GoRoute(
        path: '/search/:searchKey',
        builder: (context, state) {
          String? searchKey = state.pathParameters['searchKey'] ?? "";
          return SearchProductsResult(searchKey: searchKey);
        },
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Auto Truck Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ).copyWith(primary: AppColors.primaryColor, onPrimary: Colors.white),
        fontFamily: 'AutoTruck',
        fontFamilyFallback: ['OpenSans'],
      ),
      // home: const HomePage(),
    );
  }
}
