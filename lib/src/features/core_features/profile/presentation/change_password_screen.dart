import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/core_features/profile/application/profile_notifier.dart';

@RoutePage()
class ChangePasswordScreen extends ConsumerWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: CommonAppBar(
        leading: const BackButtonWidget(isDark: true),

        appbarConfig: AppbarConfig(
          leadingAlignment: .bottomStart,
          leadingPadding: .zero,
          decoration: () => const BoxDecoration(color: Colors.white),
        ),
      ),
      backgroundColor: context.color.bgColor,
      body: FormBuilder<Map<String, String>>(
        entity: const {'old': '', 'new': '', 'confirm': ''},
        builder: (context, formKey, entity) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  CommonText(
                    text: 'Password Changes',
                    fontSize: AppFontSizes.extraLarge,
                    fontWeight: FontWeight.w500,
                    textColor: context.color.headingBoldText,
                  ),
                  32.height,
                  _PasswordField(
                    label: 'Current Password',
                    hint: 'Please enter your current  password.',
                    onChanged: (val) => entity['old'] = val,
                  ),
                  22.height,
                  _PasswordField(
                    label: 'New Password',
                    hint: 'Please enter your new  password.',
                    onChanged: (val) => entity['new'] = val,
                  ),
                  22.height,
                  _PasswordField(
                    label: 'Re-enter New Password',
                    hint: 'Re-enter your new password.',
                    onChanged: (val) => entity['confirm'] = val,
                  ),
                  60.height,
                  _SaveButton(
                    isLoading: profileState.isLoading,
                    onTap: () {
                      if (formKey.currentState?.validate() ?? false) {
                        ref
                            .read(profileNotifierProvider.notifier)
                            .changePassword(entity['old']!, entity['new']!);
                      }
                    },
                  ),
                  110.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.isLoading, required this.onTap});

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const CommonText(
                text: 'Save all Changes',
                fontSize: AppFontSizes.large,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
              ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.hint,
    required this.onChanged,
  });

  final String label;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: label,
          fontSize: AppFontSizes.medium,
          fontWeight: FontWeight.w500,
          textColor: const Color(0xFF333333),
        ),
        14.height,
        SizedBox(
          height: 58,
          child: CommonTextField(
            hintText: hint,
            validationType: .notRequired,
            borderRadius: 10,
            borderWidth: 1.2,
            borderColor: const Color(0xFFD6D9DE),
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              size: 18,
              color: Color(0xFF9CA3AF),
            ),
            hintStyle: const TextStyle(
              fontSize: AppFontSizes.small,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
            textStyle: const TextStyle(fontSize: AppFontSizes.extraLarge),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _PlainBackButton extends StatelessWidget {
  const _PlainBackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.pop(),
      child: const SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF1C1CFF),
          size: 24,
        ),
      ),
    );
  }
}
