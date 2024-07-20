import 'package:flutter/material.dart';

import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  const CustomScaffold(
      {super.key, required this.body, this.appBar, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConsts.instance.background,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: body,
    );
  }
}
