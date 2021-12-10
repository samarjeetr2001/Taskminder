import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todotimer/app/home/presentation/home_view.dart';
import 'package:todotimer/app/splash_screen.dart';
import 'config/navigation_service.dart';
import 'core/injection_container.dart' as di;

void main() async {
  await di.init();
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: di.serviceLocator<NavigationService>().navigatorKey,
      onGenerateRoute: NavigationService.generateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: SplashScreen(),
    );
  }
}
