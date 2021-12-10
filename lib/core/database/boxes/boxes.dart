import 'package:hive/hive.dart';
import 'package:todotimer/constants/db_keys.dart';
import 'package:todotimer/core/database/models/task.dart';

class Boxes {
  Future<void> openBoxes() async {
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>(DBKeys.BoxNameTask);
    return;
  }

  static Box<Task> getTaskBox() => Hive.box<Task>(DBKeys.BoxNameTask);
}
