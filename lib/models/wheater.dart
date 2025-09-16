class Wheater {
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;
  final String icon;

  Wheater({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.icon,
  });

  factory Wheater.fromJson(Map<String, dynamic> json) {
    return Wheater(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      humidity: json['current']['humidity'],
      icon: json['current']['condition']['icon'],
    );
  }
}


// git add .
// git commit -m "msg"
// git push