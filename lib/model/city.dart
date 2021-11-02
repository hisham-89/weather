// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

CityModel cityFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
   required this.cities,
  });

  List<CityElement> cities;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    cities: List<CityElement>.from(json["cities"].map((x) => CityElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
  };
}

class CityElement {
  CityElement({
   required this.city,
   required this.lat,
   required this.lng,
  });

  String city;
  double lat;
  double lng;

  factory CityElement.fromJson(Map<String, dynamic> json) => CityElement(
    city: json["city"].toLowerCase(),
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "lat": lat,
    "lng": lng,
  };
}
