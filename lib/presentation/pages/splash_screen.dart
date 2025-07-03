import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(StringManager.appTitle),
          Text(StringManager.splashDescription),
          Image.asset(AssetsManager.logo),
        ],
      ),
    );
  }
}
