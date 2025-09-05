// widgets/settings_dialog.dart
import 'package:medica_l_ap_p/lib_mtn_digital_ap_p/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/theme_provider.dart';
import '../logic/text_scale_provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Display Settings'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme Mode',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Row(
                  children: [
                    const Icon(Icons.light_mode_outlined),
                    Expanded(
                      child: Switch(
                        value: themeProvider.themeMode == ThemeMode.dark,
                        onChanged: (value) => themeProvider.toggleTheme(),
                      ),
                    ),
                    const Icon(Icons.dark_mode_outlined),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            const Text('Text Size',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Consumer<TextScaleProvider>(
              builder: (context, textScaleProvider, child) {
                final isSmallScreen = MediaQuery.of(context).size.width < 450;

                if (!isSmallScreen) {
                  return SegmentedButton<TextScaleLevel>(
                    segments: [
                      ButtonSegment(
                        value: TextScaleLevel.smaller,
                        // label: Text('Smaller')
                        label: Text(
                          "Smaller",
                          style: TextStyle(
                            fontSize: responsiveFontSize(context, baseSize: 14),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ButtonSegment(
                        value: TextScaleLevel.small,
                        // label: Text('Small')
                        label: Text(
                          "Small",
                          style: TextStyle(
                            fontSize: responsiveFontSize(context, baseSize: 14),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ButtonSegment(
                        value: TextScaleLevel.defaultLevel,
                        // label: Text('Default')),
                        label: Text(
                          "Default",
                          style: TextStyle(
                            fontSize: responsiveFontSize(context, baseSize: 14),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ButtonSegment(
                        value: TextScaleLevel.large,
                        label: Text(
                          "Large",
                          style: TextStyle(
                            fontSize: responsiveFontSize(context, baseSize: 14),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ButtonSegment(
                        value: TextScaleLevel.larger,
                        // label: Text('Larger')),
                        label: Text(
                          "Larger",
                          style: TextStyle(
                            fontSize: responsiveFontSize(context, baseSize: 14),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                    selected: {textScaleProvider.currentLevel},
                    onSelectionChanged: (newSelection) {
                      textScaleProvider.setLevel(newSelection.first);
                    },
                  );
                } else {
                  return Column(
                    children: TextScaleLevel.values.map((level) {
                      return RadioListTile<TextScaleLevel>(
                        title: Text(
                          level.toString().split('.').last,
                          // style: TextStyle(
                          //   fontSize: responsiveFontSize(context, baseSize: 14),
                          // ),
                        ),
                        value: level,
                        groupValue: textScaleProvider.currentLevel,
                        onChanged: (newValue) {
                          if (newValue != null) {
                            textScaleProvider.setLevel(newValue);
                          }
                        },
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
