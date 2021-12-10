import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:todotimer/core/database/boxes/boxes.dart';
import 'package:todotimer/core/database/models/task.dart';
import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/app/home/domain/repository/task_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:todotimer/utils/enums.dart';

class TaskRepositoryImpl extends TaskRepository {
  final Box<Task> _taskBox = Boxes.getTaskBox();

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
  }

  @override
  Future<void> updateStatus(
      {required String id, required Status status}) async {
    Task? task = _taskBox.get(id);
    if (task != null) {
      task.status = describeEnum(status);
      await task.save();
    }
  }

  @override
  Future<void> updateTimer(
      {required String id, required double durationInSec}) async {
    Task? task = _taskBox.get(id);
    if (task != null) {
      task.durationInSec = durationInSec;
      await task.save();
    }
  }
}
