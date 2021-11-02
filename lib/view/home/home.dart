import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather/api/api_response.dart';
import 'package:weather/setting/colors.dart';
import 'package:weather/view/home/city_search.dart';
import 'package:weather/view/home/day_weather.dart';
import 'package:weather/view/home/today_weather.dart';
import 'package:weather/view/widgets/progress_dialog.dart';
import 'package:weather/view_model/weather_view_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void initData() async {
    Provider.of<WeatherViewModel>(context, listen: false).initCity();
    /// Get weather for  Dubai city by default, and  you can change city from the search
    await Provider.of<WeatherViewModel>(context, listen: false).getWeather(25.325040715872486,55.35206465207865,forceNotify:false);
  }

  @override
  void initState() {
    initData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(window);
    var size = MediaQuery.of(context).size;
    var size2=size.width>size.height?5:1.85;
    final double itemHeight = (size.height - kToolbarHeight - 24) /2.4;
    final double itemWidth = size.width / size2;

    return Consumer<WeatherViewModel>(
        builder: (context, weatherViewModel, child) {

      if (weatherViewModel.state.status == Status.LOADING) {
        return  Center(child:ProgressDialogPrimary ()// CircularProgressIndicator()
        );
      } else if (weatherViewModel.state.status == Status.COMPLETED) {
        return SingleChildScrollView(
            child: Container(
          constraints: BoxConstraints(
              minHeight: mq.size.height -
                  (MediaQuery.of(context).padding.top + kToolbarHeight+35)),
          /**/
          alignment: Alignment.topCenter,
          decoration:   BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              weatherViewModel.appBackground,
            ],
          )),
          child: Column(
            children: [
          const CitySearch(),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 35,
                color: AppColors.black,
              ),
              Text(
                weatherViewModel.cityWeather!.timezone,
                style: const TextStyle(fontSize: 45, color: AppColors.black),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          TodayWeather(
            temperature: weatherViewModel.cityWeather!.current.temp.toString(),
            image: weatherViewModel.cityWeather!.current.weather[0].icon,
            day: weatherViewModel.cityWeather!.daily[0].dayName,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          AspectRatio(
              aspectRatio:1,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio:
                (itemWidth / itemHeight),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: false,
                mainAxisSpacing: 30,
                crossAxisSpacing: 20.2,
                padding: const EdgeInsets.all(5),
                children: List<Widget>.generate(
                  weatherViewModel.cityWeather!.daily.length,
                  (index) => WeatherDay(
                    day:index == 0?"Today" : weatherViewModel
                        .cityWeather!.daily[index].dayName,
                    image: weatherViewModel
                        .cityWeather!
                        .daily[index]
                        .weather[0]
                        .icon  ,
                    temperature: weatherViewModel
                        .cityWeather!.daily[index].temp//.day .toString()
                        ,
                     month: weatherViewModel
                      .cityWeather!.daily[index].month,
                    mainWeather:weatherViewModel
                        .cityWeather!.daily[index].weather[0].main,
                  ),
                ).toList(),
              ))
            ],
          ),
        ));
      } else {
        return Container();
      }
    });
  }
}
