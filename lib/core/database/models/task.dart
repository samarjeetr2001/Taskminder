import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:todotimer/utils/enums.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime createdDate;

  @HiveField(4)
  final String status = describeEnum(Status.TODO);

  @HiveField(5)
  final double durationInSec;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.durationInSec,
  });
}
