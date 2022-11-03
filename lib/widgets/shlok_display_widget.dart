import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

import '../Blocs/page_view_bloc/page_view_bloc.dart';
import '../common/common_font_style.dart';
import '../utils/my_assets.dart';
import '../utils/my_colors.dart';

Widget shlokDisplayWidget({
  required PageController pageController,
  required ScreenshotController screenshotController,
  required PageViewStateBloc pageViewStateBloc,
  required List<dynamic> verse,
  required String chapterNumber,
}) {
  return Screenshot(
    controller: screenshotController,
    child: BlocBuilder<PageViewStateBloc, PageViewStateState>(
      bloc: pageViewStateBloc,
      builder: (context, state) {
        if (state is PageViewStateInitial) {
          log("Initial");
        } else if (state is OnNextPressState) {
          pageController.nextPage(
              duration: const Duration(seconds: 1), curve: Curves.easeIn);
          log("Next");
        } else if (state is OnPreviousPressState) {
          pageController.previousPage(
              duration: const Duration(seconds: 1), curve: Curves.easeIn);
          log("Previous");
        } else if (state is OnSpeakPressState) {
          log("Speak code");
        } else if (state is OnFavoriteIconPressState) {
          log("Favorite");
        }

        return PageView.builder(
          onPageChanged: (value) {},
          controller: pageController,
          itemCount: verse.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(MyAssetsImage.buttonBackImage),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "|| ${"shlokPageChapterNumber".tr()} : ${chapterNumber.toString()} || \n || ${"shlokPageVerseNumber".tr()} : ${verse[index].verseNumber.toString()} || \n",
                        textAlign: TextAlign.center,
                        style: MyTextStyles()
                            .myTextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Divider(color: Colors.yellow),
                      Text(
                        '\n ~: ${"shlokPageVerse".tr()} :~ ',
                        style: MyTextStyles()
                            .myTextStyle(color: Colors.yellow.shade700),
                      ),
                      SelectableText(
                        "\n${verse[index].text.toString()}",
                        textAlign: TextAlign.center,
                        style: MyTextStyles().myTextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const Divider(color: Colors.yellow),
                      Text(
                        '\n ~: ${"shlokPageMeaning".tr()} :~ ',
                        style: MyTextStyles().myTextStyle(
                          color: Colors.yellow.shade700,
                        ),
                      ),
                      SelectableText(
                        "\n${verse[index].meaning.toString()}",
                        textAlign: TextAlign.center,
                        style: MyTextStyles().myTextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}
