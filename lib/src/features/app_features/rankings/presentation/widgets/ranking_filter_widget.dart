import 'package:core_kit/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';

class RankingFilterWidget extends StatefulWidget {
  const RankingFilterWidget({super.key});

  @override
  State<RankingFilterWidget> createState() => _RankingFilterWidgetState();
}

class _RankingFilterWidgetState extends State<RankingFilterWidget> {
  String selectedTab = 'Daily';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: _buildTab(AppString.Daily)),
          Expanded(child: _buildTab(AppString.Weekly)),
          Expanded(child: _buildTab(AppString.Monthly)),
        ],
      ),
    );
  }

  // The requested function to design each taba
  Widget _buildTab(String label) {
    final isActive = selectedTab == label;

    return GestureDetector(
      onTap: () => setState(() => selectedTab = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        alignment: .center,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent, // Active tab is white
          borderRadius: BorderRadius.circular(14),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: CommonText(
          text: label,
          textAlign: .center,
          style: TextStyle(
            color: isActive
                ? const Color(0xFF1D4ED8)
                : Colors.white.withValues(alpha: 0.8), // Text color shifts
            fontWeight: FontWeight.bold,
            fontSize: isActive ? 16 : 14,
          ),
        ),
      ),
    );
  }
}
