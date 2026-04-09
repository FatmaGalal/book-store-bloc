import 'package:book_store/src/core/components/bookmark_icon.dart';
import 'package:book_store/src/core/components/language_switch_button.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/utils/assets_data.dart';
import 'package:book_store/src/core/utils/responsive_scale.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,

    required this.title,
    this.onPress,
    this.isSearch = false,
    this.onTextChanged,
    this.hasBackButton = false,
    this.onBackPressed,
    this.hasIcon = true,
  });

  final String title;
  final bool isSearch;
  final bool hasIcon;
  final bool hasBackButton;
  final void Function()? onPress;
  final void Function(String?)? onTextChanged;
  final void Function()? onBackPressed;
  @override
  Widget build(BuildContext context) {
    double scalingFactor = getScalingFactor(
      context,
    ); // Ensure scaling factor is calculated for this context
    final logoSize = 60.0 * scalingFactor;
    final titleFontSize = 20.0 * scalingFactor;

    return Padding(
      padding: EdgeInsets.all(12.0 * scalingFactor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (hasBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
              onPressed: onBackPressed,
            ),

          /// -- logo------
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Image.asset(
              AssetsData.book,
              width: logoSize,
              height: logoSize,
            ),
          ),

          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: titleFontSize,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.0 * scalingFactor),
          if (hasIcon) BookmarkIcon(),
          LanguageSwitchButton(),
        ],
      ),
    );
  }
}
