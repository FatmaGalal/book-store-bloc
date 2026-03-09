import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/cubits/locale_cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSwitchButton extends StatelessWidget {
  const LanguageSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kPrimaryColor),
      ),
      child: PopupMenuButton<Locale>(
        icon: const Icon(Icons.language, color: kPrimaryColor),
        onSelected: (Locale locale) {
          context.read<LocaleCubit>().setLocale(locale);
        },
        color: isDark ? kIconDimmedColor1 : kLightBGColor,
        itemBuilder: (context) {
          return [
            PopupMenuItem(value: Locale('en'), child: Text("English")),
            PopupMenuItem(value: Locale('ar'), child: Text("العربية")),
          ];
        },
      ),
    );
  }
}
