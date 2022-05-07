

import 'package:farmer_app/core/models/response%20models/weather_r_model.dart';
import 'package:farmer_app/core/services/api.dart';
import 'package:flutter/cupertino.dart';

class WeatherViewModel extends ChangeNotifier{
  Api api = Api();

  bool isWeatherLoaded = false;
  bool get getIsWeatherLoaded => isWeatherLoaded;
  WeatherResponseModel? weather;
  WeatherResponseModel? get getWeatherVModel => weather;

  getTeamp(String cityName)async{
    WeatherResponseModel model = await api.featherWeatherByCityName(cityName);
    weather = model;
    isWeatherLoaded = true;
    notifyListeners();
  }
}