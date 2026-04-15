import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:core_kit/text_field/input_formatters/input_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/gen/assets.gen.dart';
import 'package:riverpod_tamplates/src/common/label.dart';
import 'package:riverpod_tamplates/src/constants/app_ui_constants.dart';
import 'package:riverpod_tamplates/src/features/core_features/authentication/presentation/widgets/auth_background.dart';
import 'package:riverpod_tamplates/src/features/core_features/authentication/presentation/widgets/input_card_widget.dart';
import 'package:riverpod_tamplates/src/features/core_features/authentication/riverpod/auth_notifier.dart';
import 'package:riverpod_tamplates/src/features/core_features/authentication/riverpod/auth_state.dart';

@RoutePage()
class OtpScreen extends ConsumerWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return AuthBackground(child: _content(authState, authNotifier));
  }

  FormBuilder<Map<String, String>> _content(AuthState authState, AuthNotifier authNotifier) {
    return FormBuilder<Map<String, String>>(
      entity: const {'email': '', 'password': ''},
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
                text: AppString.otp_verification,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: context.color.bodyText,
              ).start,
              CommonText(
                text: AppString.check_your_email_to_see_the_verification_code,
                style: context.textStyle.mediumText,
                textColor: context.color.bodyText,
              ).start,
              25.height,
              InputCardWidget(
                child: Column(
                  children: [
                    Row(
                      children: [const Spacer(), _inputSections(context, entity), const Spacer()],
                    ),
                    20.height,
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppString.resend_code_in,
                              style: context.textStyle.mediumText.copyWith(
                                color: context.color.bodyText,
                              ),
                            ),
                            TextSpan(
                              text: ' 01:26',
                              style: context.textStyle.mediumText.copyWith(
                                color: context.color.blue400,
                                fontWeight: .bold,
                              ),
                            ),
                          ],
                        ),
                      ).end,
                    ),
                  ],
                ),
              ),
              24.height,
              CommonButton(
                buttonColor: context.color.bgColor,
                titleGradient: context.color.ctaGradientLogo,
                titleText: AppString.verify,
                isLoading: authState.isLoading,
                onTap: () {
                   appRouter.pop();
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
      crossAxisAlignment: .start,
      children: [
        Align(alignment: .centerLeft, child: inputLabel(AppString.otp_code, context)),
        _otpBuilder(context),
      ],
    );
  }

  Widget _otpBuilder(BuildContext context) {
    return PinInputFormField(
      length: 6,
      pinBuilder: (BuildContext context, List<PinCellData> cells) {
        return Wrap(
          spacing: 10,
          children: List.generate(cells.length, (index) {
            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: context.color.inputBorderFocus, width: 1.5),
              ),
              child: Center(
                child: Text(
                  cells[index].character ?? '',
                  style: TextStyle(fontSize: 25, color: context.color.blue400),
                ),
              ),
            );
          }),
        );
      },
      keyboardType: InputHelper.getKeyboardType(ValidationType.validateOTP),
      inputFormatters: InputHelper.getInputFormatters(ValidationType.validateOTP),
      autovalidateMode: AutovalidateMode.disabled,
      enableAutofill: true,
      enableHapticFeedback: true,
      enablePaste: true,
      validator: (value) => InputHelper.validate(ValidationType.validateOTP, value),
    );
    
  }
}
