import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonWidget extends StatelessWidget {
  final Widget widget;
  final int? count;
  final Axis? scrollDirection;
  const SkeletonWidget(
      {super.key, required this.widget, this.count, this.scrollDirection});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: count ?? 10,
        scrollDirection: scrollDirection ?? Axis.horizontal,
        itemBuilder: (context, index) {
          return widget;
        },
      ),
    );
  }
}
