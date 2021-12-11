import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todotimer/app/home/presentation/home_view.dart';
import 'package:todotimer/app/splash_screen.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';
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
      theme: ThemeData(
        primarySwatch: createMaterialColor(CoreAppTheme.primaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
