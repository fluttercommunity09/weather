import 'package:http/http.dart' as http;
import 'package:wheaterapp/models/wheater.dart';
import 'dart:convert';

class WeatherService {
  String apiKey = 'ac45a25c248348de9bf215711251509';
  String baseUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<Wheater?> getCurrentWheather(String cityName) async {
    String url = '$baseUrl?key=$apiKey&q=$cityName';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Wheater wheater = Wheater.fromJson(json.decode(response.body));
      return wheater;
    }
    return null;
  }
}
