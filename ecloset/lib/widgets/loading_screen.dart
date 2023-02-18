import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Constant/app_colors.dart';

loadingScreen(context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: SpinKitFadingCircle(
              size: 50,
              color: AppColors.secondaryColor,
            ),
          ),
        );
      });
}
