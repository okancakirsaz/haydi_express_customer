import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

class AreYouSure extends StatelessWidget {
  final VoidCallback onPressed;
  final String? question;
  final Widget? description;
  const AreYouSure(
      {super.key, required this.onPressed, this.question, this.description});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConsts.instance.third,
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              question ?? "Emin misiniz? ",
              style: TextConsts.instance.regularWhite20Bold,
            ),
            Padding(
              padding: PaddingConsts.instance.top10,
              child: description ?? const SizedBox(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildSpecialButton(onPressed, "Evet"),
                buildSpecialButton(() => Navigator.pop(context), "Hayır"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildSpecialButton(VoidCallback onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(ColorConsts.instance.primary),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: RadiusConsts.instance.circularAll10),
        ),
      ),
      child: Text(
        text,
        style: TextConsts.instance.regularWhite16Bold,
      ),
    );
  }
}
