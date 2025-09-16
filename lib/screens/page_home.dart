import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wheaterapp/models/wheater.dart';
import 'package:wheaterapp/services/weather_service.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  WeatherService weatherService = WeatherService();

  Wheater? wheater;
  String city = '';
  String error = '';

  Future<void> searchWheather() async {
    if (city == '') {
      error = 'plz enter city';
      return;
    }
    final tmp = await weatherService.getCurrentWheather(city);
    setState(() {
      wheater = tmp;
    });
    if (tmp == null) {
      error = 'Error fetching wheather data, plz check sity name';
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();
      print(position);
      final tmp = await weatherService.getCurrentWheatherByPosition(
        '${position.latitude},${position.longitude}',
      );
      setState(() {
        wheater = tmp;
      });
      if (tmp == null) {
        error = 'Error fetching wheather data, plz check sity name';
      }
    }
  }

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
        actions: [
          IconButton(
            onPressed: () {
              getCurrentLocation();
            },
            icon: Icon(Icons.location_on, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF006edc), Color(0xFF007efd), Color(0xFF3689e6)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      hintText: 'Search for City ...',
                      hintStyle: TextStyle(color: Colors.white),
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
                    setState(() {
                      error = '';
                    });
                    await searchWheather();
                  },
                  icon: Icon(Icons.search, color: Colors.white, size: 40),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (error != '')
              Text(error, style: TextStyle(color: Colors.white, fontSize: 16)),
            if (wheater != null)
              Container(
                width: width * 0.6,

                // height: width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  border: Border.all(color: Colors.white, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  // crossAxisAlignment: cROS,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      'https:${wheater!.icon}',
                      scale: 0.5,
                      // width: 200,
                      // height: 200,
                    ),

                    Text(
                      wheater!.cityName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${wheater!.temperature}',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Celsuis',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),

                    Text(
                      wheater!.condition,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),

                    Text(
                      '${wheater!.humidity}',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
