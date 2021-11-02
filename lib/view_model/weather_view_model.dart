import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/api/api_response.dart';
import 'package:weather/api/http_client.dart';
import 'package:weather/model/city.dart';
import 'package:weather/model/weather_model.dart';

class WeatherViewModel with ChangeNotifier {

  late ApiResponse<WeatherViewModel> _state = ApiResponse.loading();
  WeatherModel? cityWeather;
  CityModel? cities;

  ApiResponse get state => _state;

  Color appBackground = Colors.blue;

  /// save for refresh current city weather
  late double currentLng;

  /// save for refresh current city weather
  late double currentLat;

  /// get weather by city
  Future<void> getWeather(double lat, double lng ,{forceNotify=true}) async {

    _state = ApiResponse.loading();
    if(forceNotify) {
      notifyListeners();
    }
    try {
      currentLat = lat;
      currentLng = lng;
      cityWeather = await HttpClient().fetchData("&lat=$lat&lon=$lng",
          modelConverter: (weather) => WeatherModel.fromJson(weather));
      log("cityWeather${cityWeather!.current.weather[0].icon}");
      if (cityWeather != null) {
        appBackground =
            getAppBackgroundColor(cityWeather!.current.weather[0].icon);

        _state = ApiResponse.completed();
      } else {
        _state = ApiResponse.error();
      }

      notifyListeners();
    } catch (e) {
      log("error$e");
    }
  }

  /// get city data  from json to City model
  void initCity() async {
    final response = await rootBundle.loadString("assets/json/cities.json");
    cities = CityModel.fromJson(json.decode(response));
  }

  Iterable<CityElement> getCity(String name) {
    if (name == "") {
      return [];
    }
    final options = cities!.cities
        .where((element) => element.city.contains(name.toLowerCase()));
    return options;
  }

  getAppBackgroundColor(String currentWeatherIcon) {
    /// get app background depend on current weather status
    switch (currentWeatherIcon) {
      case "01d":
        return Colors.orange;
      case "04d":
      case "03n":
      case "03d":
      case "04n":
        return Colors.blue.shade200;
      case "01n":
      case "50n":
        return Colors.black54;
      default:
        return Colors.blue;
    }
  }
}
