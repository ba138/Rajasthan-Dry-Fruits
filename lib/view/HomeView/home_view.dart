import 'package:flutter/material.dart';

import '../../res/components/colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('HomeView...')],
        ),
      ),
    );
  }
}
