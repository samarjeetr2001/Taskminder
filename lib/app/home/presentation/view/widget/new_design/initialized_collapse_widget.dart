import 'package:flutter/material.dart';
import 'package:todotimer/config/app-theme/app_theme.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';

Widget initializedCollapseWidget(int count) {
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
            "Taskminder",
            style: AppTheme.textStyleTitle
                .copyWith(fontSize: CoreAppTheme.fontSizeExtraLarge),
          ),
        ),
        Text("Total task in your list: $count",
            style: AppTheme.textStyleNormal),
      ],
    ),
  );
}
