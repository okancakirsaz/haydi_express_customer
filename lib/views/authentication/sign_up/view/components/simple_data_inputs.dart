part of '../sign_up_view.dart';

class SimpleDataInputs extends StatelessWidget {
  final SignUpViewModel viewModel;
  const SimpleDataInputs({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: PopButton(
            onPressed: () => viewModel.navigatorPop(),
          ),
        ),
        Align(alignment: Alignment.center, child: _buildInputs(context))
      ],
    );
  }

  Widget _buildCheckBoxTitle(
    BuildContext context,
    VoidCallback onTap,
    String middleText,
  ) {
    return InkWell(
      //TODO: Do navigating
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        child: RichText(
            text: TextSpan(
                style: TextConsts.instance.regularWhite16,
                text: "Haydi Express ",
                children: <TextSpan>[
              TextSpan(
                text: "$middleText ",
                style: TextConsts.instance.regularPrimary16Underlined,
              ),
              TextSpan(
                text: "okudum ve kabul ediyorum.",
                style: TextConsts.instance.regularWhite16,
              ),
            ])),
      ),
    );
  }

  Widget _buildInputs(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LogoBar(
          title: "Kayıt Ol",
        ),
        Padding(
          padding: PaddingConsts.instance.top20,
          child: CustomTextField(
            padding: PaddingConsts.instance.horizontal30,
            controller: viewModel.email,
            hint: "E-Posta",
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.top20,
          child: CustomTextField(
            padding: PaddingConsts.instance.horizontal30,
            controller: viewModel.password,
            hint: "Şifre",
          ),
        ),
        const SizedBox(height: 5),
        Observer(
          builder: (context) {
            return CustomCheckbox(
              value: viewModel.isAgreementAccepted,
              onChanged: (data) =>
                  viewModel.setCheckboxState(data ?? false, isPolicies: false),
              titleWidget:
                  _buildCheckBoxTitle(context, () {}, "kullanıcı sözleşmesini"),
            );
          },
        ),
        Observer(
          builder: (context) {
            return CustomCheckbox(
              value: viewModel.isPoliciesAccepted,
              onChanged: (data) =>
                  viewModel.setCheckboxState(data ?? false, isPolicies: true),
              titleWidget:
                  _buildCheckBoxTitle(context, () {}, "gizlilik politikasını"),
            );
          },
        ),
        Padding(
          padding: PaddingConsts.instance.top10,
          child: CustomButton(
            onPressed: () => viewModel.setCurrentBody(
              PersonalDataInputs(viewModel: viewModel),
              2,
              viewModel.validateSimpleInputs,
            ),
            text: "Devam Et",
          ),
        ),
      ],
    );
  }
}
