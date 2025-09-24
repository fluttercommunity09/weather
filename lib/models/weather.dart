class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final String icon;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'] ?? '',
      temperature: (json['current']['temp_c'] ?? 0).toDouble(),
      condition: json['current']['condition']['text'] ?? '',
      humidity: json['current']['humidity'] ?? 0,
      windSpeed: (json['current']['wind_kph'] ?? 0).toDouble(),
      icon: json['current']['condition']['icon'] ?? '',
    );
  }
}
