
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';

class ContestWriterWidget extends StatelessWidget {
  final String name;
  final String votes;
  final List<Color> avatarGradient;
  final Color borderColor;

  const ContestWriterWidget({
    super.key,
    required this.name,
    required this.votes,
    this.avatarGradient = const [Color(0xFF4A90E2), Color(0xFF357ABD)],
    this.borderColor = const Color(0xFFE0E7FF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor.withOpacity(0.5), width: 1.2),
      ),
      child: Row(
        children: [
          // Gradient Avatar with Shadow
          _buildAvatar(),
          const SizedBox(width: 16),
          // Writer Name
          Expanded(
            child: CommonText(
              text: name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          // Vote Count Section
          _buildVoteSection(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: avatarGradient,
        ),
        boxShadow: [
          BoxShadow(
            color: avatarGradient.last.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: CommonText(
          text: initials,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildVoteSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.flash_on, size: 22, color: Colors.black),
        const SizedBox(width: 4),
        CommonText(
          text: "$votes ${AppString.votes}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
        ),
      ],
    );
  }

  String get initials {
    final names = name.split(' ');
    if (names.length >= 2) {
      return names[0][0] + names[1][0];
    }
    return name.length >= 2 ? name.substring(0, 2) : name;
  }
}
