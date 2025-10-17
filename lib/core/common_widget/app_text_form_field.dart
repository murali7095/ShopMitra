import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Custom text form field with consistent styling for a banking app
class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.errorText,
    required this.onChanged,
    this.controller,
    required this.validator,
    this.suffixIcon,
    this.textInputType = TextInputType.text,
  });

  final String? hintText;
  final String? initialValue;
  final String? labelText;
  final bool obscureText;
  final TextInputType textInputType;
  final String? errorText;
  final void Function(String) onChanged;
  final TextEditingController? controller;
  final String? Function(String) validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        enabled: true,
        autocorrect: false,
        controller: controller,
        initialValue: controller == null ? initialValue : null, // Prevent conflict
        keyboardType: textInputType,
        style: TextStyle(
          color: AppColorConstants.contentNeutral900, // default color for text
        ),
        obscureText: obscureText,
        cursorColor: AppColorConstants.foundationInfo50,
        validator: (value) => validator(value ?? ''),
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(
          errorText: errorText,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black54, // hint color
          ),
          suffixIcon: suffixIcon,
          suffixIconColor: Colors.black54,
          labelText: labelText,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.black, // solid black border
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: AppColorConstants.appMainColor, // focused color
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.black, // default border color
              width: 1,
            ),
          ),
         // prefixIcon: const Icon(Icons.currency_rupee, color: AppColorConstants.appMainColor), // prefix icon for currency
        ),
      ),
    );
  }
}
