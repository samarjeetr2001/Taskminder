import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:todotimer/utils/enums.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late DateTime createdDate;

  @HiveField(4)
  late String status = describeEnum(Status.TODO);

  @HiveField(5)
  late double durationInSec;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.durationInSec,
  });
}
