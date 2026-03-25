import 'package:book_store/src/core/components/bookmark_icon.dart';
import 'package:book_store/src/core/components/language_switch_button.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/utils/assets_data.dart';
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
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = width < 380;
    final logoSize = isCompact ? 44.0 : 60.0;
    final titleFontSize = isCompact ? 18.0 : 20.0;

    return Padding(
      padding: const EdgeInsets.all(12),
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
          const SizedBox(width: 8),
          if (hasIcon) BookmarkIcon(),
          LanguageSwitchButton(),
        ],
      ),
    );
  }
}
