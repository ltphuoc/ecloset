import 'package:ecloset/Constant/app_colors.dart';
import 'package:flutter/material.dart';

class OutfitDetailPage extends StatefulWidget {
  const OutfitDetailPage({Key? key}) : super(key: key);

  @override
  _OutfitDetailPageState createState() => _OutfitDetailPageState();
}

class _OutfitDetailPageState extends State<OutfitDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: AppBar(
        title: const Text("OutFit Detail"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        // color: Color(0xffF7F3E9),
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/outfit_detail.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
