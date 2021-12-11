import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';
import 'package:todotimer/config/navigation_service.dart';
import 'package:todotimer/constants/db_keys.dart';
import 'package:todotimer/core/database/boxes/boxes.dart';
import 'package:todotimer/core/injection_container.dart';
import 'package:todotimer/utils/enums.dart';

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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(DBKeys.taskListViewKey) == null) {
      await sharedPreferences.setString(
          DBKeys.taskListViewKey, describeEnum(TaskListView.LIST));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9B433),
      body: Center(
        child: Container(
            height: 300,
            width: 300,
            child: Image.asset("assets/images/splash-screen.jpg")),
      ),
    );
  }
}
