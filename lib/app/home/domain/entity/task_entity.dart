import 'package:flutter/foundation.dart';
import 'package:todotimer/core/database/models/task.dart';
import 'package:todotimer/utils/enums.dart';
import 'package:todotimer/utils/functions.dart';

class TaskEntity {
  final String id;
  final String title;
  final String? description;
  final DateTime createdDate;
  final Status status;
  final double durationInSec;

  TaskEntity({
    required this.id,
    required this.title,
    @required this.description,
    required this.createdDate,
    required this.status,
    required this.durationInSec,
  });

  static rowToEntity(Task task) {
    return new TaskEntity(
      id: task.id,
      title: task.title,
      description: task.description,
      createdDate: task.createdDate,
      status: parseStatus(task.status),
      durationInSec: task.durationInSec,
    );
  }
}
