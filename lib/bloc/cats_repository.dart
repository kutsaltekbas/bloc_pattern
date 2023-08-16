import 'dart:convert';

import 'cat_model.dart';
import 'package:http/http.dart' as http;

abstract class CatsRepository {
  Future<List<CatModel>> getCats();
}

class SampleCatsRepository implements CatsRepository {
  @override
  Future<List<CatModel>> getCats() async {
    final baseUrl = Uri(
        scheme: "https",
        host: "hwasampleapi.firebaseio.com",
        path: "http.json");
    final response = await http.get(baseUrl);
    switch (response.statusCode) {
      case 200:
        final jsonBody = jsonDecode(response.body) as List;
        return jsonBody.map((e) => CatModel.fromJson(e)).toList();

      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
