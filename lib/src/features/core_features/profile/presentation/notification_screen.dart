import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/corekit/back_button.dart';

@RoutePage()
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, _) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Notifications",
        appbarConfig: AppbarConfig(height: 70,titleAlignment: .center),
        leading: const BackButtonWidget(isDark: true,iconColor: Colors.white,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            10.height,
            _buildSectionHeader("TODAY", showMarkAll: true),
            10.height,
            _buildNotificationTile(
              title: "It's a Match!",
              message: "You've got a new match! Start a conversation now.",
              time: "25 Oct 2024 • 11:31 AM",
              isUnread: true,
            ),
            _buildNotificationTile(
              title: "Event Registration Successful",
              message:
                  "Your registration for Anniversary Night 2025 is confirmed. Your QR code & PIN ha...",
              time: "25 Oct 2024 • 11:31 AM",
              isUnread: false,
            ),
            _buildNotificationTile(
              title: "Event Registration Successful",
              message:
                  "Your registration for Anniversary Night 2025 is confirmed. Your QR code & PIN ha...",
              time: "25 Oct 2024 • 11:31 AM",
              isUnread: false,
            ),

            10.height,
            _buildSectionHeader("Yesterday"),
            _buildNotificationTile(
              title: "Event Ended",
              message: "All your information for this event has been erased.",
              time: "25 Oct 2024 • 11:31 AM",
              isUnread: false,
            ),
            _buildNotificationTile(
              title: "Event Registration Successful",
              message:
                  "Your registration for Anniversary Night 2025 is confirmed. Your QR code & PIN ha...",
              time: "25 Oct 2024 • 11:31 AM",
              isUnread: false,
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Components ---

  Widget _buildSectionHeader(String title, {bool showMarkAll = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFFEBE8FF), // Light purple header background
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Color(0xFF4A4E69),
            ),
          ),
          if (showMarkAll)
            Text(
              "Mark all as read",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.6),
                decoration: TextDecoration.underline,
                fontWeight: .bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFF6F3FF) : Colors.transparent,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF5C79FF),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black.withOpacity(0.4),
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
