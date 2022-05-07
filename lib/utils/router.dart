import 'package:farmer_app/ui/add_farmer.dart';
import 'package:farmer_app/ui/home_screen.dart';
import 'package:farmer_app/ui/weather/weather_screen.dart';
import 'package:flutter/material.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case HomeScreen.id:
            return MaterialPageRoute(
              builder: (_) => HomeScreen(),
              settings: const RouteSettings(name: HomeScreen.id)
            );
      case WeatherScreen.id:
            return MaterialPageRoute(
              builder: (_) => WeatherScreen(),
              settings: const RouteSettings(name: WeatherScreen.id)
            );
      case AddFarmer.id:
            return MaterialPageRoute(
              builder: (_) => AddFarmer(isEditing: false),
              settings: const RouteSettings(name: AddFarmer.id)
            );
      default:
            return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                );
              }
            );
    }
  }
}