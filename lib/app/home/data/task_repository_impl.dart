import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:todotimer/core/database/boxes/boxes.dart';
import 'package:todotimer/core/database/models/task.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/domain/repository/task_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:todotimer/utils/enums.dart';
import 'package:todotimer/utils/functions.dart';

class TaskRepositoryImpl extends TaskRepository {
  final Box<Task> _taskBox = Boxes.getTaskBox();
  final StreamController<List<TaskEntity>> tasksStream = new StreamController();

  @override
  Future<void> createTask({required TaskEntity task}) async {
    await _taskBox.put(
      task.id,
      Task(
        id: task.id,
        title: task.title,
        description: task.description ?? '',
        createdDate: task.createdDate,
        durationInSec: task.durationInSec,
      ),
    );
    tasksStream.add(getAllTasks());
  }

  @override
  Future<void> updateStatus(
      {required String id, required Status status}) async {
    Task? task = _taskBox.get(id);
    if (task != null) {
      task.status = describeEnum(status);
      await task.save();
      tasksStream.add(getAllTasks());
    }
  }

  @override
  Future<void> updateTimer(
      {required String id, required double durationInSec}) async {
    Task? task = _taskBox.get(id);
    if (task != null) {
      task.durationInSec = durationInSec;
      await task.save();
      tasksStream.add(getAllTasks());
    }
  }

  @override
  Future<Stream<List<TaskEntity>>> getTasks() async {
    try {
      List<TaskEntity> tasks = getAllTasks();
      tasksStream.add(tasks);
    } catch (error) {
      tasksStream.addError(error);
    }
    return tasksStream.stream;
  }

  List<TaskEntity> getAllTasks() {
    List<Task> _tasks = _taskBox.values.toList().cast<Task>();
    List<TaskEntity> tasks = [];
    _tasks.forEach((task) {
      tasks.add(new TaskEntity(
        id: task.id,
        title: task.title,
        description: task.description,
        createdDate: task.createdDate,
        status: parseStatus(task.status),
        durationInSec: task.durationInSec,
      ));
    });
    return tasks;
  }
}
