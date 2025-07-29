import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunpower_website/models/product.dart';

class ProductListProvider extends ChangeNotifier{


  final productsCollection = FirebaseFirestore.instance.collection('products');
  List<Product>? products;
  bool working = false;

  getProducts(String categoryId,{bool reset = false}) async {

    if(reset){
      products = null;
      working = true;
      notifyListeners();
    }
    if(products != null && products!.length % 15 != 0){
      return;
    }
    products ??= [];

    //"477d53d0-bda6-11ed-af13-1569568464b7"
    var result = await productsCollection
        .where("categoryID", isEqualTo: categoryId)
        .where('active',isEqualTo: true)
        .orderBy("itemCode", descending: false)
        .limit(30)
        .get();

    products = result.docs.map<Product>((e) => Product.fromDoc(e)).toList();

    notifyListeners();
  }

}