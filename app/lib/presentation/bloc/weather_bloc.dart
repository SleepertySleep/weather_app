import 'package:bloc/bloc.dart';
import 'package:app/presentation/bloc/weather_event.dart';
import 'package:app/presentation/bloc/weather_state.dart';
import 'package:app/presentation/services/weather_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitial()) {
    on<FetchWeatherEvent>(_onFetchWeather);
    on<FetchCurrentLocationWeatherEvent>(_onFetchCurrentLocationWeather);
  }

  Future<void> _onFetchWeather(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      final weather = await weatherService.getWeather(event.city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather'));
    }
  }

  Future<void> _onFetchCurrentLocationWeather(
      FetchCurrentLocationWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      final city = await weatherService.getCurrentCity();
      final weather = await weatherService.getWeather(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather for current location'));
    }
  }
}
