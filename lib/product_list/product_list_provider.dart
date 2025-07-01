import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunpower_website/models/product.dart';

class ProductListProvider extends ChangeNotifier{


  final productsCollection = FirebaseFirestore.instance.collection('products');
  List<Product>? products;

  getProducts() async {
    var result = await productsCollection
        .where("categoryID",isEqualTo: "477d53d0-bda6-11ed-af13-1569568464b7")
        .limit(30)
        .get();

    products = result.docs.map<Product>((e) => Product.fromDoc(e)).toList();

    notifyListeners();
  }

}