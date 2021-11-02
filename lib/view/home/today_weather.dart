import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class TodayWeather extends StatefulWidget {
    const TodayWeather({Key? key, this.temperature, this.day ,this.image}) : super(key: key);
     final String? temperature ;
    final String? day ;
    final String? image;
  @override
  _TodayWeatherState createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  double opacity = 1.0;
  changeOpacity() {
    Future.delayed(const Duration(seconds: 3), () {
      if(mounted) {
        setState(() {
        opacity = opacity == 0.3 ? 1.0 : 0.3;
        changeOpacity();
      });
      }
    });
  }
  @override
  void initState() {

    super.initState();
    changeOpacity();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Text(widget.temperature! +"°ᶜ" ,style:const TextStyle(fontSize: 20,
             fontWeight: FontWeight.bold),),

          const Text("Now",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      ],),
        AnimatedOpacity(
          opacity: opacity  ,
          duration: const Duration(milliseconds: 1000),
          // The green box must be a child of the AnimatedOpacity widget.
          child:  AspectRatio(
            aspectRatio: 3,
          child: Center(child:Image.network("http://openweathermap.org/img/wn/${widget.image!}@2x.png",
            scale: 0.1, )
               ,),),
        ),

    ],);
  }
}
