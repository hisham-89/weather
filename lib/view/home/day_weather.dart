import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/setting/colors.dart';

class WeatherDay extends StatefulWidget {
 const WeatherDay(
      {Key? key,
      this.temperature,
      required this.day,
      required this.month,
      required this.image,
      required this.mainWeather
      })
      : super(key: key);
  final Temp? temperature;

  final String day;
  final String image;
  final String month;
  final String mainWeather;

  @override
  _WeatherDayState createState() => _WeatherDayState();
}

class _WeatherDayState extends State<WeatherDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      Text(
        widget.temperature!.min.toString() + "°ᶜ" +"  "+
            widget.temperature!.max.toString() + "°ᶜ",
        style: const TextStyle(color: AppColors.black, fontSize: 10),
      ),
     const SizedBox(height: 3,),
      Text(
        widget.day,
        style: const TextStyle(
            color: AppColors.black,
            fontSize: 11,
            fontWeight: FontWeight.bold),
      ),
      Text(
        widget.month,
        style: const TextStyle(
            color: AppColors.black,
            fontSize: 11,
            fontWeight: FontWeight.bold),
      ),
      Expanded(
          child: Image.network(
              "http://openweathermap.org/img/wn/${widget.image}@2x.png")),
      Text(widget.mainWeather,style: const TextStyle(fontWeight: FontWeight.bold),)
    ]);
  }
}
