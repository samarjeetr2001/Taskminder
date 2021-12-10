import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:todotimer/utils/enums.dart';

Status parseStatus(String status) {
  if (describeEnum(Status.TODO) == status) {
    return Status.TODO;
  } else if (describeEnum(Status.DONE) == status) {
    return Status.DONE;
  } else if (describeEnum(Status.IN_PROGRESS) == status) {
    return Status.IN_PROGRESS;
  } else if (describeEnum(Status.ON_HOLD) == status) {
    return Status.ON_HOLD;
  }
  throw Exception("Invalid task Status");
}

var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
