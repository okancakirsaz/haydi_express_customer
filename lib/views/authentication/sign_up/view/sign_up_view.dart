import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_checkbox.dart';
import 'package:haydi_express_customer/core/widgets/custom_dropdown.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_statefull_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_stepper.dart';
import 'package:haydi_express_customer/core/widgets/custom_text_field.dart';
import 'package:haydi_express_customer/core/widgets/pop_button.dart';
import 'package:haydi_express_customer/views/authentication/public_components/logo_bar.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/consts/color_consts/color_consts.dart';
import '../../../../core/consts/padding_consts.dart';
import '../../../../core/consts/radius_consts.dart';
import '../../../../core/widgets/button/custom_text_button.dart';
import '../../public_components/page_top_container.dart';
import '../viewmodel/sign_up_viewmodel.dart';

part './components/simple_data_inputs.dart';
part './components/personal_data_inputs.dart';
part './components/mail_verify.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
        viewModel: SignUpViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: Column(
              children: <Widget>[
                Observer(builder: (context) {
                  return Expanded(
                    flex: model.pageContainerExpand,
                    child: PageTopContainer(
                      child: model.currentBody,
                    ),
                  );
                }),
                Expanded(
                  child: Padding(
                    padding: PaddingConsts.instance.top20,
                    child: Observer(builder: (context) {
                      return CustomStepper(
                        currentStep: model.stepperIndex,
                        steps: model.steps,
                        height: 20,
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
          model.setCurrentBody(SimpleDataInputs(viewModel: model), 1);
        },
        onDispose: (model) {});
  }
}
