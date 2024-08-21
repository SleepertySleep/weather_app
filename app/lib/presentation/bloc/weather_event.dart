import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final String city;

  const FetchWeatherEvent(this.city);

  @override
  List<Object> get props => [city];
}

class FetchCurrentLocationWeatherEvent extends WeatherEvent {}
