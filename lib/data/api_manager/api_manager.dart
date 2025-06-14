import 'dart:convert';
import 'package:aljoud_hospital/data/models/doctor/doctor_model.dart';
import 'package:http/http.dart' as http;

//https://newsapi.org/v2/top-headlines/sources?apiKey=32bb2789562b45118686a6b8c01f9dcf
//https://newsapi.org/v2/everything?apiKey=32bb2789562b45118686a6b8c01f9dcf&source=abc-news

class ApiManager {
  static const String _baseUrl = 'newsapi.org';
  static const String _sourcesEndPoint = '/v2/top-headlines/sources';
  static const String _articlesEndPoint = 'v2/everything';
  static const String _apiKey = '32bb2789562b45118686a6b8c01f9dcf';

  static Future<DoctorModel> getDoctors(String categoryId) async {
    Uri url = Uri.https(
      _baseUrl,
      _sourcesEndPoint,
      {'apiKey': _apiKey, 'category': categoryId},
    );
    var serverResponse = await http.get(url);
    var json = jsonDecode(serverResponse.body);
    DoctorModel sourcesResponse = DoctorModel.fromJson(json);
    return sourcesResponse;
  }

  static Future<DoctorModel> searchDoctors(
    String searchText,
  ) async {
    Uri url = Uri.https(
      _baseUrl,
      _articlesEndPoint,
      {
        'apiKey': _apiKey,
        'q': searchText,
      },
    );
    var serverResponse = await http.get(url);
    var json = jsonDecode(serverResponse.body);
    DoctorModel articlesResponse = DoctorModel.fromJson(json);
    return articlesResponse;
  }
}
