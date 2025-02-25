import 'package:aljoud_hospital/presntation/screens/home/appBar/home_appBar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                HomeAppBar(),

              ],
            )
        ),
    );
  }
}
