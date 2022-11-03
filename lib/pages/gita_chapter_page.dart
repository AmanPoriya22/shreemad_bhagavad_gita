import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:shreemad_bhagavad_gita/common/common_font_style.dart';
import 'package:shreemad_bhagavad_gita/utils/my_assets.dart';
import 'package:shreemad_bhagavad_gita/utils/my_colors.dart';

import '../services/services.dart';
import 'gita_shlok_page.dart';

class GitaChapterPage extends StatefulWidget {
  GitaChapterPage({super.key, required this.language});

  String language;

  @override
  State<GitaChapterPage> createState() => _GitaChapterPageState();
}

class _GitaChapterPageState extends State<GitaChapterPage> {
  dynamic gitaAllAdyayModel;

  // Dio dio = Dio();
  // List data = [];

  // Future<List> getGitaDataFromApi() async {
  //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //       (HttpClient client) {
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //     return client;
  //   };
  //
  //   try {
  //     Response response = await dio.get("https://bhagavadgitaapi.in/chapters");
  //     log(response.data.toString());
  //     return response.data;
  //   } catch (e) {
  //     log("Error : ${e.toString()}");
  //   }
  //   return [];
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch(widget.language){
      case 'English':
        MyServices().getGitaAllAdyayEnglishData().then((gitaAllAdyayEnglish) {
          setState(() {
            gitaAllAdyayModel = gitaAllAdyayEnglish;
          });
        });
        break;
      case 'Hindi':
        MyServices().getGitaAllAdyayHindiData().then((gitaAllAdyayHindi) {
          setState(() {
            gitaAllAdyayModel = gitaAllAdyayHindi;
          });
        });
        break;
      case 'Gujarati':

        break;
    }


    // getGitaDataFromApi().then((value) {
    //   data = value;
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {

    // data.forEach((element) {
    //   log(element['verses_count'].toString());
    //   log(element.toString());
    // });

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(MyAssetsImage.appBackground),
          ),
        ),
        child: gitaAllAdyayModel == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: gitaAllAdyayModel!.chapters!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      child: InkWell(
                        onTap: () {
                          print('Hello ${gitaAllAdyayModel!.chapters![index].name}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => GitaShlokPage(
                                    chapterName: gitaAllAdyayModel!
                                        .chapters![index].name
                                        .toString(),
                                    verse: gitaAllAdyayModel!
                                        .chapters![index].verse!,
                                    chapterNumber: gitaAllAdyayModel!
                                        .chapters![index].chapterNumber
                                        .toString(),
                                  )),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(MyAssetsImage.buttonBackImage),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black12,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: MyColor.appButtonColor,
                                    child: Text(
                                      gitaAllAdyayModel!
                                          .chapters![index].chapterNumber
                                          .toString(),
                                      style: MyTextStyles().myTextStyle(),
                                    ),
                                  ),
                                  Text(
                                    gitaAllAdyayModel!
                                        .chapters![index].name
                                        .toString(),
                                    style: MyTextStyles().myTextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const CircleAvatar(
                                      backgroundColor: Colors.transparent),
                                ],
                              ),
                              const Divider(color: Colors.yellow),
                              Text(
                                "${"shlokPageVerse".tr()} : ${gitaAllAdyayModel!.chapters![index].versesCount.toString()}",
                                style: MyTextStyles().myTextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                color: Colors.yellow.shade800,
                                width: 50.w,
                                height: 1,
                              ),
                              ReadMoreText(
                                "${"chapterPageSummery".tr()} :\n ${gitaAllAdyayModel!.chapters![index].chapterSummary.toString()}",
                                trimLines: 3,
                                colorClickableText: Colors.blueAccent,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: "chapterPageReadMore".tr(),
                                trimExpandedText: '  ${"chapterPageReadLess".tr()}',
                                style: MyTextStyles().myTextStyle(
                                  fontSize: 16,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
