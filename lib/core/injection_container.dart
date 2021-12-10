import 'package:get_it/get_it.dart';
import 'package:todotimer/config/navigation_service.dart';
import 'package:todotimer/app/home/data/task_repository_impl.dart';
import 'package:todotimer/app/home/domain/repository/task_repository.dart';
import 'package:todotimer/app/home/domain/usecase/create_task.dart';
// import 'package:todotimer/app/home/domain/usecase/get_tasks_usecase.dart';
import 'package:todotimer/app/home/presentation/home_presenter.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton(() => NavigationService());
  serviceLocator
      .registerLazySingleton<TaskRepository>(() => (TaskRepositoryImpl()));
  // serviceLocator.registerFactory(() => GetTasksUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => CreateTaskUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => HomePresenter(serviceLocator()));
}

Future<void> reset() async {
  // serviceLocator.resetLazySingleton<AuthenticationRepository>();
}
