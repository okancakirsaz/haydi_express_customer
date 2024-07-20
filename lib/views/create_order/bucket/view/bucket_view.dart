import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/models/bucket_element_model.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/menu/discount_container.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/bucket_viewmodel.dart';

part './components/bucket_element.dart';

class BucketView extends StatelessWidget {
  const BucketView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BucketViewModel>(
        viewModel: BucketViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
              body: model.bucket.isEmpty
                  ? Center(child: _emptyState())
                  : _listView(model));
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          AssetConsts.instance.bucket,
          width: 150,
          height: 150,
        ),
        Padding(
          padding: PaddingConsts.instance.all20,
          child: Text(
            "Sepetinizde ürün yok.",
            style: TextConsts.instance.regularBlack25Bold,
          ),
        ),
      ],
    );
  }

  Widget _listView(BucketViewModel model) {
    return Column(
      children: <Widget>[
        Container(
          margin: PaddingConsts.instance.top20,
          constraints: const BoxConstraints(
            minHeight: 150,
            maxHeight: 300,
          ),
          child: Observer(
            builder: (context) {
              return ListView.builder(
                itemCount: model.bucket.length,
                itemBuilder: (context, index) {
                  return BucketElement(
                    index: index,
                    data: model.bucket[index],
                    viewModel: model,
                  );
                },
              );
            },
          ),
        ),
        Observer(
          builder: (context) {
            return Padding(
              padding: PaddingConsts.instance.all10,
              child: Text(
                "Toplam Sepet Tutarı: ${model.totalPrice}₺",
                style: TextConsts.instance.regularBlack18,
              ),
            );
          },
        ),
        CustomButton(
          onPressed: () => model.navigateToCreateOrder(),
          text: "Sepeti Onayla",
          width: 200,
          style: TextConsts.instance.regularWhite20,
          gradient: ColorConsts.instance.primaryGradient,
        ),
      ],
    );
  }
}
