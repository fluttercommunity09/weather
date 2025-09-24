import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  // You'll need to get your API key from https://www.weatherapi.com/
  // For demo purposes, I'm using a placeholder. Replace with your actual API key.
  static const String _apiKey = 'd63c3acd35ca4c12b6d131030251509';
  static const String _baseUrl = 'https://api.weatherapi.com/v1/current.json';

  static Future<Weather?> getCurrentWeather(String cityName) async {
    try {
      final url = '$_baseUrl?key=$_apiKey&q=$cityName&aqi=no';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Weather.fromJson(data);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  static Future<Weather?> getCurrentWeatherByLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      final url = '$_baseUrl?key=$_apiKey&q=$latitude,$longitude&aqi=no';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Weather.fromJson(data);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
