import 'package:app/presentation/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:app/domain/models/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/presentation/bloc/weather_bloc.dart';
import 'package:app/presentation/bloc/weather_event.dart';
import 'package:app/presentation/bloc/weather_state.dart';


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
      body: BlocProvider(
        create: (context) => WeatherBloc(WeatherService('3a58d44585eb08ad43193f290d24974f'))
          ..add(FetchCurrentLocationWeatherEvent()),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.weather.city),
                  Lottie.asset(getWeatherAnima(state.weather.condition)),
                  Text('${state.weather.temperature.round()}°C'),
                  Text(state.weather.condition ?? ''),
                ],
              );
            } else if (state is WeatherError) {
              return Center(child: Text(state.message));
            }

            return Center(child: Text('Please wait...'));
          },
        ),
      ),
    );
  }
}