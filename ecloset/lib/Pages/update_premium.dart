import 'package:ecloset/Constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdatePremierum extends StatelessWidget {
  const UpdatePremierum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Premium"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/premium.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
