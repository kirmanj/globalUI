import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sunpower_website/utils/brands_service.dart';

import 'firebase_options.dart';
import 'home/home_page.dart';
import 'product_list/product_list_page.dart';
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
          builder: (context,state){
              return HomePage();
            },
        ),
        GoRoute(
            path: '/category/:id',
            builder: (context,state){
              String? id = state.pathParameters['id'];
              String? subCategory = state.uri.queryParameters['subCategory'];
              return ProductListPage(
                id: id,
                subCategory: subCategory,
              );
            }
        ),
      ]
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