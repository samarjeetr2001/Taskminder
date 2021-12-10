import 'package:get_it/get_it.dart';
import 'package:todotimer/config/navigation_service.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton(() => NavigationService());
  // serviceLocator.registerLazySingleton<AuthenticationRepository>(
  //     () => (AuthenticationRepositoryImpl()));
  // serviceLocator
  //     .registerFactory(() => VerifyPhoneNumberUsecase(serviceLocator()));
  // serviceLocator.registerFactory(() => SplashScreenPresenter(serviceLocator()));
}

Future<void> reset() async {
  // serviceLocator.resetLazySingleton<AuthenticationRepository>();
}
