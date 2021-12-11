import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotimer/app/home/domain/usecase/get_tasks_usecase.dart';
import 'package:todotimer/app/home/domain/usecase/update_task_status_usecase.dart';
import 'package:todotimer/app/home/domain/usecase/update_task_timer_usecase.dart';
import 'package:todotimer/config/navigation_service.dart';
import 'package:todotimer/app/home/data/task_repository_impl.dart';
import 'package:todotimer/app/home/domain/repository/task_repository.dart';
import 'package:todotimer/app/home/domain/usecase/create_task_usecase.dart';
import 'package:todotimer/app/home/presentation/home_presenter.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton(() => NavigationService());
  serviceLocator
      .registerLazySingleton<TaskRepository>(() => (TaskRepositoryImpl()));
  serviceLocator.registerFactory(() => CreateTaskUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetTasksUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => UpdateTaskStatusUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => UpdateTaskTimerUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => HomePresenter(
      serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()));
}

Future<void> reset() async {
  serviceLocator.resetLazySingleton<TaskRepository>();
}
