import 'package:ecloset/values/app_colors.dart';
import 'package:flutter/material.dart';

class FontFamily {
  static const nunito = "Nunito";
}

class AppStyles {
  static TextStyle h1 = const TextStyle(
      fontFamily: FontFamily.nunito, fontSize: 60, color: AppColors.textWhite);
  static TextStyle h2 = const TextStyle(
      fontFamily: FontFamily.nunito, fontSize: 24, color: AppColors.textWhite);
  static TextStyle h3 = const TextStyle(
      fontFamily: FontFamily.nunito, fontSize: 20, color: AppColors.textWhite);
  static TextStyle h4 = const TextStyle(
      fontFamily: FontFamily.nunito, fontSize: 16, color: AppColors.textWhite);
  static TextStyle h5 = const TextStyle(
      fontFamily: FontFamily.nunito, fontSize: 14, color: AppColors.textWhite);
}
