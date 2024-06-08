import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/core/widgets/custom_password_field.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_statefull_button.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_text_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_text_field.dart';
import 'package:haydi_express_customer/views/authentication/forgot_password/view/forgot_password_view.dart';
import 'package:haydi_express_customer/views/authentication/log_in/viewmodel/log_in_viewmodel.dart';
import 'package:haydi_express_customer/views/authentication/public_components/logo_bar.dart';
import 'package:haydi_express_customer/views/authentication/public_components/page_top_container.dart';
import 'package:haydi_express_customer/views/authentication/sign_up/view/sign_up_view.dart';
import '../../../../core/base/view/base_view.dart';

part './components/advert_campaigns.dart';
part './components/advert_campaign_container.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LogInViewModel>(
        viewModel: LogInViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: PageTopContainer(
                    child: _buildTopBarContent(model),
                  ),
                ),
                Expanded(
                  child: _buildOtherPagesButtons(model),
                ),
                Expanded(
                  flex: 2,
                  child: AdvertCampaign(
                    viewModel: model,
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

  Widget _buildOtherPagesButtons(LogInViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: CustomTextButton(
            onPressed: () =>
                model.navigationManager.navigate(const ForgotPasswordView()),
            style: TextConsts.instance.regularThird20,
            text: "Şifremi Unuttum",
          ),
        ),
        Expanded(
          child: CustomTextButton(
            onPressed: () =>
                model.navigationManager.navigate(const SignUpView()),
            style: TextConsts.instance.regularThird20,
            text: "Kayıt Ol",
          ),
        ),
      ],
    );
  }

  Widget _buildTopBarContent(LogInViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LogoBar(
          title: "Giriş Yap",
        ),
        Padding(
          padding: PaddingConsts.instance.top20,
          child: CustomTextField(
            padding: PaddingConsts.instance.horizontal30,
            controller: model.email,
            hint: "E-Posta",
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.top10,
          child: CustomPasswordField(
            padding: PaddingConsts.instance.horizontal30,
            controller: model.password,
            hint: "Şifre",
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.top20,
          child: CustomStateFullButton(
            onPressed: () async =>
                await model.tryToLogIn(model.email.text, model.password.text),
            text: "Giriş Yap",
          ),
        )
      ],
    );
  }
}
