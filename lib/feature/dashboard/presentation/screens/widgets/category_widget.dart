import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../notifier/products_notifier.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 12, left: 8, right: 8),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryList[index];
              return Container(
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColorConstants.foundationWhite,
                  border: Border.all(color: AppColorConstants.appMainColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(category.name),
                    SizedBox(width: 6),
                    Image.asset(category.icon, width: 20, height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
