import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tamplates/config/constance/app_string.dart';
import 'package:riverpod_tamplates/config/theme/app_theme_data.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_notifier.dart';

class ReadingSettingsModal extends ConsumerStatefulWidget {
  const ReadingSettingsModal({super.key, required this.controller,  });
  final ScrollController controller;

  @override
  ConsumerState<ReadingSettingsModal> createState() => _ReadingSettingsModalState();
}

class _ReadingSettingsModalState extends ConsumerState<ReadingSettingsModal> {
  late double fontSize;
  late double lineSpacing;
  late int selectedMode;

  @override
  void initState() {
    super.initState();
    final readState = ref.read(readProvider);
    fontSize = readState.fontSize;
    lineSpacing = readState.lineSpacing;
    selectedMode = readState.selectedMode;
  }

  @override
  Widget build(BuildContext context) {
    final readNotifier = ref.read(readProvider.notifier);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), 
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: ListView(
        controller: widget.controller,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          CommonText(text: AppString.Reading_Settings, fontSize: 22, fontWeight: FontWeight.bold), 
 
          _buildSliderRow(AppString.Font_Size, '${fontSize.toInt()}px', fontSize, 12, 30, (val) {
            setState(() => fontSize = val);
            readNotifier.updateFontSize(val);
          }),
 
          _buildSliderRow(
            AppString.Line_Spacing,
            lineSpacing.toStringAsFixed(1),
            lineSpacing,
            1.0,
            3.0,
            (val) {
              setState(() => lineSpacing = val);
              readNotifier.updateLineSpacing(val);
            },
          ), 
 
          CommonText(text: AppString.Background_Mode, fontSize: 16, fontWeight: FontWeight.w500),
          10.height,
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 2.2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildModeOption(
                AppString.White,
                0,
                Icons.wb_sunny_outlined,
                const Color(0xFFF8F9FF),
                readNotifier: readNotifier
              ),
              _buildModeOption(
                AppString.Dark,
                1,
                Icons.nightlight_round_outlined,
                const Color(0xFF2D2D2D),
                isDark: true,
                readNotifier:  readNotifier
              ),
              _buildModeOption(
                AppString.Sepia,
                2,
                Icons.text_fields_rounded,
                const Color(0xFFF4ECD8),
                readNotifier: readNotifier
              ),
              _buildModeOption(
                AppString.Eye_Comfort,
                3,
                Icons.auto_awesome_outlined,
                const Color(0xFFE8F5E9),
                readNotifier:  readNotifier
              ),
            ],
          ),
          10.height,

          CommonButton(
            titleText: AppString.Done,
            gradient: context.color.ctaGradientBackgroundAccent,
            onTap: () {
              Navigator.pop(context);
            },
          ), 
        ],
      ),
    );
  }

  Widget _buildSliderRow(
    String label,
    String value,
    double current,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 16, color: Color(0xFF9EA7B5))),
            Text(value, style: const TextStyle(fontSize: 14, color: Color(0xFF9EA7B5))),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            thumbColor: const Color(0xFF6236FF),
            activeTrackColor: const Color(0xFF6236FF),
            inactiveTrackColor: Colors.grey[200],
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
          ),
          child: Slider(value: current, min: min, max: max, onChanged: onChanged),
        ),
      ],
    );
  }

  Widget _buildModeOption(
    String label,
    int index,
    IconData icon,
    Color previewColor, {
    bool isDark = false,
        required ReadNotifier readNotifier,
  }) {
    final isSelected = selectedMode == index;
    return GestureDetector(
      onTap: () {
        setState(() => selectedMode = index);
        readNotifier.updateBackgroundMode(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF6236FF) : Colors.grey.shade100,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: previewColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: isDark ? Colors.white : Colors.black54),
            ),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
