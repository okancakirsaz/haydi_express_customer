import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

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
