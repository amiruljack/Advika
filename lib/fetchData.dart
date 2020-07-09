import 'dart:convert';

import 'package:Advika/path.dart';

import 'category_model.dart';
import 'package:http/http.dart' as http;

Future<List<GetCategory>> getCategory() async {
  var response = await http.post("$api/get_category");
  var dataUser = await json.decode(utf8.decode(response.bodyBytes));
  List<GetCategory> rp = [];
  //   const oneSec = const Duration(seconds:5);
  // new Timer.periodic(oneSec, (Timer t) => setState((){

  // }));
  for (var res in dataUser) {
    GetCategory data = GetCategory(
        res['category_id'], res['category_name'], res['category_image']);
    rp.add(data);
  }

  return rp;
}
