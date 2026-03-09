import 'package:book_store/l10n/app_localizations.dart';
import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/core/cubits/locale_cubit/locale_cubit.dart';
import 'package:book_store/src/core/helpers/init_hive.dart';
import 'package:book_store/src/core/services/setup_dependencies.dart';
import 'package:book_store/src/features/authentication/presentation/pages/signup_page.dart';
import 'package:book_store/src/features/home/presentation/cubits/favorites_books_cubits/favorites_books_cubit.dart';
import 'package:book_store/src/features/home/presentation/pages/book_details_page.dart';
import 'package:book_store/src/features/home/presentation/pages/book_listing_page.dart';
import 'package:book_store/src/features/home/presentation/pages/favorite_books_page.dart';
import 'package:book_store/src/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUpDependencies();
  runApp(BookStoreApp());
}

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavoritesBooksCubit()),
        BlocProvider(create: (context) => LocaleCubit()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.locale,
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routes: {
              SignUpPage.id: (context) => SignUpPage(),
              LoginPage.id: (context) => LoginPage(),
              BookListingPage.id: (context) => BookListingPage(),
              BookDetailsPage.id: (context) => BookDetailsPage(),
              FavoriteBooksPage.id: (context) => FavoriteBooksPage(),
            },
            debugShowCheckedModeBanner: false,
            title: 'Book Store',
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'Montserrat',
              scaffoldBackgroundColor: kLightBGColor,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'Montserrat',
              scaffoldBackgroundColor: kDarkBGColor,
            ),
            themeMode: ThemeMode.system,
            home: LoginPage(),
          );
        },
      ),
    );
  }
}
