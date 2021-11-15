import 'package:weather/view/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather/view/home/home.dart';
import 'package:weather/view_model/weather_view_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherViewModel>(
            create: (_) => WeatherViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
    const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool startSplash = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        startSplash = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  startSplash ? ProgressDialogPrimary() :const MyHomePage(title: 'Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WeatherViewModel weatherProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Home(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.refresh,
        ),
        onPressed: () async {
          ///refresh current city weather
          await weatherProvider.getWeather(
              weatherProvider.currentLat, weatherProvider.currentLng);
        },
      ),
    );
  }

  @override
  void initState() {
    weatherProvider = Provider.of<WeatherViewModel>(context, listen: false);
    super.initState();
  }
}
