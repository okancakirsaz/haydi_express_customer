part of '../order_steps_view.dart';

class OrderStepsFinalPage extends StatelessWidget {
  final bool isSuccess;
  final String? errorReason;
  final OrderStepsViewModel viewModel;
  const OrderStepsFinalPage(
      {super.key,
      required this.isSuccess,
      this.errorReason,
      required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.all10,
            child: Text(
              isSuccess ? "TEŞEKKÜRLER!" : "ÜZGÜNÜZ!",
              style: TextConsts.instance.regularBlack25Bold,
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.all20,
            child: Text(
              isSuccess
                  ? "Siparişiniz alınmış olup en kısa sürede size ulaştırılacaktır."
                  : "$errorReason nedeniyle siparişiniz alınamamıştır",
              textAlign: TextAlign.center,
              style: TextConsts.instance.regularBlack16,
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.all20,
            child: SvgPicture.asset(
              isSuccess
                  ? AssetConsts.instance.success
                  : AssetConsts.instance.error,
            ),
          ),
          isSuccess
              ? Padding(
                  padding: PaddingConsts.instance.all20,
                  child: Text(
                    "Siparişinizi “Profil” sekmesinde bulunan “Siparişlerim” kısmında görüntüleyebilirsiniz.",
                    style: TextConsts.instance.regularBlack16,
                    textAlign: TextAlign.center,
                  ),
                )
              : Padding(
                  padding: PaddingConsts.instance.all20,
                  child: CustomButton(
                    onPressed: () => viewModel.navigatorPop(),
                    text: "Siparişi Düzenle",
                    width: 220,
                    style: TextConsts.instance.regularWhite20,
                    gradient: ColorConsts.instance.primaryGradient,
                  ),
                ),
          CustomButton(
            onPressed: () async => await viewModel.returnToMainView(),
            text: "Ana Sayfa",
            width: 200,
            style: TextConsts.instance.regularWhite20,
            gradient: ColorConsts.instance.thirdGradient,
          ),
        ],
      ),
    );
  }
}
