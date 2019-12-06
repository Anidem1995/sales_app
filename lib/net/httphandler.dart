import 'package:http/http.dart' as http;
import 'package:sales/model/product.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HttpHandler {
  String server_url = '192.168.1.72';

  Future<String> atemptLogin(username, password) async {
    Map<String, String> headers = {
      "Content-Type":"application/x-www-form-urlencoded",
      "Authorization":"Basic Y29tLnBhdG0uZGVza3RvcDo="
    };
    String body = "username=$username&password=$password&grant_type=password";

    http.Response response = await http.post('http://$server_url:8888/auth/token',
    headers: headers, body: body);
    print('Bearer ${response.body}');
    print('${response.statusCode}');
    return response.statusCode == 200 ? response.body : "";
  }
  
  Future<List<Product>> productsList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.get("access_token").toString().replaceAll("\"", "");
    String tuna = "";
    Map<String, String> headers = {
      "Authorization":"Bearer $token"
    };
    final response = await http.get('http://$server_url:8888/products', headers: headers);

    if(response.statusCode == 200) {
      List products = json.decode(response.body);
      return products.map((product) => Product.fromJson(product)).toList();
    }
    else throw Exception('Todo mal');
  }

  Future<bool> saveTicket(id_funcion, asiento) async {
    final response = await http.post('http://$server_url:8080/api/boleto/insertar/$id_funcion/$asiento');
    if(response.statusCode == 204){
      print('Simon que sí');
      return true;
    }
    else {
      print('Chale');
      return false;
    }
  }
}