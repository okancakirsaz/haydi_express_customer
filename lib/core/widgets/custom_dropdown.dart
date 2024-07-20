import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuEntry> props;
  final String hint;
  final double? width;
  final TextStyle? style;
  final TextEditingController controller;
  const CustomDropdown(
      {super.key,
      required this.props,
      required this.hint,
      required this.controller,
      this.width,
      this.style});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      textStyle: style ?? TextConsts.instance.regularBlack16,
      menuStyle: MenuStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: RadiusConsts.instance.circularAll10,
          ),
        ),
      ),
      width: width,
      onSelected: (value) {
        controller.text = value;
      },
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        hintStyle: style ?? TextConsts.instance.regularBlack16,
        fillColor: ColorConsts.instance.blurGrey,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        activeIndicatorBorder: BorderSide(
          color: ColorConsts.instance.background,
        ),
      ),
      hintText: hint,
      requestFocusOnTap: false,
      controller: controller,
      dropdownMenuEntries: props,
    );
  }
}
