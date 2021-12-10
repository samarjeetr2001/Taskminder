import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/domain/repository/task_repository.dart';

class CreateTaskUsecase extends CompletableUseCase<TaskEntity> {
  final TaskRepository _repository;
  CreateTaskUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.createTask(task: params!);
      streamController.close();
    } catch (error) {
      print('error in creating task : $error :  CreateTaskUsecase ');
      streamController.addError(error);
    }
    return streamController.stream;
  }
}
