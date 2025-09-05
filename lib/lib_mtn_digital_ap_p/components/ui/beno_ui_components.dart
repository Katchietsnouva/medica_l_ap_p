// components/ui/beno_ui_components.dart
import 'package:flutter/material.dart';

// const Color primaryColor = Color(0xFFD02030);

// //   static const Color primaryColor =
// //       // #D02030
// //       Color(0xFFD02030);

const MaterialColor primaryColor = MaterialColor(
  0xFFD02030,
  <int, Color>{
    50: Color(0xFFFFEBEE),
    100: Color(0xFFFFCDD2),
    200: Color(0xFFEF9A9A),
    300: Color(0xFFE57373),
    400: Color(0xFFEF5350),
    500: Color(0xFFD02030),
    600: Color(0xFFE53935),
    700: Color(0xFFD32F2F),
    800: Color(0xFFC62828),
    900: Color(0xFFB71C1C),
  },
);

class BenoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isFullWidth;
  final bool isOutline;
  final Color? backgroundColor; // <-- ADD THIS
  final bool compact; // <-- NEW

  const BenoButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isFullWidth = false,
    this.isOutline = false,
    // Color? backgroundColor,
    this.backgroundColor, // <-- PASS IT HERE TOO
    this.compact = false, // <-- DEFAULT false
  });

  @override
  Widget build(BuildContext context) {
    // Adjust padding & font size depending on compact
    final EdgeInsets padding = compact
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
        : const EdgeInsets.symmetric(horizontal: 24, vertical: 16);

    final TextStyle textStyle = TextStyle(
      fontSize: compact ? 14 : 16,
      fontWeight: FontWeight.w500,
    );
    final buttonStyle = isOutline
        ? OutlinedButton.styleFrom(
            // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            padding: padding,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          )
        : ElevatedButton.styleFrom(
            // backgroundColor: Colors.blue,
            backgroundColor:
                backgroundColor ?? primaryColor, // <-- updated line
            foregroundColor: Colors.white,
            // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            padding: padding,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          );

    final button = isOutline
        ? OutlinedButton(
            onPressed: onPressed, style: buttonStyle, child: Text(text))
        : ElevatedButton(
            onPressed: onPressed, style: buttonStyle, child: Text(text));

    return isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

class BenoCard extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final double? elevation;
  final Color? color;

  const BenoCard(
      {super.key,
      required this.child,
      this.maxWidth,
      this.elevation,
      this.color});

  @override
  Widget build(BuildContext context) {
    // Widget card = Card(child: child);
    Widget card = Card(
      elevation: elevation ?? 1.0, // default elevation if none provided
      // color: color, // color may be null (Card handles it)
      child: child,
    );

    if (maxWidth != null) {
      return Center(
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth!), child: card));
    }
    return card;
  }
}
