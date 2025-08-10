import 'package:autotruckstore/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailsProvider extends ChangeNotifier {

  Product? product;

  Future<String> getProduct(String uid) async {
    // try{
    print(uid);
      if(uid.isEmpty){
        throw Exception("not found");
      }
      var result = await FirebaseFirestore.instance.collection("products").doc(uid).get();
      print(result.exists);
      if(result.exists){
        product = Product.fromDoc(result);
        notifyListeners();
        return product!.id;
      } else {
        throw Exception("not found");
      }

    // } catch (error) {
    //   print(error);
    //   throw Exception("not found");
    // }
  }

}