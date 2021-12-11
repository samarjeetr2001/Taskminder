import 'package:flutter/foundation.dart';
import 'package:todotimer/utils/enums.dart';

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

}
