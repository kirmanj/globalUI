import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart' show CategoryModel;
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier{


  final categoriesCollection = FirebaseFirestore.instance.collection('categories');
  List<CategoryModel>? categories;

  Future getCategories() async {
    var result = await categoriesCollection.get();

    print("getCategories");
    print(result.size);
    categories = result.docs.map((e){return CategoryModel.fromDoc(e);}).toList();
    notifyListeners();
  }

}