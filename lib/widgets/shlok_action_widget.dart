import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';

import '../Blocs/page_view_bloc/page_view_bloc.dart';
import '../utils/my_assets.dart';
import '../utils/my_colors.dart';

Widget shlokActionWidget({
  required PageViewStateBloc pageViewStateBloc,
  required PageController pageController,
  required String chapterNumber,
  required List<dynamic> verse,
  required ScreenshotController screenshotController,
  required BuildContext context,
}) {

  bool changeFavoriteIcon = false;

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 50.w,
            decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(MyAssetsImage.buttonBackImage),
                ),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {
                pageViewStateBloc.add(OnPreviousPressEvent());
              },
              icon: Icon(
                size: 30,
                Icons.arrow_back_sharp,
                color:MyColor.btnEnableColor,
              ),
            ),
          ),
          Container(
            width: 50.w,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  MyAssetsImage.buttonBackImage,
                ),
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                pageViewStateBloc.add(OnSpeakPressEvent());
              },
              icon: Icon(
                size: 30,
                Icons.play_arrow_sharp,
                color: MyColor.textColor,
              ),
            ),
          ),
          Container(
            width: 50.w,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(MyAssetsImage.buttonBackImage),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                log('${pageController.page!.toInt()}');
                pageViewStateBloc.add(OnNextPressEvent());
                // context.read<PageViewStateBloc>().add(OnNextPressEvent(pageIndex: pageController!.page!.toInt()));
              },
              icon: Icon(
                size: 30,
                Icons.arrow_forward_sharp,
                color: MyColor.textColor,
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 50.w,
            decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(MyAssetsImage.buttonBackImage),
                ),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () async {
                pageViewStateBloc.add(OnFavoriteIconPressEvent());
                log('${verse[pageController.page!.toInt()].verseNumber.toString()}');

              },
              icon: BlocBuilder<PageViewStateBloc, PageViewStateState>(
                bloc: pageViewStateBloc,
                builder: (context, state) {
                  if (state is OnFavoriteIconPressState) {
                    log("Favorite");
                    changeFavoriteIcon = !changeFavoriteIcon;
                  }
                  return Icon(
                    size: 30,
                    changeFavoriteIcon == true
                        ? Icons.favorite
                        : Icons.favorite_border_sharp,
                    color: MyColor.textColor,
                  );
                },
              ),
            ),
          ),
          Container(
            width: 50.w,
            decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(MyAssetsImage.buttonBackImage),
                ),
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(
                    text:
                    "|| ${"shlokPageChapterNumber".tr()} : ${chapterNumber.toString()} || \n || ${"shlokPageVerseNumber".tr()} : ${verse[pageController.page!.toInt()].verseNumber.toString()} || \n"
                        "\n ~: ${"shlokPageVerse".tr()} :~ "
                        "\n${verse[pageController.page!.toInt()].text.toString()}"
                        "\n ~: ${"shlokPageMeaning".tr()} :~ "
                        "\n${verse[pageController.page!.toInt()].meaning.toString()}"))
                    .then((value) {
                  print("copied successfully");
                  Fluttertoast.showToast(
                      msg: "copied successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                });
              },
              icon: Icon(
                size: 30,
                Icons.file_copy_outlined,
                color: MyColor.textColor,
              ),
            ),
          ),
          Container(
            width: 50.w,
            decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(MyAssetsImage.buttonBackImage),
                ),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () async {
                var showProgressBar = true;

                if (showProgressBar == true) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200.h,
                            height: 200.h,
                            child: const AlertDialog(
                              content: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }

                await screenshotController.capture().then((value) {
                  if (value!.isNotEmpty) {
                    Navigator.pop(context);
                    log(value.length.toString());
                    shareFile(value);
                  }
                }).catchError((onError) {
                  print(onError);
                });
              },
              icon: Icon(
                size: 30,
                Icons.share_sharp,
                color: MyColor.textColor,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Future<void> shareFile(Uint8List byte) async {
  final Directory temp = await getTemporaryDirectory();
  final imageFile = await File('${temp.path}/tempImage.png').create();
  imageFile.writeAsBytesSync(byte);
  log(imageFile.path.toString());
  ShareExtend.share(imageFile.path, "image");
}
