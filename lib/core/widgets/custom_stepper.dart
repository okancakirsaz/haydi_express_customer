import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:horizontal_stepper_flutter/horizontal_stepper_flutter.dart';

class CustomStepper extends StatelessWidget {
  final List<String> steps;
  final int? currentStep;
  final double? width;
  final double? height;
  const CustomStepper(
      {super.key,
      required this.steps,
      this.currentStep,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50,
      child: FlutterHorizontalStepper(
        radius: 45,
        currentStepColor: ColorConsts.instance.primary,
        completeStepColor: ColorConsts.instance.primary,
        onClick: null,
        titleStyle: TextConsts.instance.regularBlack12,
        currentStep: currentStep ?? 1,
        steps: steps,
        child: _buildIcons(),
      ),
    );
  }

  List<Widget> _buildIcons() {
    List<Widget> icons = [];

    for (int i = 0; i <= steps.length - 1; i++) {
      icons.add(
        Text(
          (i + 1).toString(),
          style: TextConsts.instance.regularWhite16,
        ),
      );
    }

    return icons;
  }
}
