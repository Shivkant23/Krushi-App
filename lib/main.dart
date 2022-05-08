import 'package:farmer_app/core/view_models/Farmer_data_viewmodel.dart';
import 'package:farmer_app/core/view_models/weather_view_model.dart';
import 'package:farmer_app/ui/splash_screen.dart';
import 'package:farmer_app/utils/colors.dart';
import 'package:farmer_app/utils/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FarmerDataViewModel()),
        ChangeNotifierProvider(create: (context) => WeatherViewModel())
      ],
      child: MaterialApp(
        title: 'Farmer App',
        theme: ThemeData(
          primarySwatch: primaryColor,
        ),
        home: SplashScreen(),
        onGenerateRoute: router.Router.generateRoute,
      ),
    );
  }
}