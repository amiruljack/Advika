import 'dart:convert';

Product productFromJson(String str) {
  final jsonData = json.decode(str);
  return Product.fromMap(jsonData);
}

String productToJson(Product data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Product {
  int id;
  String productId;
  String productName;
  String productImage;
  String productPrice;
  String unitName;
  String categoryName;
  String minimumQty;
  String minimumUnit;
  String orderQty;

  Product({
    this.id,
    this.productId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.unitName,
    this.categoryName,
    this.minimumQty,
    this.minimumUnit,
    this.orderQty,
  });

  factory Product.fromMap(Map<String, dynamic> json) => new Product(
        id: json['id'],
        productId: json['productid'],
        productName: json['productname'],
        productImage: json['productimage'],
        productPrice: json['productprice'],
        unitName: json['unitname'],
        categoryName: json['categoryname'],
        minimumQty: json['minimumqty'],
        minimumUnit: json['minimumunit'],
        orderQty: json['orderqty'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'productId': productId,
        'productName': productName,
        'productImage': productImage,
        'productPrice': productPrice,
        'unitName': unitName,
        'categoryName': categoryName,
        'minimumQty': minimumQty,
        'minimumUnit': minimumUnit,
        'orderQty': orderQty,
      };
}
