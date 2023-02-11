import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pt_arkamaya/model/create_user.dart';
import 'package:pt_arkamaya/model/single_user.dart';

import '../model/list_user.dart';

class ApiService{
  static const String _baseUrl ="https://reqres.in";


  Future<ListUser> getListUser() async{
    final response = await http.get(Uri.parse("$_baseUrl/api/users"));

    if(response.statusCode == 200){
      return ListUser.fromJson(json.decode(response.body));
    } else{
      throw Exception('Failed to load List User');
    }

  }

  Future<SingleUser> getSingleUser(String id) async{
    final response = await http.get(Uri.parse("$_baseUrl/api/users/$id"));

    if(response.statusCode == 200){
      return SingleUser.fromJson(json.decode(response.body));
    } else{
      throw Exception('Failed to load Single User');
    }

  }

  Future<CreateUser> getCreateUser(String name, String job) async{
    final response = await http.post(
        Uri.parse("$_baseUrl/api/users"),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      'name': name, 'job': job,
    }),
    );


    if(response.statusCode == 201){
      return CreateUser.fromJson(json.decode(response.body));
    } else{
      throw Exception('Failed to sent Create User');
    }

  }

}