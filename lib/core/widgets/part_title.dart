import 'package:flutter/material.dart';

import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

class PartTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  const PartTitle({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ListTile(
        leading: Text(
          title,
          style: TextConsts.instance.regularBlack18Bold,
        ),
        title: Text(
          subtitle != null ? "- $subtitle" : "",
          style: TextConsts.instance.regularBlack14,
        ),
      ),
    );
  }
}
