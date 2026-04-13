
import 'package:flutter/material.dart';

import '../../../../../core/common_widget/app_text_widget.dart';
import '../../../../../core/constants/app_colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 20),
        color: AppColorConstants.mainColor,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColorConstants.textFieldBackground,
                  border: Border.all(color: AppColorConstants.accentColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 12),
                    Icon(
                      Icons.search_rounded,
                      color: AppColorConstants.textFieldHint,
                      size: 30,
                      fontWeight: FontWeight.w500,
                    ),
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          focusColor: AppColorConstants.accentColor,
                          hint: AppTextWidget(
                            fontSize: 16,
                            text: "Search Product",
                            fontWeight: FontWeight.w400,
                            color: AppColorConstants.textFieldHint,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.all(7.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColorConstants.textFieldBackground,
              ),
              child: Icon(
                Icons.filter_list_outlined,
                color: AppColorConstants.textFieldHint,
                size: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}