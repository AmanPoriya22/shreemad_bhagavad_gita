import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shreemad_bhagavad_gita/pages/home_page.dart';
import 'package:shreemad_bhagavad_gita/utils/appbar_theme.dart';
import 'package:shreemad_bhagavad_gita/utils/my_colors.dart';

import 'Blocs/page_view_bloc/page_view_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('gu'),
      ],
      path: 'assets/language',
      fallbackLocale: const Locale('hi'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => PageViewStateBloc()),
          ],
          child: MaterialApp(
            title: "Shreemad Bhagavad Gita",
            theme: ThemeData(
              // primaryColor: Color(0xFF6A2007),
              primarySwatch:
                  MaterialColor(MyColor.themeColor.value, MyColor.swatchColor),
              appBarTheme: appBarTheme(
                color: MyColor.themeColor,
                foregroundColor: Colors.white,
              ),
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const MyHomePage(),
          ),
        );
      },
    );
  }
}
