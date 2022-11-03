import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shreemad_bhagavad_gita/Blocs/language_bloc/language_bloc.dart';
import 'package:shreemad_bhagavad_gita/pages/gita_chapter_page.dart';
import 'package:shreemad_bhagavad_gita/utils/my_colors.dart';

import '../common/common_font_style.dart';
import '../utils/my_assets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = "English";
  final LanguageBloc languageBloc = LanguageBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLanguage();
  }

  getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    switch (prefs.getString('lang')) {
      case 'en':
        dropdownValue = "English";
        break;
      case 'hi':
        dropdownValue = "Hindi";
        break;
      case 'gu':
        dropdownValue = "Gujarati";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: languageBloc,
      builder: (context, state) {
        if (state is ChangeLanguageState) {
          context.setLocale(Locale(state.language));
          log(state.language);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("appTitle".tr()),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: DropdownButton(
                  value: dropdownValue,
                  items: ['English', 'Hindi', 'Gujarati'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    //get value when changed
                    dropdownValue = value.toString();
                    switch (value) {
                      case 'English':
                        languageBloc.add(ChangeLanguageEvent(language: 'en'));
                        prefs.setString('lang', 'en');
                        break;
                      case 'Hindi':
                        languageBloc.add(ChangeLanguageEvent(language: 'hi'));
                        prefs.setString('lang', 'hi');
                        break;
                      case 'Gujarati':
                        languageBloc.add(ChangeLanguageEvent(language: 'gu'));
                        prefs.setString('lang', 'gu');
                        break;
                    }
                    print("You have selected $value");
                  },
                  iconEnabledColor: MyColor.textColor,
                  style: MyTextStyles().myTextStyle(),
                  dropdownColor: Colors.black54,
                  underline: Container(), //remove underline
                ),
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              // color: Color(0xFF592720),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(MyAssetsImage.appBackground),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.white,
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "appTitle".tr(),
                            style: MyTextStyles().myTextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: MyColor.headerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          width: 200.w,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image:
                                    AssetImage(MyAssetsImage.buttonBackImage),
                                fit: BoxFit.fill),
                            color: MyColor.appButtonColor,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GitaChapterPage(
                                            language: dropdownValue,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "homePageBtnText".tr(),
                                  style: MyTextStyles().myTextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    languageBloc.close();
  }
}
