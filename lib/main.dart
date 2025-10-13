import 'package:flutter/material.dart';
import 'package:wheaterapp/screens/splash_screen.dart';
import 'package:wheaterapp/services/app_lifecycle_observer.dart';
import 'package:wheaterapp/services/revenuecat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RevenueCatService().init('appl_jBSMWZvLUftWVOadsNzKlLnkbBn');

  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final _lifecycleObserver = AppLifecycleObserver();

  @override
  void initState() {
    super.initState();
    if (!RevenueCatService().isPro) _lifecycleObserver.initialize();
  }

  @override
  void dispose() {
    _lifecycleObserver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',

        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
      ),
      home: const LoadingScreen(),
    );
  }
}
