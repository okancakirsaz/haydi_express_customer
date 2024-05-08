import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/views/authentication/forgot_password/view/forgot_password_view.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/consts/padding_consts.dart';
import '../../../../core/consts/text_consts.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../log_in/view/log_in_view.dart';
import '../../public_components/page_top_container.dart';
import '../viewmodel/sign_up_viewmodel.dart';

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
                const Expanded(
                  flex: 3,
                  child: PageTopContainer(
                    child: SizedBox(),
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

  Widget _buildOtherPagesButtons(SignUpViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CustomTextButton(
          onPressed: () => model.navigationManager.navigate(const LogInView()),
          style: TextConsts.instance.regularThird20,
          text: "Giriş Yap",
        ),
        CustomTextButton(
          onPressed: () =>
              model.navigationManager.navigate(const ForgotPasswordView()),
          style: TextConsts.instance.regularThird20,
          text: "Şifremi Unuttum",
        ),
      ],
    );
  }
}
