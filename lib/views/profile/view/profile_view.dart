import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/models/address_model.dart';
import 'package:haydi_ekspres_dev_tools/models/bucket_element_model.dart';
import 'package:haydi_ekspres_dev_tools/models/order_model.dart';
import 'package:haydi_ekspres_dev_tools/models/order_states.dart';
import 'package:haydi_ekspres_dev_tools/models/personal_value_types.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_statefull_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/custom_text_field.dart';
import 'package:haydi_express_customer/core/widgets/part_title.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/profile_viewmodel.dart';

part 'components/personal_data.dart';
part 'components/active_orders.dart';
part 'components/order_history.dart';
part 'components/order_widget.dart';
part 'components/cancel_reason_dialog.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      viewModel: ProfileViewModel(),
      onPageBuilder: (context, model) {
        return CustomScaffold(
            body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              PersonalData(
                viewModel: model,
              ),
              ActiveOrders(
                viewModel: model,
              ),
              OrderHistory(
                viewModel: model,
              ),
            ],
          ),
        ));
      },
      onModelReady: (model) {
        model.init();
        model.setContext(context);
      },
      onDispose: (model) {},
    );
  }
}
