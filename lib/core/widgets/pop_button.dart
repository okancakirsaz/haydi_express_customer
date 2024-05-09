import 'package:flutter/material.dart';

import '../consts/color_consts/color_consts.dart';

class PopButton extends StatelessWidget {
  final VoidCallback onPressed;
  const PopButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back_ios,
        color: ColorConsts.instance.background,
      ),
    );
  }
}
