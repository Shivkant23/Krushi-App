import 'dart:async';

import 'package:farmer_app/ui/home_screen.dart';
import 'package:farmer_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    startTimeout();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, () => Navigator.of(context).pushReplacementNamed(HomeScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const Text('Farmer', style: TextStyle(fontSize: 40, fontFamily: 'RaleWay', fontWeight: FontWeight.bold)),
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
              height: MediaQuery.of(context).size.width * 0.70,
              alignment: Alignment.center,
              child: Image.asset('assets/splash_image.png'),
            ),
          ],
        ),
      ),
    );
  }
}