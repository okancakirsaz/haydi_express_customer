part of '../chat_view.dart';

class ChatText extends StatelessWidget {
  final bool isUserTheSender;
  final String text;
  const ChatText(
      {super.key, required this.isUserTheSender, required this.text});

  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(20);
    return Align(
      alignment: isUserTheSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: PaddingConsts.instance.all10,
        margin: PaddingConsts.instance.all5,
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 250,
          minHeight: 40,
        ),
        decoration: BoxDecoration(
          color: isUserTheSender
              ? ColorConsts.instance.lightThird
              : ColorConsts.instance.primary,
          borderRadius: BorderRadius.only(
            topLeft: isUserTheSender ? const Radius.circular(20) : Radius.zero,
            topRight: isUserTheSender ? Radius.zero : radius,
            bottomLeft: radius,
            bottomRight: radius,
          ),
          boxShadow: ColorConsts.instance.shadow,
        ),
        child: Text(
          text,
          style: TextConsts.instance.regularWhite16,
        ),
      ),
    );
  }
}
