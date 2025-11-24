import 'package:flutter/material.dart';
class AppColorConstants {
  //static const Color appMainColorBlue = Color(0xFF004AAD);

  // Light Background Shades
  static const bg_light = Color(0xFFF7F7F7);        // very light grey / white
  static const bg_cream = Color(0xFFE7E4E0);        // soft cream / card background
  static const bg_beige = Color(0xFFD5CEC7);        // muted beige

// Brown / Warm Neutral Shades
  static const brown_soft = Color(0xFFBFB1A7);      // soft warm brown
  static const brown_light = Color(0xFFB49885);     // light brown (product details)
  static const brown_medium = Color(0xFF947766);    // medium button brown
  static const brown_dark = Color(0xFF6F5242);      // deep brown

// Dark Elements / Icons / Footer
  static const dark_charcoal = Color(0xFF261F22);   // almost black (footer)




  static const Color mainColor = Color(0xFF191970);
  static const Color secondaryColor = Color(0xFF2EE4D4);
  static const Color hintColor = Color(0xFFB9B9B9);
  static const Color lightBlue = Color(0xFFE6F0FF); // For backgrounds or surfaces
  static const foundationWhite = Color(0xFFFFFFFF);
  static const vibrant_sky_blue = Color(0xFF1E91D9);
  static const mounted_blue_green = Color(0xFF006977);
  static const ocean_mint = Color(0xFF00a99d);
  static const pink_nova = Color(0xFFff7bac);
  static const sun_set = Color(0xFfff7454);
  static const appMainColor = Color(0xFF0d665c);
  static const foundationSuccess50 = Color(0xFFF0FDF4);
  static const triSource = Color(0xFFECFEFF);
  static const triSourceBorder = Color(0xFF06B6D4);
  static const foundationInfo200 = Color(0xFFBFDBFE);
  static const foundationPrimary800 = Color(0xFF07395B);
  static const foundationSec500 = Color(0xFFEAB308);
  static const gasBgColor = Color(0xFFFFCA28);
  static const foundationInfo50 = Color(0xFFEFF6FF);
  static const foundationPrimary300 = Color(0xFFA4CDE9);
  static const bgNeutral50 = Color(0xFFF8FAFC);
  static const boxShadowCCDFEB = Color(0xFFCCDFEB);
  static const foundationPrimary100 = Color(0xFFEEF8FF);
  static const contentNeutral500 = Color(0xFF64748B);
  static const bgPrimary500 = Color(0xFF1076BC);
  static const bgNeutral200 = Color(0xFFE2E8F0);
  static const contentNeutral900 = Color(0xFF0F172A);
  static const borderNeutral300 = Color(0xFFCBD5E1);
  static const contentNeutral400 = Color(0xFF94A3B8);
  static const borderNeutral600 = Color(0xFF475569);
  static const contentNeutral600 = Color(0xFF475569);
  static const color22302F = Color(0xFF22302F);
  static const borderPrimary400 = Color(0xFF5AA1D2);
  static const statusSuccess = Color(0xFF00A36B);
  static const foundationSecondary50 = Color(0xFFFEFCE8);
  static const errorBg = Color(0xFFEF4444);
  static const strokeBlack3333 = Color(0xFF333333);
  static const black000000 = Color(0xFF000000);
  static const black2424 = Color(0xFF242424);
  static const black121212 = Color(0xFF121212);
  static const black07070= Color(0xFF707070);
  static const bottomBarColor = Color(0xFFD1F1FF);
  static const selectedBottomBarColor = Color(0xFF0470B6);
  static const paymentSuccess = Color(0xFF22C55E);
  static const dashBoardColor = Color(0xFF2387C8);
  static const dashBoardTextColor = Color(0xFFFAFDFF);
  static const dashBoardTextColor737791 = Color(0xFF737791);
  static const dashBoardGasColor = Color(0xFFFFF5F5);
  static const dashBoardElectricityColor = Color(0xFF66BB6A);
  static const circleColor = Color(0xFFF1F5F9);
  static const barChartColor = Color(0xFFB0DBF8);
  static const consumptionStatsColor = Color(0xFF63ABFD);
  static const onboardScreenFocusedText = Color(0xFF2D2B2E);
  static const onboardScreenDescText = Color(0xFF292829);
}
class PaymentCategoryStyles {
  static const electricity = CategoryStyle(
    iconColor: AppColorConstants.dashBoardElectricityColor,
    backgroundColor: AppColorConstants.dashBoardGasColor,
  );

  static const internet = CategoryStyle(
    iconColor: AppColorConstants.vibrant_sky_blue,
    backgroundColor: AppColorConstants.foundationInfo50,
  );

  static const water = CategoryStyle(
    iconColor: AppColorConstants.ocean_mint,
    backgroundColor: AppColorConstants.foundationPrimary100, // updated
  );

  static const hotel = CategoryStyle(
    iconColor: AppColorConstants.pink_nova,
    backgroundColor: AppColorConstants.foundationSecondary50,
  );

  static const food = CategoryStyle(
    iconColor: AppColorConstants.mounted_blue_green,
    backgroundColor: AppColorConstants.foundationSecondary50, // updated
  );

  static const movies = CategoryStyle(
    iconColor: AppColorConstants.sun_set,
    backgroundColor: AppColorConstants.foundationSecondary50, // updated
  );

  static const games = CategoryStyle(
    iconColor: AppColorConstants.foundationSec500,
    backgroundColor: AppColorConstants.foundationInfo50, // updated
  );

  static const shopping = CategoryStyle(
    iconColor: AppColorConstants.statusSuccess,
    backgroundColor: AppColorConstants.foundationPrimary100,
  );

  static const recharge = CategoryStyle(
    iconColor: AppColorConstants.bgPrimary500,
    backgroundColor: AppColorConstants.bottomBarColor,
  );

  static const education = CategoryStyle(
    iconColor: AppColorConstants.mounted_blue_green,
    backgroundColor: AppColorConstants.triSource,
  );

  static const transportation = CategoryStyle(
    iconColor: AppColorConstants.sun_set,
    backgroundColor: AppColorConstants.foundationInfo50,
  );

  static const subscription = CategoryStyle(
    iconColor: AppColorConstants.foundationPrimary800,
    backgroundColor: AppColorConstants.foundationPrimary100,
  );

  static const health = CategoryStyle(
    iconColor: AppColorConstants.errorBg,
    backgroundColor: AppColorConstants.foundationSecondary50, // updated
  );

  static const insurance = CategoryStyle(
    iconColor: AppColorConstants.bgPrimary500,
    backgroundColor: AppColorConstants.foundationPrimary100,
  );

  static const other = CategoryStyle(
    iconColor: AppColorConstants.black07070,
    backgroundColor: AppColorConstants.bgNeutral200,
  );
}


class CategoryStyle {
  final Color iconColor;
  final Color backgroundColor;

  const CategoryStyle({
    required this.iconColor,
    required this.backgroundColor,
  });
}

