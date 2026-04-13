import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:shop_mitra/core/app_navigations/route_constants.dart';
import 'package:shop_mitra/core/common_widget/app_text_widget.dart';
import 'package:shop_mitra/core/common_widget/custom_elevated_button.dart';
import 'package:shop_mitra/feature/authentication/presentation/controllers/login_controller.dart';

import '../controllers/auth_controller.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    // Heights are relative to screen height
    final containerHeight = size.height * 0.25;
    final cutHeight = containerHeight * 0.3; // same as clipper

    // Padding/Margin relative to screen
    final horizontalPadding = size.width * 0.03;
    final topMargin = size.height * 0.05;
    final bottomMargin = size.height * 0.01;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack for overlapping right image
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Top container with half cut
                ClipPath(
                  clipper: BottomHalfCutClipper(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    height: containerHeight,
                    margin: EdgeInsets.only(
                      top: topMargin,
                      left: horizontalPadding,
                      right: horizontalPadding,
                      bottom: bottomMargin,
                    ),
                    width: size.width,
                    decoration:   BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        tileMode: TileMode.decal,
                        colors: [
                          Color(0xFFFFF5E1), // Soft Cream
                          Color(0xFFE6D2B5), // Soft Sand Cream
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Left image inside container
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/image/kids.jpg',
                            width: size.width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Text content
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: containerHeight * 0.05),
                              const AppTextWidget(
                                text: "All Kids Fashion",
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              SizedBox(height: containerHeight * 0.02),
                              const AppTextWidget(
                                text:
                                "Designed to spark joy and creativity every child. With a focus on comfort and quality.",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),

                // Right image starting from cut area
                Positioned(
                  top: topMargin + containerHeight - cutHeight,
                  right: horizontalPadding,
                  width: size.width * 0.45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/image/women_walk.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),

            // Left image below container
          /*  Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding * 2,
                  vertical: size.height * 0.015,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    'assets/image/man_standing.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: Image.asset(
                  alignment: Alignment.topLeft,
                  height: size.height/3,
                  'assets/image/man_standing.jpg',
                  width: size.width/2,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 12),
              child: AppTextWidget(text: "Welcome to Mitra!",fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey.shade700,),
            ),
            Container(
              alignment: Alignment.center,
              child: AppTextWidget(text: "Get ready to style yourself in fashion forward outfits for every occasion.",fontSize: 22,fontWeight: FontWeight.bold, textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomElevatedButton(
                title: "Get Started",onPressed: () async {
                await ref
                    .read(authProvider.notifier)
                    .setHasSeenLanding(true);

                if (context.mounted) {
                  context.go("/login");
                }
              }
                ,fontWeight: FontWeight.w600,backgroundColor: Colors.black87,borderRadius: 12,),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                AppTextWidget(text: "Already have an account?",color: Colors.grey.shade600,fontSize: 14,),
                GestureDetector(onTap: () async {
                  await ref
                      .read(authProvider.notifier)
                      .setHasSeenLanding(true);

                  if (context.mounted) {
                    context.go("/login");
                  }
                }
                  ,child: AppTextWidget(text: " Login", fontSize: 16,)),


              ],),
            )
          ],
        ),
      ),
    );
  }
}

/// Clipper stays same, cut radius remains relative to design
class BottomHalfCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final halfWidth = size.width * 0.5;
    final cutHeight = size.height * 0.3;
    const radius = 18.0;

    // Top-left
    path.moveTo(0, 0);

    // Top edge
    path.lineTo(size.width, 0);

    // Right side down to start of cut
    path.lineTo(size.width, size.height - cutHeight - radius);

    // Rounded top-right corner of cut
    path.arcToPoint(
      Offset(size.width - radius, size.height - cutHeight),
      radius: const Radius.circular(radius),
      clockwise: false,
    );

    // Horizontal to half-width
    path.lineTo(halfWidth + radius, size.height - cutHeight);

    // Rounded inner vertical cut corner
    path.arcToPoint(
      Offset(halfWidth, size.height - cutHeight + radius),
      radius: const Radius.circular(radius),
      clockwise: false,
    );

    // Down to bottom (left half full height)
    path.lineTo(halfWidth, size.height);

    // Bottom edge
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
