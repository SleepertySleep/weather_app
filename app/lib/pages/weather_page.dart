import 'package:app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('3a58d44585eb08ad43193f290d24974f');
  Weather? _weather;

  _fetchWeather() async {
    String city = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    }

    catch (e){
      print(e);
    }
  }

  String getWeatherAnima(String? condition) {
    // if (condition == null) return 'no condition';

    switch (condition?.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/mist.json';
      case 'smoke':
        return 'assets/mist.json';
      case 'haze':
        return 'assets/mist.json';
      case 'dust':
        return 'assets/sun.json';
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/sun_rain.json';
      case 'drizzle':
        return 'assets/sun_rain.json';
      case 'shower rain':
        return 'assets/sun_rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.city ?? 'loading...'),

          Lottie.asset(getWeatherAnima(_weather?.condition)),

          Text('${_weather?.temperature.round()}°C'),

          Text(_weather?.condition ?? ''),
        ],
      ),
    );
  }
}