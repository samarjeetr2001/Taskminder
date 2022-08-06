import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:todotimer/config/app-theme/app_theme.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';

Widget durationWidget(Function(double) onChange) {
  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  return SizedBox(
    width: double.infinity,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: CoreAppTheme.largeSize,
              bottom: CoreAppTheme.smallSize,
              top: CoreAppTheme.mediumSize,
            ),
            child: Text(
              "Reminder",
              style: AppTheme.textStyleTitle
                  .copyWith(fontSize: CoreAppTheme.fontSizeExtraLarge),
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: SleekCircularSlider(
              min: 60,
              initialValue: 300,
              max: 600,
              appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(
                  trackWidth: 4,
                  progressBarWidth: 20,
                  shadowWidth: 20,
                ),
                customColors: CustomSliderColors(
                  dotColor: CoreAppTheme.primaryColor,
                  trackColor: Colors.grey,
                  progressBarColors: [
                    Color(0xfff4a8a4),
                    CoreAppTheme.redShadeColor,
                  ],
                  shadowColor: Colors.grey,
                  shadowMaxOpacity: 0.05,
                ),
                infoProperties: InfoProperties(
                  topLabelStyle: AppTheme.textStyleNormal.copyWith(
                    fontSize: CoreAppTheme.fontSizeSmall,
                  ),
                  topLabelText: 'Duration',
                  bottomLabelStyle: AppTheme.textStyleNormal.copyWith(
                    fontSize: CoreAppTheme.fontSizeSmall,
                  ),
                  bottomLabelText: 'in minutes',
                  mainLabelStyle:
                      AppTheme.textStyleTitle.copyWith(fontSize: 48),
                  modifier: (double value) {
                    final time =
                        printDuration(Duration(seconds: value.toInt()));
                    return '$time';
                  },
                ),
                startAngle: 270,
                angleRange: 360,
                size: 250.0,
              ),
              onChange: onChange,
            ),
          ),
        ],
      ),
    ),
  );
}
