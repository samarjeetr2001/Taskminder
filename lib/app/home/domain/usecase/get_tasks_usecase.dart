// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
// import 'package:hive/hive.dart';
// import 'package:todotimer/app/home/domain/entity/task_entity.dart';
// import 'package:todotimer/app/home/domain/repository/task_repository.dart';
// import 'package:todotimer/core/database/models/task.dart';

// class GetTasksUsecase extends CompletableUseCase<void> {
//   final TaskRepository _repository;
//   GetTasksUsecase(this._repository);

//   @override
//   Future<Stream<ValueListenable<Box<Task>>>> buildUseCaseStream(params) async {
//     final StreamController<ValueListenable<Box<Task>>> streamController =
//         StreamController();
//     try {
//       ValueListenable<Box<Task>> _task = await _repository.getTasks();
//       streamController.add(_task);
//       streamController.close();
//     } catch (error) {
//       print('error in creating task : $error :  CreateTaskUsecase ');
//       streamController.addError(error);
//     }
//     return streamController.stream;
//   }
// }
