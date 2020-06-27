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
  String firstName;
  String lastName;

  Product({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory Product.fromMap(Map<String, dynamic> json) => new Product(
        id: json["productid"],
        firstName: json["productname"],
        lastName: json["productprice"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
      };
}
