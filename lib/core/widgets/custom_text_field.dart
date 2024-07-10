// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';

class CustomTextField extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final TextEditingController controller;
  final TextStyle? style;
  final String hint;
  final TextStyle? hintStyle;
  final bool? isReadOnly;
  final int? maxLength;
  final int? maxLine;
  final double? height;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? customInputFormatters;

  const CustomTextField({
    super.key,
    this.padding,
    required this.controller,
    this.style,
    this.isReadOnly,
    required this.hint,
    this.hintStyle,
    this.customInputFormatters,
    this.maxLength,
    this.keyboardType,
    this.maxLine,
    this.height,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.hint,
            style: widget.hintStyle ?? TextConsts.instance.regularWhite22,
          ),
          Container(
            height: widget.height ?? 50,
            decoration: BoxDecoration(
              color: _isFocused
                  ? ColorConsts.instance.background
                  : ColorConsts.instance.blurGrey,
              borderRadius: RadiusConsts.instance.circularAll10,
            ),
            child: TextFormField(
              onChanged: (_) {
                _isFocused = true;
                setState(() {});
              },
              maxLines: widget.maxLine ?? 1,
              keyboardType: widget.keyboardType,
              maxLength: widget.maxLength,
              textInputAction: TextInputAction.next,
              readOnly: widget.isReadOnly ?? false,
              inputFormatters: widget.customInputFormatters,
              cursorColor: Colors.black,
              style: widget.style ?? TextConsts.instance.regularBlack20,
              decoration: const InputDecoration(
                counter: SizedBox(),
                contentPadding: EdgeInsets.only(bottom: 5, left: 10),
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              controller: widget.controller,
            ),
          ),
        ],
      ),
    );
  }
}
