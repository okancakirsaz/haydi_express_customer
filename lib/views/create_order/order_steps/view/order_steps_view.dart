import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/custom_stepper.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';
import 'package:haydi_express_customer/views/address/create_edit_address/view/create_edit_address_view.dart';
import 'package:haydi_express_customer/views/create_order/core/constants/payment_methods.dart';
import 'package:haydi_express_customer/views/create_order/order_steps/view/components/order_steps_app_bar.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/consts/radius_consts.dart';
import '../../../../core/widgets/button/custom_statefull_button.dart';
import '../viewmodel/order_steps_viewmodel.dart';

part './pages/choose_address.dart';
part './pages/payment_method.dart';
part './pages/order_details.dart';
part './pages/online_payment.dart';

class OrderStepsView extends StatelessWidget {
  const OrderStepsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderStepsViewModel>(
        viewModel: OrderStepsViewModel(),
        onPageBuilder: (context, model) {
          return ChooseAddress(viewModel: model);
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
