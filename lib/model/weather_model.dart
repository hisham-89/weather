// To parse this JSON data, do
//
//     final WeatherModel = WeatherModelFromJson(jsonString);

import 'dart:convert';

import 'package:weather/api/base_model.dart';
import 'package:weather/setting/Setting.dart';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel extends BaseModel {
  WeatherModel({
   required this.lat,
   required this.lon,
    required this.timezone,
    required  this.timezoneOffset,
    required  this.daily,
    required  this.current,
  });

  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  List<Daily> daily;
  Current current;
 @override
  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    timezone: json["timezone"].substring(json["timezone"].indexOf('/')+1),
    timezoneOffset: json["timezone_offset"],
    daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
   current: Current.fromJson(json["current"]) );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "timezone": timezone,
    "timezone_offset": timezoneOffset,
    "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
  };


}
class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  int dt;
  int sunrise;
  int sunset;
  int temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  List<Weather> weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    dt: json["dt"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    temp: json["temp"].toDouble().round(),
    feelsLike: json["feels_like"].toDouble(),
    pressure: json["pressure"],
    humidity: json["humidity"],
    dewPoint: json["dew_point"].toDouble(),
    uvi: json["uvi"].toDouble(),
    clouds: json["clouds"],
    visibility: json["visibility"],
    windSpeed: json["wind_speed"].toDouble(),
    windDeg: json["wind_deg"],
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "sunrise": sunrise,
    "sunset": sunset,
    "temp": temp,
    "feels_like": feelsLike,
    "pressure": pressure,
    "humidity": humidity,
    "dew_point": dewPoint,
    "uvi": uvi,
    "clouds": clouds,
    "visibility": visibility,
    "wind_speed": windSpeed,
    "wind_deg": windDeg,
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
  };
}

class Daily {
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required  this.moonPhase,
    required  this.temp,
    required  this.feelsLike,
    required this.pressure,
    required  this.humidity,
    required   this.dewPoint,
    required  this.windSpeed,
    required  this.windDeg,
    required  this.windGust,
    required  this.weather,
    required  this.clouds,
    required  this.pop,
    required  this.rain,
    required  this.uvi,
    required this.dayName,
    required this.month
  });

  int dt;
  int sunrise;
  int sunset;
  int moonrise;
  int moonset;
  double moonPhase;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double windSpeed;
  int windDeg;
  double windGust;
  List<Weather> weather;
  int clouds;
  double pop;
  double? rain;
  double uvi;
  String dayName;
  String month;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: json["dt"],
    sunrise: json["sunrise"],
    dayName: Setting.getDateFromTime(json["dt"]),
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"].toDouble(),
    temp: Temp.fromJson(json["temp"]),
    feelsLike: FeelsLike.fromJson(json["feels_like"]),
    pressure: json["pressure"],
    humidity: json["humidity"],
    dewPoint: json["dew_point"].toDouble(),
    windSpeed: json["wind_speed"].toDouble(),
    windDeg: json["wind_deg"],
    windGust: json["wind_gust"].toDouble(),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    clouds: json["clouds"],
    pop: json["pop"].toDouble(),
    rain: json["rain"] == null ? null : json["rain"].toDouble(),
    uvi: json["uvi"].toDouble(),
    month: Setting.getDateFromTime (json["dt"] ,month:true),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "temp": temp.toJson(),
    "feels_like": feelsLike.toJson(),
    "pressure": pressure,
    "humidity": humidity,
    "dew_point": dewPoint,
    "wind_speed": windSpeed,
    "wind_deg": windDeg,
    "wind_gust": windGust,
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "clouds": clouds,
    "pop": pop,
    "rain": rain == null ? null : rain,
    "uvi": uvi,
  };
}

class FeelsLike {
  FeelsLike({
    required  this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  double day;
  double night;
  double eve;
  double morn;

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
    day: json["day"].toDouble(),
    night: json["night"].toDouble(),
    eve: json["eve"].toDouble(),
    morn: json["morn"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "night": night,
    "eve": eve,
    "morn": morn,
  };
}

class Temp {
  Temp({
    required this.day,
    required  this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  int day;
  int min;
  int max;
  double night;
  double eve;
  double morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    day: json["day"].toDouble().round(),
    min: json["min"].toDouble().round(),
    max: json["max"].toDouble().round(),
    night: json["night"].toDouble(),
    eve: json["eve"].toDouble(),
    morn: json["morn"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "min": min,
    "max": max,
    "night": night,
    "eve": eve,
    "morn": morn,
  };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}


