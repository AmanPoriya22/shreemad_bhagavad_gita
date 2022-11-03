import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shreemad_bhagavad_gita/utils/my_assets.dart';

import '../Blocs/page_view_bloc/page_view_bloc.dart';
import '../common/common_font_style.dart';
import '../utils/my_colors.dart';
import '../widgets/shlok_action_widget.dart';
import '../widgets/shlok_display_widget.dart';

class GitaShlokPage extends StatefulWidget {
  GitaShlokPage(
      {super.key,
      required this.chapterName,
      required this.verse,
      required this.chapterNumber});

  String chapterName;
  String chapterNumber;
  List<dynamic> verse;

  @override
  State<GitaShlokPage> createState() => _GitaShlokPageState();
}

class _GitaShlokPageState extends State<GitaShlokPage> {
  PageController? pageController;
  bool disablePreviousButton = false;
  bool showProgressBar = false;

  final PageViewStateBloc pageViewStateBloc = PageViewStateBloc();
  ScreenshotController screenshotController = ScreenshotController();

  bool changeFavoriteIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.verse.sort((a, b) => a.verseId.compareTo(b.verseId.toInt()));
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    log("Gita Shlok Length : ${widget.verse.length.toString()}");
    log("Chapter Number : ${widget.chapterNumber.toString()}");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chapterName,
          style: MyTextStyles().myTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyAssetsImage.appBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: shlokDisplayWidget(
                pageController: pageController!,
                screenshotController: screenshotController,
                pageViewStateBloc: pageViewStateBloc,
                verse: widget.verse,
                chapterNumber: widget.chapterNumber,
              ),
            ),
            Expanded(
              flex: 2,
              child: shlokActionWidget(
                pageViewStateBloc: pageViewStateBloc,
                pageController: pageController!,
                chapterNumber: widget.chapterNumber,
                verse: widget.verse,
                screenshotController: screenshotController,
                context: context,
              ),
            ),
            // Expanded(
            //   flex: 2,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Container(
            //             width: 50.w,
            //             decoration: BoxDecoration(
            //                 image: const DecorationImage(
            //                   fit: BoxFit.fill,
            //                   image: AssetImage(MyAssetsImage.buttonBackImage),
            //                 ),
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: IconButton(
            //               onPressed: () {
            //                 pageViewStateBloc.add(OnPreviousPressEvent());
            //               },
            //               icon: Icon(
            //                 size: 30,
            //                 Icons.arrow_back_sharp,
            //                 color: MyColor.btnEnableColor,
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: 50.w,
            //             decoration: BoxDecoration(
            //               image: const DecorationImage(
            //                 fit: BoxFit.fill,
            //                 image: AssetImage(
            //                   MyAssetsImage.buttonBackImage,
            //                 ),
            //               ),
            //               borderRadius: BorderRadius.circular(50),
            //             ),
            //             child: IconButton(
            //               onPressed: () {
            //                 pageViewStateBloc.add(OnSpeakPressEvent());
            //               },
            //               icon: Icon(
            //                 size: 30,
            //                 Icons.play_arrow_sharp,
            //                 color: MyColor.textColor,
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: 50.w,
            //             decoration: BoxDecoration(
            //               image: const DecorationImage(
            //                 fit: BoxFit.fill,
            //                 image: AssetImage(MyAssetsImage.buttonBackImage),
            //               ),
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //             child: IconButton(
            //               onPressed: () {
            //                 log('${pageController!.page!.toInt()}');
            //                 pageViewStateBloc.add(OnNextPressEvent());
            //                 // context.read<PageViewStateBloc>().add(OnNextPressEvent(pageIndex: pageController!.page!.toInt()));
            //               },
            //               icon: Icon(
            //                 size: 30,
            //                 Icons.arrow_forward_sharp,
            //                 color: MyColor.textColor,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Container(
            //             width: 50.w,
            //             decoration: BoxDecoration(
            //                 image: const DecorationImage(
            //                   fit: BoxFit.fill,
            //                   image: AssetImage(MyAssetsImage.buttonBackImage),
            //                 ),
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: IconButton(
            //               onPressed: () async {
            //                 pageViewStateBloc.add(OnFavoriteIconPressEvent());
            //                 log('${widget.verse[pageController!.page!.toInt()].verseNumber.toString()}');
            //
            //               },
            //               icon: BlocBuilder<PageViewStateBloc,
            //                   PageViewStateState>(
            //                 bloc: pageViewStateBloc,
            //                 builder: (context, state) {
            //                   if (state is OnFavoriteIconPressState) {
            //                     log("Favorite");
            //                     changeFavoriteIcon = !changeFavoriteIcon;
            //                   }
            //                   return Icon(
            //                     size: 30,
            //                     changeFavoriteIcon == true
            //                         ? Icons.favorite
            //                         : Icons.favorite_border_sharp,
            //                     color: MyColor.textColor,
            //                   );
            //                 },
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: 50.w,
            //             decoration: BoxDecoration(
            //                 image: const DecorationImage(
            //                   fit: BoxFit.fill,
            //                   image: AssetImage(MyAssetsImage.buttonBackImage),
            //                 ),
            //                 borderRadius: BorderRadius.circular(50)),
            //             child: IconButton(
            //               onPressed: () async {
            //                 await Clipboard.setData(ClipboardData(
            //                         text:
            //                             "|| ${"shlokPageChapterNumber".tr()} : ${widget.chapterNumber.toString()} || \n || ${"shlokPageVerseNumber".tr()} : ${widget.verse[pageController!.page!.toInt()].verseNumber.toString()} || \n"
            //                             "\n ~: ${"shlokPageVerse".tr()} :~ "
            //                             "\n${widget.verse[pageController!.page!.toInt()].text.toString()}"
            //                             "\n ~: ${"shlokPageMeaning".tr()} :~ "
            //                             "\n${widget.verse[pageController!.page!.toInt()].meaning.toString()}"))
            //                     .then((value) {
            //                   print("copied successfully");
            //                   Fluttertoast.showToast(
            //                       msg: "copied successfully",
            //                       toastLength: Toast.LENGTH_SHORT,
            //                       gravity: ToastGravity.SNACKBAR,
            //                       timeInSecForIosWeb: 1,
            //                       fontSize: 16.0);
            //                 });
            //               },
            //               icon: Icon(
            //                 size: 30,
            //                 Icons.file_copy_outlined,
            //                 color: MyColor.textColor,
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: 50.w,
            //             decoration: BoxDecoration(
            //                 image: const DecorationImage(
            //                   fit: BoxFit.fill,
            //                   image: AssetImage(MyAssetsImage.buttonBackImage),
            //                 ),
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: IconButton(
            //               onPressed: () async {
            //                 var showProgressBar = true;
            //
            //                 if (showProgressBar == true) {
            //                   showDialog(
            //                     context: context,
            //                     barrierDismissible: false,
            //                     builder: (BuildContext context) {
            //                       return Column(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           SizedBox(
            //                             width: 200.h,
            //                             height: 200.h,
            //                             child: const AlertDialog(
            //                               content: Center(
            //                                 child: CircularProgressIndicator(),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       );
            //                     },
            //                   );
            //                 }
            //
            //                 await screenshotController.capture().then((value) {
            //                   if (value!.isNotEmpty) {
            //                     Navigator.pop(context);
            //                     log(value.length.toString());
            //                     shareFile(value);
            //                   }
            //                 }).catchError((onError) {
            //                   print(onError);
            //                 });
            //               },
            //               icon: Icon(
            //                 size: 30,
            //                 Icons.share_sharp,
            //                 color: MyColor.textColor,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageViewStateBloc.close();
    pageController!.dispose();
  }
}
