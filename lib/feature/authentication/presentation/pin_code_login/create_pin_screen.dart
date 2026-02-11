import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shop_mitra/core/app_navigations/route_constants.dart';
import 'package:shop_mitra/core/common_widget/app_text_widget.dart';
import 'package:shop_mitra/core/common_widget/custom_elevated_button.dart';
import 'package:shop_mitra/core/constants/app_colors.dart';
import 'package:shop_mitra/feature/authentication/presentation/constants/auth_constants.dart';
import 'package:shop_mitra/feature/authentication/presentation/pin_code_login/pin_provider.dart';

import '../../../../core/app_navigations/routes.dart';
import '../controllers/auth_controller.dart';

class CreatePinScreen extends ConsumerStatefulWidget {
  const CreatePinScreen({super.key});

  @override
  ConsumerState<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends ConsumerState<CreatePinScreen> {
  late TextEditingController setPinController;
  late TextEditingController confirmPinController;
  final pinBox = Hive.box("pinBox");

  @override
  void initState() {
    super.initState();
    setPinController = TextEditingController();
    confirmPinController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      //  appBar: AppBar(backgroundColor: AppColorConstants.foundationWhite),
      backgroundColor: AppColorConstants.foundationWhite,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: 100,),
                Center(
                  child: AppTextWidget(
                    text: AuthConstants.createPin,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    fontSize: 26,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 10,
                    bottom: 20,
                  ),
                  child: Center(
                    child: AppTextWidget(
                      text: AuthConstants.setPinText,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 40),
                  child: AppTextWidget(
                    text: AuthConstants.enterNewPin,
                    textAlign: TextAlign.left,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 8,
                  ),
                  child: buildPinCodeTextField(
                    key: "set_key",
                    context: context,
                    onCompleted: (v) {
                      if (!mounted) return;
                      ref.read(createPinProvider.notifier).updateSetPin(v);
                    },
                    onChanged: (v) {
                      ref.read(createPinProvider.notifier).updateSetPin(v);

                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                  child: AppTextWidget(
                    text: AuthConstants.confirmPin,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 8,
                  ),
                  child: buildPinCodeTextField(
                    context: context,
                    key: "confirm_key",
                    onCompleted: (v) {
                      if (!mounted) return;
                      ref.read(createPinProvider.notifier).updateConfirmPin(v);
                    },

                    onChanged: (v) {
                      ref.read(createPinProvider.notifier).updateConfirmPin(v);

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
                  child: CustomElevatedButton(
                    title: "Continue",
                    onPressed: ref.watch(createPinProvider).isValid
                        ? () async {
                      final userPin =
                          ref.read(createPinProvider).confirmPin;

                      await ref
                          .read(authProvider.notifier)
                          .setPin(userPin);
                    }
                        : null,
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

PinCodeTextField buildPinCodeTextField({
  required BuildContext context,
  void Function(String)? onChanged,
  void Function(String)? onCompleted,
  required String key,
}) {
  return PinCodeTextField(
    key: ValueKey(key),
    autoDismissKeyboard: true,
    appContext: context,
    length: 4,
    obscureText: true,
    blinkWhenObscuring: false,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(12),
      fieldWidth: 50,
      fieldHeight: 50,
      activeColor: Colors.grey.shade400,
      activeFillColor: AppColorConstants.foundationWhite,
      inactiveFillColor: AppColorConstants.foundationWhite,
      inactiveColor: AppColorConstants.strokeBlack3333,
      selectedColor: AppColorConstants.black121212,
    ),
    onChanged: onChanged,
    onCompleted: onCompleted,

  );
}
