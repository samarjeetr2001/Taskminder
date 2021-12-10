import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:todotimer/core/observer.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/domain/usecase/create_task.dart';
// import 'package:todotimer/app/home/domain/usecase/get_tasks_usecase.dart';

class HomePresenter extends Presenter {
  // final GetTasksUsecase _getTasksUsecase;
  final CreateTaskUsecase _createTaskUsecase;
  HomePresenter(//this._getTasksUsecase , 
  this._createTaskUsecase);

  @override
  dispose() {
    // _getTasksUsecase.dispose();
    _createTaskUsecase.dispose();
  }

  // void getTasks(UseCaseObserver observer) {
  //   _getTasksUsecase.execute(observer);
  // }

  void createTask(UseCaseObserver observer, {required TaskEntity task}) {
    _createTaskUsecase.execute(observer, task);
  }
}
