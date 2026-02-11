import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'app_text_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.titleColor = AppColorConstants.foundationWhite,
    this.backgroundColor = AppColorConstants.mainColor,
    this.disabledColor = const Color(0xFFE0E0E0),
    this.titleFontSize = 18.0,
    this.fontWeight = FontWeight.w500,
    this.padding = const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    this.borderRadius = 32.0,
    this.elevation = 0,
    this.textAlign = TextAlign.center,
    this.suffixWidget,
  });

  final VoidCallback? onPressed;
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final Color disabledColor;
  final double titleFontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double elevation;
  final TextAlign textAlign;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          padding: WidgetStateProperty.all(padding),
          elevation: WidgetStateProperty.all(elevation),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return disabledColor;
            }
            return backgroundColor;
          }),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextWidget(
              text: title,
              fontSize: titleFontSize,
              fontWeight: fontWeight,
              color: isDisabled
                  ? AppColorConstants.contentNeutral400 // use light grey
                  : titleColor,
              textAlign: textAlign,
            ),
            if (suffixWidget != null) ...[
              const SizedBox(width: 8),
              suffixWidget!,
            ],
          ],
        ),
      ),
    );
  }
}
