import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:awesome_app/models/photoModel.dart';

class PhotosApi {
  int page = 1;
  String apiKey = "563492ad6f91700001000001994040bcb30041619c4e14a2b7ca2be3";
  int timeout = 7;

  List<Photos> parseData(String responseBody) {
    final parsed =
        jsonDecode(responseBody)['photos'].cast<Map<String, dynamic>>();
    print(parsed);
    return parsed.map<Photos>((json) => Photos.fromJson(json)).toList();
  }

  Future<List<Photos>> fetchData(Client client, int page) async {
    try {
      final response = await client.get(
          "https://api.pexels.com/v1/curated?page=$page&per_page=10",
          headers: {"Authorization": apiKey});
      if (response.statusCode == 200) {
        return parseData(response.body);
      } else {
        print(response.statusCode.toString());
        throw Exception('Failed to load ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      throw Failure('Timeout Error');
      print('Timeout Error : $e');
    } on SocketException catch (e) {
      throw Failure('Socket Error');
      print('Socket Error: $e');
    } on Error catch (e) {
      throw Failure('General Error');
      print('General Error: $e');
    }
  }
}

class Failure {
  // Use something like "int code;" if you want to translate error messages
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
