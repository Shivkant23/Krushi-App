import 'package:farmer_app/core/view_models/weather_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  static const String id = "weather_screen";
  WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Weather'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.trim().isEmpty) {
                            return "Enter Location*";
                          }
                          return null;
                        },
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          labelText: 'Location*',
                        ),
                        inputFormatters:[
                          FilteringTextInputFormatter.allow(
                            RegExp("[A-Za-z ]"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: (){
                        Provider.of<WeatherViewModel>(context, listen: false).getTeamp(textEditingController.text);
                      }, 
                      icon: const Icon(Icons.search), 
                      label: const Text("Search")
                    ),
                    
                  ],
                ),
                const SizedBox(height: 20,),
                Consumer(
                      builder: (context, WeatherViewModel weather, child) {
                        return weather.getIsWeatherLoaded ? Column(
                          children: [
                            Text(weather.weather!.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 40
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _WeatherIcon(condition: 'Clear'),
                                Text('${weather.weather!.main!.temp} F',
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
                                ),
                              ],
                            ),
                          ],
                        ):const SizedBox();
                      }
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({Key? key, required this.condition}) : super(key: key);

  static const _iconSize = 60.0;

  final String condition;



  @override
  Widget build(BuildContext context) {
    return Text(
      getEmoji(),
      style: const TextStyle(fontSize: _iconSize),
    );
  }

  String getEmoji(){
    switch (condition) {
      case 'Clear':
        return '☀️';
      case 'Rain':
        return '🌧️';
      case 'Drizzle':
        return '☁️';
      case 'Clouds':
        return '☁️';
      case 'Snow':
        return '🌨️';
      case 'Extreme':
      default:
        return '❓';
    }
  }
}