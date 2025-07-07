import 'package:fit_track/core/presentation/resources/assets_manager.dart';
import 'package:fit_track/core/presentation/resources/fonts_manager.dart';
import 'package:fit_track/core/presentation/resources/string_manager.dart';
import 'package:fit_track/core/presentation/utils/screen_size_helper.dart';
import 'package:fit_track/presentation/cubits/initialization/initialization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<InitializationCubit>().initialize(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: ScreenSizeHelper.height_P(context, 0.25)),
          Text(StringManager.appTitle, style: FontsManager.lexendBold()),
          SizedBox(height: 5),
          Center(
            child: Text(
              StringManager.splashDescription,
              style: FontsManager.lexendRegular(size: 17),
            ),
          ),
          SizedBox(height: 30),
          Image.asset(AssetsManager.logo, scale: 0.8),
        ],
      ),
    );
  }
}
