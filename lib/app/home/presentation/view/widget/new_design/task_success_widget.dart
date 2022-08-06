import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todotimer/app/home/presentation/home_view.dart';

class TaskSuccessWidget extends StatefulWidget {
  @override
  State<TaskSuccessWidget> createState() => _TaskSuccessWidgetState();
}

class _TaskSuccessWidgetState extends State<TaskSuccessWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 1),
      () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeView()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/success.json'),
      ),
    );
  }
}
