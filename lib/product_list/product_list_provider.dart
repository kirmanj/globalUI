import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunpower_website/models/product.dart';

class ProductListProvider extends ChangeNotifier{


  final productsCollection = FirebaseFirestore.instance.collection('products');
  List<Product>? products;

  getProducts() async {
    var result = await productsCollection.limit(10).get();

    products = result.docs.map<Product>((e) => Product.fromDoc(e)).toList();

    notifyListeners();
  }

}