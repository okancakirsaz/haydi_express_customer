import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
        body: Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Center(
          child: Hero(tag: "logoHero", child: Logo()),
        ),
      ),
    ));
  }
}
