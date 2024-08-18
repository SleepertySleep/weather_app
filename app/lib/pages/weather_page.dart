import 'package:app/services/weather_service.dart';
import 'package:flutter/material.dart';

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
          Text('${_weather?.temperature.round()}°C')
        ],
      ),
    );
  }
}