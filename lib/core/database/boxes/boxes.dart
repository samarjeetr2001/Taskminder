import 'package:hive/hive.dart';
import 'package:todotimer/constants/db_keys.dart';
import 'package:todotimer/core/database/models/task.dart';

class Boxes {
  Future<void> openBoxes() async {
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>(DBKeys.boxNameTask);
    return;
  }

  static Box<Task> getTaskBox() => Hive.box<Task>(DBKeys.boxNameTask);
}
