import 'package:flutter/material.dart';
import 'package:todotimer/config/navigation_service.dart';
import 'package:todotimer/core/database/boxes/boxes.dart';
import 'package:todotimer/core/injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getBox();
    super.initState();
  }

  Future<void> getBox() async {
    Boxes box = new Boxes();
    await box.openBoxes();
    NavigationService _navigationService = serviceLocator<NavigationService>();
    _navigationService.navigateTo(NavigationService.homeRoute,
        shouldReplace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
