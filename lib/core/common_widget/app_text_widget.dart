
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

class AppTextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle; // Added FontStyle for customization
  final Color color;
  final TextAlign textAlign;
  final int maxLines;
  final double letterSpacing;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final String? fontFamily; // Customizable font family

  const AppTextWidget({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
    this.color = Colors.black,
    this.textAlign = TextAlign.start,
    this.maxLines = 100,
    this.letterSpacing = 0.5,
    this.textDecoration,
    this.decorationColor,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: GoogleFonts.getFont(
        fontFamily ?? 'Poppins',
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
        letterSpacing: letterSpacing,
        decoration: textDecoration,
        decorationColor: decorationColor,
      ),
      textAlign: textAlign,
    );
  }
}
