import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todotimer/config/app-theme/core_app_theme.dart';

class AppTheme {
  static final TextStyle textStyleTitle = GoogleFonts.openSans(
    color: Colors.black87,
    fontSize: CoreAppTheme.fontSizeLarge,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle textStyleSubtitle = GoogleFonts.openSans(
    color: Colors.black54,
    fontSize: CoreAppTheme.fontSizeRegular,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle textStyleNormal = GoogleFonts.openSans(
    color: Colors.black87,
    fontSize: CoreAppTheme.fontSizeRegular,
    fontWeight: FontWeight.w600,
  );

  static final BoxDecoration boxDecorationListTile = BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.all(Radius.circular(CoreAppTheme.smallSize)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(2, 2),
        blurRadius: 10,
        spreadRadius: 2,
      )
    ],
  );

  static final BoxDecoration boxDecorationNormal = BoxDecoration(
      border: Border.all(color: CoreAppTheme.primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(5)));
}
