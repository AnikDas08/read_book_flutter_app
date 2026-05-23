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
class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return AuthBackground(child: _content(authState, authNotifier));
  }

  FormBuilder<Map<String, String>> _content(AuthState authState, AuthNotifier authNotifier) {
    return FormBuilder<Map<String, String>>(
      entity: {'email': '', 'password': '', 'name': '', 'age': ''},
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
                text: AppString.sign_up_title,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: context.color.bodyText,
              ).start,
              CommonText(
                text: AppString.please_fill_the_details_and_create_account,
                style: context.textStyle.mediumText,
                textColor: context.color.bodyText,
              ).start,
              25.height,
              InputCardWidget(child: _inputSections(context, entity)),
              24.height,
              Row(
                children: [
                  Checkbox(
                    value: true,
                    checkColor: context.color.buttonTextWhite,
                    side: BorderSide(
                      color: context.color.buttonTextWhite, // border color
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                    onChanged: (value) {},
                  ),
                  GestureDetector(
                    onTap: () {
                      appRouter.push(const PrivacyRoute());
                    },
                    child: CommonText(
                      text: AppString.privacy_policy,
                      fontSize: 12,
                      textColor: context.color.buttonTextWhite,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                  CommonText(
                    text: "-",
                    left: 4,
                    right: 4,
                    fontSize: 16,
                    textColor: context.color.buttonTextWhite,
                  ),

                  GestureDetector(
                    onTap: () {
                      appRouter.push(const TermsRoute());
                    },
                    child: CommonText(
                      text: AppString.terms_and_condition,
                      fontSize: 12,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                      textColor: context.color.buttonTextWhite,
                    ),
                  ),
                ],
              ),
              24.height,
              CommonButton(
                buttonColor: context.color.bgColor,
                titleGradient: context.color.ctaGradientLogo,
                titleText: AppString.sign_up,
                isLoading: authState.isLoading,
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    authNotifier.signup(entity['name']!, entity['email']!, entity['password']!, int.tryParse(entity['age']!) ?? 0);
                      }
                },
              ),
              24.height,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppString.already_have_an_account,
                      style: TextStyle(color: context.color.buttonTextWhite, fontSize: 16),
                    ),
                    TextSpan(
                      text: AppString.sign_in,
                      style: TextStyle(
                        color: context.color.buttonTextWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => appRouter.replaceAll([const LoginRoute()]),
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
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  inputLabel(AppString.name, context).start,
                  CommonTextField(
                    hintText: 'Jon Doe',
                    prefixBuilder: (controller, focusNode) {
                      return Icon(
                        Icons.person_outline,
                        color: focusNode.hasFocus
                            ? context.color.inputBorderFocus
                            : context.color.blue200,
                      );
                    },
                    validationType: ValidationType.validateRequired,
                    onChanged: (val) => entity['name'] = val,
                  ),
                ],
              ),
            ),
            16.width,
            Expanded(
              child: Column(
                children: [
                  inputLabel(AppString.age, context).start,
                  CommonTextField(
                    hintText: '25',
                    prefixBuilder: (controller, focusNode) {
                      return Icon(
                        Icons.cake_outlined,
                        color: focusNode.hasFocus
                            ? context.color.inputBorderFocus
                            : context.color.blue200,
                      );
                    },
                    validationType: ValidationType.validateRequired,
                    onChanged: (val) => entity['age'] = val,
                  ),
                ],
              ),
            ),
          ],
        ),
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
          validationType: ValidationType.validatePassword,
          onChanged: (val) => entity['password'] = val,
        ), 
      ],
    );
  }
}
