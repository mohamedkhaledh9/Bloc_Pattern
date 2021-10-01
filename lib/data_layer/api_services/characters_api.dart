import 'dart:convert';

import 'package:apis/constants/strings.dart';
import 'package:apis/data_layer/models/character_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CharactersApi {
  late Dio dio;
  CharactersApi() {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: baseUrl,
      receiveTimeout: 20 * 1000,
      connectTimeout: 20 * 1000,
    );
    dio =Dio(options);
  }
Future<List<dynamic>>getAllCharacters()async{
try{
  Response response=await dio.get("characters");
  //print(response.data);
  return response.data;
}catch(e){
  print(e);
  return [];
}

}
  Future<List<Character>?> getAllCharacters1() async {
    http.Response response = await http.get(Uri.parse(baseUrl + "characters"));
    try {
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body).cast<Map<String, dynamic>>();
        print(parsedJson.toString());
        return parsedJson
            .map<Character>((character) => Character.fromJson(character))
            .toList();
      } else {
        print("Can't Load Data !");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
