import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String name;
  String nameA;
  String nameK;
  String id;
  String image;
  String imageC;
  List<SubCategories> subCategories;

  CategoryModel({
    required this.name,
    required this.nameA,
    required this.nameK,
    required this.id,
    required this.image,
    required this.imageC,
    required this.subCategories,
  });

  factory CategoryModel.fromDoc(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;

    return CategoryModel(
      name: data['name'] ?? '',
      nameA: data['nameA'] ?? '',
      nameK: data['nameK'] ?? '',
      id: doc.id,
      image: data['img'] ?? '',
      imageC: data['imgC'] ?? '',
      subCategories: ((data['subCategories']??[]) as List).map((e){return SubCategories.fromMap(e);}).toList(),
    );
  }
}

class SubCategories {

  String name;
  String nameA;
  String nameK;
  String image;

  SubCategories({required this.name,required this.nameA,required this.nameK,required this.image});

  factory SubCategories.fromMap(Map<String,dynamic> data){
    return SubCategories(
      name: data['name'] ?? '',
      nameA: data['nameA'] ?? '',
      nameK: data['nameK'] ?? '',
      image: data['img'] ?? '',
    );
  }


}