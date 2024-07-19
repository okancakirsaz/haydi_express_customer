part of '../profile_view.dart';

class PersonalData extends StatelessWidget {
  final ProfileViewModel viewModel;
  const PersonalData({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final double btnWidth = MediaQuery.of(context).size.width / 2 - 20;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const PartTitle(
          title: "Profilim",
          subtitle: "Kişisel Bilgiler",
        ),
        _buildTextField(
          PersonalValueTypes.phoneNumber,
          viewModel.phoneNumber,
        ),
        _buildTextField(
          PersonalValueTypes.email,
          viewModel.email,
        ),
        _buildTextField(
          PersonalValueTypes.nameSurname,
          viewModel.nameSurname,
        ),
        Padding(
          padding: PaddingConsts.instance.top20,
          child: Row(
            children: <Widget>[
              Padding(
                padding: PaddingConsts.instance.all10,
                child: CustomStateFullButton(
                  onPressed: () async => await viewModel.changePassword(),
                  style: TextConsts.instance.regularWhite18,
                  text: "Şifre Değiştir",
                  width: btnWidth,
                ),
              ),
              Padding(
                padding: PaddingConsts.instance.all5,
                child: CustomStateFullButton(
                  onPressed: () async => await viewModel.deleteCardData(),
                  style: TextConsts.instance.regularWhite14,
                  text: "Kayıtlı Kart Verilerini Sil",
                  gradient: ColorConsts.instance.thirdGradient,
                  width: btnWidth + 10,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: PaddingConsts.instance.all10,
              child: CustomStateFullButton(
                onPressed: () => viewModel.showAreYouSureDialog(),
                style: TextConsts.instance.regularWhite18,
                text: "Hesabı Sil",
                width: btnWidth,
              ),
            ),
            Padding(
              padding: PaddingConsts.instance.all10,
              child: CustomStateFullButton(
                onPressed: () async => await viewModel.logOut(),
                style: TextConsts.instance.regularWhite18,
                text: "Çıkış Yap",
                width: btnWidth,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
      PersonalValueTypes valueType, TextEditingController controller) {
    return Row(
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.horizontal10,
          child: SizedBox(
            width: 200,
            child: CustomTextField(
              padding: PaddingConsts.instance.left5,
              controller: controller,
              hint: "",
              style: TextConsts.instance.regularBlack14,
            ),
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.top30,
          child: CustomStateFullButton(
            onPressed: () async =>
                await viewModel.changePersonalValue(valueType),
            width: 100,
            style: TextConsts.instance.regularWhite16,
            text: valueType == PersonalValueTypes.phoneNumber
                ? "Doğrula"
                : "Kaydet",
          ),
        ),
      ],
    );
  }
}
