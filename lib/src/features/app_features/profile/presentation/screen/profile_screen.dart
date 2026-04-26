import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/route/app_router.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';
import 'package:riverpod_tamplates/src/features/core_features/authentication/riverpod/auth_notifier.dart';

@RoutePage()
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.color.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BooksReadCard(),
              14.height,
              const _PowerStonesSummary(),
              12.height,
              const _SectionTitle(title: 'Account'),
              12.height,
              _SettingsGroup(
                children: [
                  _SettingsTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () =>
                        context.router.push(const ChangePasswordRoute()),
                  ),
                ],
              ),
              12.height,
              const _SectionTitle(title: 'Preferences'),
              12.height,
              const _SettingsGroup(children: [_NotificationTile()]),
              12.height,
              const _SectionTitle(title: 'Language'),
              12.height,
              _SettingsGroup(
                children: [
                  _SettingsTile(
                    icon: Icons.language,
                    title: 'Language',
                    onTap: () => context.router.push(const LanguageRoute()),
                  ),
                ],
              ),
              12.height,
              const _SectionTitle(title: 'Support'),
              12.height,
              _SettingsGroup(
                children: [
                  _SettingsTile(
                    icon: Icons.info_outline,
                    title: 'About Us',
                    onTap: () => context.router.push(const AboutUsRoute()),
                  ),
                  Divider(height: 1, color: Colors.grey.shade100),
                  _SettingsTile(
                    icon: Icons.description_outlined,
                    title: "FAQ's",
                    onTap: () => context.router.push(const FaqRoute()),
                  ),
                ],
              ),
              28.height,
              _DangerButton(
                icon: Icons.logout,
                title: 'Sign Out',
                onTap: () => _showLogoutDialog(context, ref),
              ),
              14.height,
              _DangerButton(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                onTap: () => _showDeleteDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => _ConfirmDialog(
        title: 'Log Out?',
        message: 'Are you sure you want to log\nout?',
        onConfirm: () {
          dialogContext.router.pop();
          ref.read(authProvider.notifier).logout();
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const _ConfirmDialog(
        title: 'Delete Account?',
        message: 'This will permanently delete your\naccount. Continue?',
        showPassword: true,
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.avatarUrl});

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Container(
            width: 90.w,
            height: 90.w,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color(0xFFE5E7EB),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: CommonImage(src: avatarUrl, fill: BoxFit.cover),
            ),
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: 'Alex Morgan',
                  height: 1,
                  fontSize: AppFontSizes.heading,
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textColor: context.color.headingBoldText,
                ),
                const CommonText(
                  text: 'alex.morgan@email.com',
                  fontSize: AppFontSizes.medium,
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF333333),
                ),
                6.height,
                GestureDetector(
                  onTap: () => context.router.push(const EditProfileRoute()),
                  child: const CommonText(
                    text: 'Edit Profile',
                    fontSize: AppFontSizes.small,
                    fontWeight: FontWeight.w600,
                    textColor: Color(0xFF333333),
                    preffix: Icon(
                      Icons.edit_outlined,
                      size: 12,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BooksReadCard extends StatelessWidget {
  const _BooksReadCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD5E5FF), width: 1.2),
      ),
      child: Row(
        children: [
          CommonText(
            text: 'Books Read',
            fontSize: AppFontSizes.small,
            textColor: context.color.headingBoldText,
            fontWeight: FontWeight.w400,
          ),
          const Spacer(),
          const CommonText(
            text: '127',
            fontSize: AppFontSizes.heading,
            fontWeight: FontWeight.w700,
            textColor: Color(0xFF1B22F2),
          ),
        ],
      ),
    );
  }
}

