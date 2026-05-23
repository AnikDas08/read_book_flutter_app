import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/gen/assets.gen.dart';
import 'package:unkutdrama_kpnovel/src/common/label.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_ui_constants.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/authentication/presentation/widgets/auth_background.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/authentication/presentation/widgets/input_card_widget.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/authentication/riverpod/auth_notifier.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/authentication/riverpod/auth_state.dart';

@RoutePage()
class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return AuthBackground(child: _content(authState, authNotifier));
  }

  FormBuilder<Map<String, String>> _content(AuthState authState, AuthNotifier authNotifier) {
    return FormBuilder<Map<String, String>>(
      entity: {},
      builder: (context, formKey, entity) {
        return Padding(
          padding: EdgeInsets.all(AppUiConstants.main_screen_padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonImage(
                src: Assets.images.appIcon.path,
                height: 88,
                width: 80,
                fill: .contain,
                enableAspectRatio: true,
              ).center,
              38.height,
              CommonText(
                text: AppString.forgot_password_title,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: context.color.bodyText,
              ).start,
              CommonText(
                text: AppString.enter_your_email_account_to_reset_your_password,
                style: context.textStyle.mediumText,
                textColor: context.color.bodyText,
              ).start,
              25.height,
              InputCardWidget(child: _inputSections(context, entity)),
              24.height,
              CommonButton(
                buttonColor: context.color.bgColor,
                titleGradient: context.color.ctaGradientLogo,
                titleText: AppString.reset_password,
                isLoading: authState.isLoading,
                onTap: () {
                  authNotifier.sendOtp(entity['email']!);
                },
              ),
             
            ],
          ),
        );
      },
    );
  }

  Column _inputSections(BuildContext context, Map<String, String> entity) {
    return Column(
      children: [
        inputLabel(AppString.email, context).start,
        CommonTextField(
          hintText: 'your.email@example.com',
          prefixBuilder: (controller, focusNode) {
            return Icon(
              Icons.email_outlined,
              color: focusNode.hasFocus ? context.color.inputBorderFocus : context.color.blue200,
            );
          },
          validationType: ValidationType.validateEmail,
          onChanged: (val) => entity['email'] = val,
        ),
        
      ],
    );
  }
}
