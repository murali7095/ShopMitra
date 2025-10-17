import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shop_mitra/core/common_widget/app_text_form_field.dart';
import 'package:shop_mitra/core/common_widget/app_text_widget.dart';
import 'package:shop_mitra/core/common_widget/custom_elevated_button.dart';
import 'package:shop_mitra/core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorConstants.foundationWhite,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEADAFB), // Light lavender
            Color(0xFFC2E7F5), // Soft teal
          ],
        ),
      ),

      child: Scaffold(
        backgroundColor: AppColorConstants.foundationWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 100, bottom: 10),
                  child: AppTextWidget(
                    text: "Welcome back",
                    fontSize: 26,
                    fontFamily: 'Poppins',
                    color: AppColorConstants.mainColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 8),
                  child: AppTextWidget(
                    text:
                        "Use your credentials below and\nlogin to your account",
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    textAlign: TextAlign.center,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 12),
                headerText("Email"),
                AppTextFormField(
                  hintText: "Enter Email",
                  onChanged: (v) {},
                  validator: (v) {},
                ),
                SizedBox(height: 12),
                headerText("Password"),
                AppTextFormField(
                  suffixIcon: Icon(Icons.visibility_outlined),
                  hintText: "Enter Password",
                  onChanged: (v) {},
                  validator: (v) {},
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          splashRadius: 12,
                          activeColor: Colors.green,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ),
                      AppTextWidget(
                        text: "Remember me",
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                      Spacer(),
                      AppTextWidget(
                        text: "Forgot Password?",
                        fontSize: 16,
                        color: AppColorConstants.mainColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                CustomElevatedButton(title: 'Sign in'),
                SizedBox(height: 12,),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTextWidget(text: "Don't have account? ", fontSize: 14),
                      AppTextWidget(
                        text: "Sign Up",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 1,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black87),
                          ),
                        ),
                      ),
                      AppTextWidget(text: "  OR  ", fontSize: 14),
                      Container(
                        width: 50,
                        height: 1,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black87),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                loginOptionsWidget(
                    heading: "Continue with Google",

                    logoPath: "assets/images/branding_guideline_sample_lt_rd_sl.svg"),
                loginOptionsWidget(
                    heading: "Continue with Apple",
                    logoPath: "assets/images/Apple_logo_black.svg",
                    logoColor: Colors.black87),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget headerText(String header) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: AppTextWidget(
      text: header,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: AppColorConstants.black121212,
    ),
  );
}


Widget loginOptionsWidget(
    {required String logoPath, required String heading, Color? logoColor}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32),
      border: Border.all(color: AppColorConstants.hintColor)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          logoPath,
          height: 32,
          width: 40,
          color: logoColor,
        ),
        const SizedBox(width: 12),
        AppTextWidget(
          text: heading,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ],
    ),
  );
}