import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/custom_statefull_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_text_field.dart';
import 'package:haydi_express_customer/views/authentication/log_in/view/log_in_view.dart';
import 'package:haydi_express_customer/views/authentication/public_components/logo_bar.dart';
import 'package:haydi_express_customer/views/authentication/public_components/page_top_container.dart';
import 'package:haydi_express_customer/views/authentication/sign_up/view/sign_up_view.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/consts/text_consts.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../viewmodel/forgot_password_viewmodel.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
        viewModel: ForgotPasswordViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: PageTopContainer(
                    child: _buildTopBarComponents(model),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: PaddingConsts.instance.top20,
                    child: _buildOtherPagesButtons(model),
                  ),
                ),
              ],
            ),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }

  Widget _buildTopBarComponents(ForgotPasswordViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.bottom25,
          child: const LogoBar(title: "Şifremi Unuttum"),
        ),
        CustomTextField(
          padding: PaddingConsts.instance.horizontal30,
          controller: model.email,
          hint: "E-Posta",
        ),
        Padding(
          padding: PaddingConsts.instance.top20,
          child: CustomStateFullButton(
            onPressed: () {},
            text: "Gönder",
          ),
        ),
      ],
    );
  }

  Widget _buildOtherPagesButtons(ForgotPasswordViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CustomTextButton(
          onPressed: () => model.navigationManager.navigate(const LogInView()),
          style: TextConsts.instance.regularThird20,
          text: "Giriş Yap",
        ),
        CustomTextButton(
          onPressed: () => model.navigationManager.navigate(const SignUpView()),
          style: TextConsts.instance.regularThird20,
          text: "Kayıt Ol",
        ),
      ],
    );
  }
}
