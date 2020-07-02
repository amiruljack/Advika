class GetAllProduct {
  final String productid;
  final String productname;
  final String productprice;
  final String productminimum;
  final String productimage;
  final String categoryname;
  final String unitname;
  GetAllProduct(
    this.productid,
    this.productname,
    this.productprice,
    this.productminimum,
    this.productimage,
    this.categoryname,
    this.unitname,
  );
  //  Map<String, dynamic> toMap() {
  //   var map = <String,dynamic>{
  //     'productid': productid,
  //     'productname': productname,
  //     'productimage': productimage,
  //     'productprice': productprice,
  //     'unitname': unitname,
  //     'categoryname': categoryname,
  //     'productminimum': productminimum,
  //     'productminimumunit': productminimumunit,
  //   };
  //   return map;
  // }
  // GetAllProduct.fromMap(Map<String, dynamic> map) {
  //     productid = map['productid'];
  //     productname= map['productname'];
  //     productimage= map['productimage'];
  //     productprice= map['productprice'];
  //     unitname= map['unitname'];
  //     categoryname= map['categoryname'];
  //     productminimum=map['productminimum'];
  //     productminimumunit= map['productminimumunit'];
  // }
}

class GetTotal {
  final int count;
  final num total;
  GetTotal(
    this.count,
    this.total,
  );
}
