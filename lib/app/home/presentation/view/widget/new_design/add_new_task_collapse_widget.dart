import 'package:flutter/material.dart';
import 'package:todotimer/config/app-theme/app_theme.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';

Widget addNewTaskCollapseWidget() {
  return Padding(
    padding: const EdgeInsets.only(left: CoreAppTheme.largeSize),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            bottom: CoreAppTheme.smallSize,
            top: CoreAppTheme.mediumSize,
          ),
          child: Text(
            "Task",
            style: AppTheme.textStyleTitle
                .copyWith(fontSize: CoreAppTheme.fontSizeExtraLarge),
          ),
        ),
        Container(
          child: Text('Select duration to add new task',
              style: AppTheme.textStyleNormal
                  .copyWith(fontSize: CoreAppTheme.fontSizeSmall)),
        ),
      ],
    ),
  );
}
