import 'package:flutter/foundation.dart';
import 'package:todotimer/utils/enums.dart';

Status parseStatus(String status) {
  if (describeEnum(Status.TODO) == status) {
    return Status.TODO;
  } else if (describeEnum(Status.DONE) == status) {
    return Status.DONE;
  } else if (describeEnum(Status.IN_PROGRESS) == status) {
    return Status.IN_PROGRESS;
  }
  throw Exception("Invalid task Status");
}
