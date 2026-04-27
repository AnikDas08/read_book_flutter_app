import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';

class WatchAdsCardWidget extends StatelessWidget {
  const WatchAdsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: AppString.watch_ads_for_more,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1C1E),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CommonText(
                  text: '0/3 ${AppString.today}',
                  style: const TextStyle(
                    color: Color(0xFF5F6368),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CommonText(
            text: '${AppString.watch_ads_to_earn} +2 ${AppString.power_stones} ${AppString.each}',
            style: const TextStyle(color: Color(0xFF70757A), fontSize: 14),
          ),
          const SizedBox(height: 20),

          _buildAdTile(
            title: '${AppString.ad} #1',
            subtitle: '+2 ${AppString.power_stones}',
            isActive: true,
            context: context,
          ),
          const SizedBox(height: 12),
          _buildAdTile(
            title: '${AppString.ad} #2',
            subtitle: '+2 ${AppString.power_stones}',
            isActive: false,
            context: context,
          ),
          const SizedBox(height: 12),
          _buildAdTile(
            title: '${AppString.ad} #3',
            subtitle: '+2 ${AppString.power_stones}',
            isActive: false,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildAdTile({
    required String title,
    required String subtitle,
    required bool isActive,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EAED)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Color(0xFF00C4A1), shape: BoxShape.circle),
            child: const Icon(Icons.play_circle_outline, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: Color(0xFF70757A), fontSize: 13)),
              ],
            ),
          ),

          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: context.color.successMessages,
                borderRadius: BorderRadius.circular(24),
              ),
              child: CommonText(
                text: AppString.watch_now,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: context.color.buttonTextWhite,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
