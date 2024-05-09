part of '../sign_up_view.dart';

class PersonalDataInputs extends StatelessWidget {
  final SignUpViewModel viewModel;
  const PersonalDataInputs({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: PopButton(
            onPressed: () => viewModel.setCurrentBody(
                SimpleDataInputs(viewModel: viewModel), 1),
          ),
        ),
        _buildInputs(),
      ],
    );
  }

  Widget _buildInputs() {
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
            controller: viewModel.nameSurname,
            hint: "İsim Soyisim",
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.top20,
          child: CustomTextField(
            padding: PaddingConsts.instance.horizontal30,
            controller: viewModel.phoneNumber,
            customInputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 10,
            hint: "Telefon Numarası",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: PaddingConsts.instance.horizontal30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomDropdown(
                width: 200,
                props: const [
                  DropdownMenuEntry(value: "Erkek", label: "Erkek"),
                  DropdownMenuEntry(value: "Kadın", label: "Kadın"),
                  DropdownMenuEntry(
                    value: "Belirtmek İstemiyorum",
                    label: "Belirtmek İstemiyorum",
                  ),
                ],
                hint: "Cinsiyet",
                controller: viewModel.gender,
              ),
            ],
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.top20,
          child: CustomButton(
            onPressed: () => viewModel.setCurrentBody(
              MailVerify(viewModel: viewModel),
              3,
              viewModel.validatePersonalInputs,
            ),
            text: "Devam Et",
          ),
        ),
      ],
    );
  }
}
