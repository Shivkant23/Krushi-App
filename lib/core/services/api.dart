

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farmer_app/core/models/response%20models/weather_r_model.dart';

class Api{
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const _api_key = '';

  Future<WeatherResponseModel> featherWeatherByCityName(String cityName) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$cityName&appid=$_api_key'));
    if (response.statusCode == 200) {
      return WeatherResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}