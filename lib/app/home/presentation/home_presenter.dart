import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:todotimer/app/home/domain/usecase/update_task_status_usecase.dart';
import 'package:todotimer/app/home/domain/usecase/update_task_timer_usecase.dart';
import 'package:todotimer/core/observer.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/domain/usecase/create_task_usecase.dart';
import 'package:todotimer/utils/enums.dart';

class HomePresenter extends Presenter {
  final CreateTaskUsecase _createTaskUsecase;
  final UpdateTaskTimerUsecase _updateTaskTimerUsecase;
  final UpdateTaskStatusUsecase _updateTaskStatusUsecase;

  HomePresenter(this._createTaskUsecase, this._updateTaskTimerUsecase,
      this._updateTaskStatusUsecase);

  @override
  dispose() {
    _createTaskUsecase.dispose();
    _updateTaskTimerUsecase.dispose();
    _updateTaskTimerUsecase.dispose();
  }

  void createTask(UseCaseObserver observer, {required TaskEntity task}) {
    _createTaskUsecase.execute(observer, task);
  }

  void updateTaskTimer(UseCaseObserver observer,
      {required String id, required double durationInSec}) {
    _updateTaskTimerUsecase.execute(
      observer,
      new UpdateTaskTimerUsecaseParams(id: id, durationInSec: durationInSec),
    );
  }

  void updateTaskStatus(UseCaseObserver observer,
      {required String id, required Status status}) {
    _updateTaskStatusUsecase.execute(
      observer,
      new UpdateTaskStatusUsecaseParams(id: id, status: status),
    );
  }
}
