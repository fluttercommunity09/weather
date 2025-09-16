import 'package:flutter/material.dart';
import 'package:wheaterapp/models/wheater.dart';
import 'package:wheaterapp/services/weather_service.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  WeatherService weatherService = WeatherService();

  String city = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Icon(Icons.wb_sunny, color: Colors.yellowAccent, size: 30),
            const SizedBox(width: 10),
            Text(
              'Weather app',
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search for City ...',
                    ),
                    onChanged: (value) {
                      setState(() {
                        city = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Wheater? wheater = await weatherService.getCurrentWheather(
                      city,
                    );
                    if (wheater != null) {
                      print(wheater.temperature);
                    }
                  },
                  icon: Icon(Icons.search, color: Colors.white, size: 40),
                ),
              ],
            ),
            Text(city, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
