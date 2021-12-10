import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:todotimer/app/home/domain/repository/task_repository.dart';

class UpdateTaskTimerUsecase
    extends CompletableUseCase<UpdateTaskTimerUsecaseParams> {
  final TaskRepository _repository;
  UpdateTaskTimerUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.updateTimer(
          id: params!.id, durationInSec: params.durationInSec);
      streamController.close();
    } catch (error) {
      print('error in updating task timer : $error :  UpdateTaskTimerUsecase ');
      streamController.addError(error);
    }
    return streamController.stream;
  }
}

class UpdateTaskTimerUsecaseParams {
  final String id;
  final double durationInSec;

  UpdateTaskTimerUsecaseParams({required this.id, required this.durationInSec});
}
