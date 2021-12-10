import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:todotimer/app/home/domain/repository/task_repository.dart';
import 'package:todotimer/utils/enums.dart';

class UpdateTaskStatusUsecase
    extends CompletableUseCase<UpdateTaskStatusUsecaseParams> {
  final TaskRepository _repository;
  UpdateTaskStatusUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.updateStatus(id: params!.id, status: params.status);
      streamController.close();
    } catch (error) {
      print(
          'error in updating task timer  : $error :  UpdateTaskStatusUsecase ');
      streamController.addError(error);
    }
    return streamController.stream;
  }
}

class UpdateTaskStatusUsecaseParams {
  final String id;
  final Status status;

  UpdateTaskStatusUsecaseParams({required this.id, required this.status});
}
