import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  String id;
  double wholesalePrice;
  double? wholesalePriceOld;
  double retailPrice;
  double? oldPrice;
  double costPrice;
  String itemCode;
  String brand;
  String? subCategory;
  int quantity;
  final doc;
  List<String> image;
  String makeId;
  String categoryID;
  bool isNew;
  bool newArrival;
  bool active;
  String type;

  Product({
    required this.name,
    required this.costPrice,
    required this.quantity,
    required this.id,
    required this.image,
    required this.itemCode,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.brand,
    required this.doc,
    required this.wholesalePriceOld,
    required this.makeId,
    required this.categoryID,
    required this.isNew,
    required this.newArrival,
    required this.active,
    this.type = 'Both',
    this.subCategory,
    this.oldPrice
  });

  factory Product.fromDoc(DocumentSnapshot doc){
    return Product(
      name: doc['name'],
      doc:doc,
      id: doc.id,
      quantity: (doc.data()! as Map)['quantity'] ?? 0,
      costPrice: (doc.data()! as Map)['cost price']?.toDouble() ?? 0.0,
      image: doc['images']?.map<String>((item) => item.toString()).toList(),
      itemCode: doc['itemCode'],
      wholesalePrice: doc['wholesale price']?.toDouble(),
      retailPrice: doc['retail price']?.toDouble(),
      oldPrice: doc['old price']?.toDouble(),
      brand: doc['brand'],
      wholesalePriceOld: (doc.data()! as Map)['old wholesale price']?.toDouble()??0,
      makeId: doc['makeId'],
      categoryID: doc['categoryID'],
      isNew: (doc.data()! as Map)['isNew']??false,
      newArrival: (doc.data()! as Map)['newArrival']??false,
      active: (doc.data()! as Map)['active']??false,
      subCategory: (doc.data()! as Map)['subCategory'],
      type: (doc.data()! as Map)['type']??"Both"
    );
  }

  factory Product.fromJson(Map doc){
    return Product(
      name: doc['name'],
      doc: doc,
      costPrice: doc['cost price'] ?? 0.0,
      id: doc['productID'],
      quantity: doc['quantity']??0,
      image: (doc['images'] as List).map((e) => e.toString()).toList(),
      itemCode: doc['itemCode'],
      wholesalePrice: doc['wholesale price']?.toDouble(),
      retailPrice: doc['retail price']?.toDouble(),
      oldPrice: doc['old price']?.toDouble(),
      brand: doc['brand'],
      wholesalePriceOld: doc['old wholesale price']?.toDouble()??0,
      makeId: doc['makeId'],
      categoryID: doc['categoryID'],
      isNew: doc['isNew']??false,
      newArrival: doc['newArrival']??false,
      active: doc['active']??false,
    );
  }
  get toJson => {
    'name':name,
    'productID':id,
    'images':image,
    'itemCode':itemCode,
    'wholesale price': wholesalePrice,
    'retail price': retailPrice,
    'old price': oldPrice,
    'brand': brand,
    'old wholesale price': wholesalePriceOld,
    'makeId': makeId,
    'categoryID': categoryID,
    'isNew': isNew,
    'newArrival': newArrival,
    'active':active

  };


  String get price {
    if(oldPrice == null || oldPrice == 0.0){
      return retailPrice.toString();
    }
    return oldPrice.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;


  dynamic operator [](String key) {
    return doc[key];
  }

}