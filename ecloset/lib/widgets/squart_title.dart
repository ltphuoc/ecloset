import 'package:flutter/material.dart';

class MyCustomWidget extends StatelessWidget {
  final String imagePath;
  final double height;
  const MyCustomWidget({
    super.key,
    required this.imagePath,
    required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(199, 200, 210, 1)),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      child: Image.asset(
        imagePath,
        height: height,
      ),
    );
  }
}
