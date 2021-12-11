import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/domain/repository/task_repository.dart';

class GetTasksUsecase extends CompletableUseCase<void> {
  final TaskRepository _repository;
  GetTasksUsecase(this._repository);

  @override
  Future<Stream<List<TaskEntity>>> buildUseCaseStream(params) async {
    return _repository.getTasks();
  }
}
