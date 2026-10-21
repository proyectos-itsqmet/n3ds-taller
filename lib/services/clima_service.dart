import 'package:dio/dio.dart';
import 'package:n3ds_taller/core/config/app_env.dart';
import 'package:n3ds_taller/models/weather.dart';

class ClimaService {
  final Dio _dio = Dio();

  Future<Weather>? buscarWeather({
    required String long,
    required String lat,
  }) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=${AppEnv.weatherKey}";

    final response = await _dio.get(url);

    return Weather.fromJson(response.data);
  }
}
