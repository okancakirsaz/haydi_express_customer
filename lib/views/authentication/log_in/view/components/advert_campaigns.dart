part of '../log_in_view.dart';

class AdvertCampaign extends StatelessWidget {
  final LogInViewModel viewModel;

  const AdvertCampaign({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: viewModel.fetchAdverts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              padding: PaddingConsts.instance.all10,
              decoration: BoxDecoration(
                color: ColorConsts.instance.lightThird,
                boxShadow: ColorConsts.instance.shadow,
                borderRadius: RadiusConsts.instance.circularTop50,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Haydi Fırsatlar",
                    style: TextConsts.instance.regularWhite25Bold,
                  ),
                  Expanded(
                    child: Padding(
                      padding: PaddingConsts.instance.top20,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: viewModel.haydiFirsatlar.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: index % 2 == 0
                                ? PaddingConsts.instance.right50
                                : PaddingConsts.instance.left50,
                            child: AdvertCampaignContainer(
                              viewModel: viewModel,
                              data: viewModel.haydiFirsatlar[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
