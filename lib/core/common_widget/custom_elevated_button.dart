import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'app_text_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.title,
    this.titleColor = AppColorConstants.foundationWhite,
    this.backgroundColor = AppColorConstants.mainColor,
    this.titleFontSize = 18.0,
    this.fontWeight = FontWeight.w500,
    this.padding = const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    this.borderRadius = 32.0,
    this.elevation = 0,
    this.textAlign = TextAlign.center,   this.suffixWidget,
  });
  final void Function()? onPressed;
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final double titleFontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double elevation;
  final TextAlign textAlign;
  final Widget? suffixWidget;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        alignment: Alignment.center,
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        padding: MaterialStateProperty.all(padding),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        elevation: MaterialStateProperty.all(elevation),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextWidget(
            text: title,
            fontSize: titleFontSize,
            fontWeight: fontWeight,
            color: titleColor,
            textAlign: textAlign,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: suffixWidget ?? const SizedBox(),
          )
        ],
      ),
    );
  }
}