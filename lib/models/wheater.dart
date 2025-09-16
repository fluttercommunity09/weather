class Wheater {
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;

  Wheater({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
  });

  factory Wheater.fromJson(Map<String, dynamic> json) {
    return Wheater(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      humidity: json['current']['humidity'],
    );
  }
}
