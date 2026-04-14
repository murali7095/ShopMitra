import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common_widget/app_text_widget.dart';
import '../../../../../core/constants/app_colors.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColorConstants.mainColor,
      pinned: false,
      //expandedHeight: 100,
      floating: false,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16, top: 16),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColorConstants.textFieldBackground,
          ),
          child: Icon(
            Icons.notification_add_sharp,
            color: AppColorConstants.borderColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 16, top: 16),
          //padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColorConstants.accentColor),
          ),
          child: GestureDetector(
            onTap: () {
              context.push("/user_profile");
            },
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl:
                    "https://i.pinimg.com/736x/e8/e6/41/e8e64141f4c0ae39c32f9701ccea9a2e.jpg",
                fit: BoxFit.cover, // use cover to fill the circle nicely
                placeholder: (context, url) =>
                    Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
          ),
        ),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              AppTextWidget(
                text: " Address",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColorConstants.secondaryColor,
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: AppColorConstants.secondaryColor,
                    size: 25,
                  ),
                  SizedBox(width: 4),
                  AppTextWidget(
                    text: "HYDERABAD, INDIA",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColorConstants.secondaryColor,
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColorConstants.secondaryColor,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
