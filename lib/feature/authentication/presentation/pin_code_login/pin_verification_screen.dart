import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_mitra/feature/authentication/presentation/pin_code_login/pin_provider.dart';

import '../../../../core/app_navigations/route_constants.dart';
import '../../../../core/common_widget/app_text_widget.dart';
import '../../../../core/common_widget/custom_elevated_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../controllers/auth_controller.dart';
import 'create_pin_screen.dart';
class PinVerificationScreen extends ConsumerStatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  ConsumerState<PinVerificationScreen> createState() =>
      _PinVerificationScreenState();
}

class _PinVerificationScreenState
    extends ConsumerState<PinVerificationScreen> {



  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    /// Listen for match and navigate
    ref.listen(pinVerificationProvider, (prev, next) {
      if (next.userPin.length == 4 &&
          next.userPin != next.localPin) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Incorrect PIN")),
        );

        ref.read(pinVerificationProvider.notifier).clear();
      }
    });


    final state = ref.watch(pinVerificationProvider);

    return Scaffold(
      backgroundColor: AppColorConstants.foundationWhite,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                AppTextWidget(
                  text: "Hi, Murali Mohan Reddy",
                  fontSize: 26,
                ),
                SizedBox(height: 12,),
                AppTextWidget(
                  text: "Enter your Mitra PIN",
                  fontSize: 18,
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 8),
                  child: buildPinCodeTextField(
                    key: "user_pin",
                    context: context,
                      onChanged: (v) {
                        ref.read(pinVerificationProvider.notifier)
                            .updateUserPin(v);

                        if (v.length == 4 &&
                            v == state.localPin) {

                          ref.read(authProvider.notifier)
                              .setPinVerificationStatus(true);
                        }
                      },


                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
                  child: CustomElevatedButton(
                    title: "Verify",
                    onPressed: state.userPin.length == 4 &&
                        state.userPin == state.localPin
                        ? () {
                      ref.read(authProvider.notifier)
                          .setPinVerificationStatus(true);
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


