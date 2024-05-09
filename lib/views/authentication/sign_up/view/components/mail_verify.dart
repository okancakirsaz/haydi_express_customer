part of '../sign_up_view.dart';

class MailVerify extends StatefulWidget {
  final SignUpViewModel viewModel;
  const MailVerify({super.key, required this.viewModel});

  @override
  State<MailVerify> createState() => _MailVerifyState();
}

class _MailVerifyState extends State<MailVerify> {
  @override
  void initState() {
    widget.viewModel.changeExpand(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: PopButton(onPressed: () {
            widget.viewModel.changeExpand(3);
            widget.viewModel.setCurrentBody(
              PersonalDataInputs(viewModel: widget.viewModel),
              2,
            );
          }),
        ),
        Padding(
          padding: PaddingConsts.instance.all20,
          child: Text(
            "Mail Adresinize Gelen Dört Haneli Kodu Giriniz",
            style: TextConsts.instance.regularWhite20Bold,
            textAlign: TextAlign.center,
          ),
        ),
        _buildPinput(),
        Padding(
          padding: PaddingConsts.instance.top20,
          child: CustomTextButton(
            onPressed: () {},
            style: TextConsts.instance.regularWhite20,
            text: "Kodu Tekrar Gönder",
          ),
        )
      ],
    );
  }

  Widget _buildPinput() {
    return Pinput(
      showCursor: true,
      controller: widget.viewModel.verifyCode,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: ColorConsts.instance.blurGrey,
          borderRadius: RadiusConsts.instance.circularAll10,
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: ColorConsts.instance.background,
          borderRadius: RadiusConsts.instance.circularAll10,
        ),
      ),
      length: 4,
      onCompleted: (value) {},
    );
  }
}
