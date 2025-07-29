import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart' show CategoryModel;
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier{

  final categoriesCollection = FirebaseFirestore.instance.collection('categories');
  List<CategoryModel>? categories;

  CategoryModel? category;

  Future getCategories() async {
    var result = await categoriesCollection.get();
    categories = result.docs.map((e){return CategoryModel.fromDoc(e);}).toList();
    notifyListeners();
  }

  Future getMainCategories() async {
    var result = await categoriesCollection
        .limit(15)
        .get();
    categories = result.docs.map((e){return CategoryModel.fromDoc(e);}).toList();
    notifyListeners();
  }

  getMainCategory(String id) async {
    var result = await categoriesCollection.doc(id).get();

    if(result.exists) {
      category = CategoryModel.fromDoc(result);
      notifyListeners();
    }
  }




}