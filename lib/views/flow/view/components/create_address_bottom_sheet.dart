part of '../flow_view.dart';

class CreateAddressBottomSheet extends StatelessWidget {
  final FlowViewModel viewModel;
  const CreateAddressBottomSheet({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      expand: false,
      builder: (context, controller) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
              color: ColorConsts.instance.third,
              boxShadow: ColorConsts.instance.shadow,
              borderRadius: RadiusConsts.instance.circularTop50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Kayıtlı Adresiniz Bulunmamakta",
                  style: TextConsts.instance.regularWhite20Bold,
                ),
                Text(
                  "Adres eklemek ister misiniz?",
                  style: TextConsts.instance.regularWhite16,
                ),
                Padding(
                  padding: PaddingConsts.instance.top40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomButton(
                        onPressed: () {
                          viewModel.navigatorPop();
                          viewModel.navigationManager
                              .navigate(const CreateEditAddressView());
                        },
                        text: "Evet",
                        style: TextConsts.instance.regularWhite16,
                        height: 40,
                        width: 145,
                      ),
                      CustomButton(
                        onPressed: () => viewModel.navigatorPop(),
                        text: "Daha Sonra",
                        style: TextConsts.instance.regularWhite16,
                        height: 40,
                        width: 145,
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
