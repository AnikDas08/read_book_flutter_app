import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/gestures.dart';
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
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return AuthBackground(hideBack: true, child: _content(authState, authNotifier));
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
                text: AppString.welcome_back,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: context.color.bodyText,
              ).start,
              CommonText(
                text: AppString.sign_in_to_continue_your_reading_journey,
                style: context.textStyle.mediumText,
                textColor: context.color.bodyText,
              ).start,
              25.height,
              InputCardWidget(child: _inputSections(context, entity)),
              24.height,
              SizedBox(
                width: double.infinity,
                child: CommonButton(
                  buttonColor: context.color.bgColor,
                  titleGradient: context.color.ctaGradientLogo,
                  titleText: AppString.login_title,
                  isLoading: authState.isLoading,
                  onTap: () {
                    authNotifier.login(entity['email']??'', entity['password']??'');
                  },
                ),
              ),
              24.height,
              GestureDetector(
                onTap: (){
                  authNotifier.loginAsGuest();
                },
                child: CommonText(
                  text:  AppString.login_as_guest,
                  fontSize: 16, fontWeight: .bold,
                  textColor: context.color.buttonTextWhite,
                  style: const TextStyle(decoration: .underline, decorationColor: Colors.white),
                ).center,
              ),
              10.height,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppString.dont_have_an_account,
                      style: TextStyle(color: context.color.buttonTextWhite, fontSize: 16),
                    ),
                    TextSpan(
                      text: AppString.sign_up,
                      style: TextStyle(
                        color: context.color.buttonTextWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => appRouter.push(const SignupRoute()),
                    ),
                  ],
                ),
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
        AppUiConstants.field_spacing.height,
        inputLabel(AppString.password, context).start,
        CommonTextField(
          prefixBuilder: (controller, focusNode) {
            return Icon(
              Icons.lock_outline,
              color: focusNode.hasFocus ? context.color.inputBorderFocus : context.color.blue200,
            );
          },
          hintText: '••••••••',
          validationType: ValidationType.notRequired,
          onChanged: (val) => entity['password'] = val,
        ),
        18.height,
        TextButton(
          onPressed: () => appRouter.push(const ForgotPasswordRoute()),
          child: CommonText(
            text: AppString.forgot_password,
            textColor: context.color.inputBorderFocus,
            fontSize: 14,
          ),
        ).end,
      ],
    );
  }
}
