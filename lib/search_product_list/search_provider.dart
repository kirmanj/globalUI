import 'package:algoliasearch/algoliasearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunpower_website/models/product.dart';

class SearchProductProvider extends ChangeNotifier{
  static SearchProductProvider of(BuildContext context) => Provider.of<SearchProductProvider>(context,listen: false);

  List<Product>? products;
  dynamic error;
  bool working = false;
  final client = SearchClient(
    appId: 'NCGLNUOYVK',
    apiKey: '9c9e1f5676a0a5ada638b135a1893f63',
  );

  getProducts(String search) async {
    try{

      if(products != null && products!.length % 15 != 0){
        return;
      }
      if(search.isEmpty){
        error = Exception("Search key is not provided!");
        notifyListeners();
        return;
      }
      var queryHits = SearchForHits(
          indexName: 'index',
          query: search,
          length: 15,
          page: 0//reset ? 0 : products!.length ~/ 15,
      );
      
      final responseHits = await client.searchIndex(request: queryHits);
      final List<String >objectsId = responseHits.hits.map((e) => e.objectID).toList();

      products ??= [];

      if(objectsId.isNotEmpty){
        final documents = await
        FirebaseFirestore
            .instance
            .collection("products")
            .where('active',isEqualTo: true)
            .where("productID",whereIn: objectsId)
            .get();

        products!.addAll(documents.docs.where((e){
          String name = e['name'];
          String nameA = e['nameA'];
          String nameK = e['nameK'];
          String itemCode = e['itemCode'];
          return name.toLowerCase().contains(search.toLowerCase()) ||
              nameA.toLowerCase().contains(search.toLowerCase()) ||
              nameK.toLowerCase().contains(search.toLowerCase()) ||
              itemCode.toLowerCase().contains(search.toLowerCase())
          ;
        }).map((e) => Product.fromDoc(e)));
      }
      working = false;
      notifyListeners();
    }
    catch(error){
      working = false;
      this.error = error;
      notifyListeners();
    }
  }

}