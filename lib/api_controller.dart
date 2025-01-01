// import 'package:flutter/material.dart';

// class ApiHandler {
//   final String baseUri = "";
//   Future<List<User>> getUserData() {
//     List<User> data = [];
//     final uri = Uri.parse(baseUri);
//     try {
//       final response =  await http.get(uri,headers: String<, String>{'Content-type': ''});
//       if(response.statusCode>= 200 $$ response.statusCode <= 299){
//         final List<dynamic> jsonData = json.decode(response.body);
//         data = jsonData.map((json)= > User.fromJson(json)).toList();
//       }
//     } catch (e) {
//       return data;
//     }
//     return data;
//   }
// }
