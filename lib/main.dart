import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home/home_page.dart';
import 'product_list/product_list_page.dart';
import 'utils/AppColors.dart';

void main() {
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
          routes: [
            GoRoute(
                path: 'products',
              builder: (context,state){
                  return ProductListPage();
              }
            )
          ]
            )

      ]
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor).copyWith(
          primary: AppColors.primaryColor,
          onPrimary: Colors.white
        ),
        fontFamily: 'OpenSans'
      ),
      // home: const HomePage(),
    );
  }
}