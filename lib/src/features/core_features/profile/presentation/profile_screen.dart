import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/route/app_router.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/profile/application/profile_notifier.dart';
import 'package:unkutdrama_kpnovel/src/features/core_features/profile/model/profile_model.dart';

@RoutePage()
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);
    final profile = profileState.profile;

    return Scaffold(
      appBar: const CommonAppBar(title: 'Setting'),
      backgroundColor: const Color(0xFFF5F6F8), // Light grey background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: profileState.isLoading && profile == null
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => ref.read(profileNotifierProvider.notifier).loadProfile(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // --- Profile Header ---
                        _buildProfileHeader(context, profile),

                        const SizedBox(height: 30),

                        // --- Account Section ---
                        _buildSectionTitle('Account'),
                        _buildSettingsCard(
                          child: Column(
                            children: [
                              _buildListTile(
                                icon: Icons.person_outline,
                                title: 'Edit Profile',
                                onTap: () {
                                  appRouter.push(const EditProfileRoute());
                                },
                              ),
                              const Divider(height: 1, indent: 70),
                              _buildListTile(
                                icon: Icons.lock_outline,
                                title: 'Change Password',
                                onTap: () {
                                  appRouter.push(const ChangePasswordRoute());
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),
            
                // --- Preferences Section ---
                _buildSectionTitle('Preferences'),
                _buildSettingsCard(
                  child: ListTile(
                    leading: _buildIconContainer(
                      Icons.notifications_none,
                      Colors.purple.shade50,
                      Colors.purple,
                    ),
                    title: const Text(
                      'Notificastions',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text(
                      'Push notifications and alerts',
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: Switch(
                      value: true,
                      onChanged: (val) {},
                      activeColor: Colors.white,
                      activeTrackColor: Colors.purple,
                    ),
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // --- Support Section ---
                _buildSectionTitle('Support'),
                _buildSettingsCard(
                  child: Column(
                    children: [
                      _buildListTile(
                        icon: Icons.info_outline,
                        title: 'Terms & conditions',
                        onTap: () {
                          appRouter.push(const TermsRoute());
                        },
                      ),
                      const Divider(height: 1, indent: 70),
                      _buildListTile(
                        icon: Icons.info_outline,
                        title: 'Privacy Policy',
                        onTap: () {
                          appRouter.push(const PrivacyRoute());
                        },
                      ),
                      const Divider(height: 1, indent: 70),
                      _buildListTile(
                        icon: Icons.info_outline,
                        title: 'About Us',
                        onTap: () {},
                      ),
                      const Divider(height: 1, indent: 70),
                      _buildListTile(
                        icon: Icons.description_outlined,
                        title: "FAQ's",
                        onTap: () {
                          appRouter.push(const FaqRoute());
                        },
                      ),
                    ],
                  ),
                ),

                30.height,

            
                // --- Buttons ---
                _buildOutlineButton(
                  label: 'Sign Out',
                  icon: Icons.logout,
                  color: Colors.redAccent,
                  onPressed: () {
                    appRouter.replaceAll([const LoginRoute()]);
                  },
                ),
                const SizedBox(height: 15),
                _buildOutlineButton(
                  label: 'Delete Account',
                  icon: Icons.delete_outline,
                  color: Colors.redAccent,
                  onPressed: () {},
                ),
            
                const SizedBox(height: 25),
            
                // --- Footer ---
                Center(
                  child: Column(
                    children: [
                      Text(
                        '© 2026 Rinik Tech Company Limited.',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Version 1.0.0 (Build 100)',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),)
    );
  }

  // Helper to build section titles
  Widget _buildProfileHeader(BuildContext context, ProfileModel? profile) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CommonImage(
                src: profile?.profile ?? '',
                fill: BoxFit.cover,
                // placeholder: (context, url) => const CircularProgressIndicator(),
                // errorWidget: Container(
                //   color: Colors.grey.shade200,
                //   child: Icon(Icons.person, size: 50, color: Colors.grey.shade400),
                // ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            profile?.fullName ?? '...',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A4E69),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profile?.email ?? '...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4A4E69),
        ),
      ),
    );
  }

  // Helper for the rounded white containers with shadow
  Widget _buildSettingsCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  // Helper for standard list items
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: _buildIconContainer(icon, Colors.purple.shade50, Colors.purple),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  // Helper for the stylized icons
  Widget _buildIconContainer(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconColor, size: 22),
    );
  }

  // Helper for the red outline buttons
  Widget _buildOutlineButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
        label: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color.withOpacity(0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
