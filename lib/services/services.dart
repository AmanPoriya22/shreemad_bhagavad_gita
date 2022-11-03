import 'package:flutter/services.dart';

import '../model/GitaAllAdyayEnglishModel.dart';
import '../model/gita_chapters_model.dart';
import '../model/sample_model.dart';
import '../utils/my_assets.dart';

class MyServices {
  Future<List<GitaChapterModel>> getGitaChapterData() async {
    String response = await rootBundle.loadString(MyAssetsJson.gitaChapterData);
    final List<GitaChapterModel> gitaChapterModel =
        gitaChapterModelFromJson(response);

    return gitaChapterModel;
  }

  Future<GitaAllAdyayHindiModel> getGitaAllAdyayHindiData() async {
    String response =
        await rootBundle.loadString(MyAssetsJson.gitaAllAdyayHindi);
    final GitaAllAdyayHindiModel gitaAllAdyayHindiModel =
        gitaAllAdyayHindiModelFromJson(response);

    return gitaAllAdyayHindiModel;
  }

  Future<GitaAllAdyayEnglishModel> getGitaAllAdyayEnglishData() async {
    String response =
        await rootBundle.loadString(MyAssetsJson.gitaAllAdyayEnglish);
    final GitaAllAdyayEnglishModel gitaAllAdyayEnglishModel =
        gitaAllAdyayEnglishModelFromJson(response);

    return gitaAllAdyayEnglishModel;
  }
}
