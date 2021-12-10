import 'package:todotimer/app/home/domain/entity/task_entity.dart';
import 'package:todotimer/utils/enums.dart';

abstract class TaskRepository {
  Future<void> createTask({required TaskEntity task});
  // Future<ValueListenable<Box<Task>>> getTasks();
  Future<void> updateTimer({required String id, required double durationInSec});
  Future<void> updateStatus({required String id, required Status status});
}