class _PowerStonesSummary extends StatelessWidget {
  const _PowerStonesSummary();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(const PowerStonesRoute()),
      child: Container(
        height: 80.h,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF1D8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFFCB7A)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 22,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          spacing: 8,
          mainAxisAlignment: .spaceBetween,
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.electric_bolt,
                color: Color(0xFFFF9900),
                size: 24,
              ),
            ),

            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: 'Power Stones',
                    fontSize: AppFontSizes.medium,
                    fontWeight: FontWeight.w700,
                    textColor: Color(0xFF111111),
                  ),
                  CommonText(
                    text: 'Available: 5   Used: 10',
                    fontSize: AppFontSizes.small,
                    fontWeight: FontWeight.w400,
                    textColor: Color(0xFF333333),
                  ),
                ],
              ),
            ),
            Container(
              width: 90,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const CommonText(
                text: 'View',
                fontSize: AppFontSizes.large,
                fontWeight: FontWeight.w700,
                textColor: Color(0xFFE89000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CommonText(
      text: title,
      fontSize: AppFontSizes.large,
      fontWeight: FontWeight.w700,
      textColor: const Color(0xFF6B7280),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.bgColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            16.width,
            _ProfileIcon(icon: icon),
            26.width,
            Expanded(
              child: CommonText(
                text: title,
                fontSize: AppFontSizes.medium,
                fontWeight: FontWeight.w400,
                textColor: context.color.headingBoldText,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 24,
              color: Color(0xFF9CA3AF),
            ),
            16.width,
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatefulWidget {
  const _NotificationTile();

  @override
  State<_NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<_NotificationTile> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          16.width,
          const _ProfileIcon(icon: Icons.notifications_none),
          26.width,
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: 'Notifications',
                  fontSize: AppFontSizes.medium,
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF111111),
                ),
                CommonText(
                  text: 'Push notifications and alerts',
                  fontSize: AppFontSizes.small,
                  fontWeight: FontWeight.w400,
                  textColor: Color(0xFF6B7280),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) => setState(() => isEnabled = value),
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF9333B8),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F0FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: const Color(0xFF6A1B9A), size: 20),
    );
  }
}

class _DangerButton extends StatelessWidget {
  const _DangerButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFFF4B4B), width: 1.5),
        ),
        child: CommonText(
          text: title,
          fontSize: AppFontSizes.medium,
          fontWeight: FontWeight.w700,
          textColor: const Color(0xFFFF4B4B),
          preffix: Icon(icon, color: const Color(0xFFFF4B4B), size: 20),
        ),
      ),
    );
  }
}

class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({
    required this.title,
    required this.message,
    this.showPassword = false,
    this.onConfirm,
  });

  final String title;
  final String message;
  final bool showPassword;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonText(
              text: title,
              fontSize: AppFontSizes.heading,
              fontWeight: FontWeight.w600,
              textColor: const Color(0xFFE00000),
            ),

            CommonText(
              text: message,
              fontSize: AppFontSizes.medium,
              fontWeight: FontWeight.w400,
              textColor: const Color(0xFF333333),
              textAlign: .center,
            ),
            if (showPassword) ...[
              10.height,
              const SizedBox(
                height: 50,
                child: CommonTextField(
                  hintText: 'Enter your password',
                  validationType: .notRequired,
                  borderRadius: 8,
                  borderColor: Color(0xFFE3E8F0),
                  suffixIcon: Icon(
                    Icons.visibility_off_outlined,
                    color: Color(0xFF9CA3AF),
                  ),
                  hintStyle: TextStyle(
                    fontSize: AppFontSizes.medium,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
            20.height,
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    title: 'No',
                    isDanger: false,
                    onTap: () => context.router.pop(),
                  ),
                ),
                16.width,
                Expanded(
                  child: _DialogButton(
                    title: 'Yes',
                    isDanger: true,
                    onTap: onConfirm ?? () => context.router.pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.title,
    required this.isDanger,
    required this.onTap,
  });

  final String title;
  final bool isDanger;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDanger ? const Color(0xFFE00000) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isDanger
              ? null
              : Border.all(color: const Color(0xFF6B7280), width: 1.6),
        ),
        child: CommonText(
          text: title,
          fontSize: AppFontSizes.large,
          fontWeight: FontWeight.w700,
          textColor: isDanger ? Colors.white : const Color(0xFF6B7280),
        ),
      ),
    );
  }
}
