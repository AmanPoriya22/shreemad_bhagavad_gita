// To parse this JSON data, do
//
//     final gitaChapterModel = gitaChapterModelFromJson(jsonString);

import 'dart:convert';

List<GitaChapterModel> gitaChapterModelFromJson(String str) => List<GitaChapterModel>.from(json.decode(str).map((x) => GitaChapterModel.fromJson(x)));

String gitaChapterModelToJson(List<GitaChapterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GitaChapterModel {
  GitaChapterModel({
    this.id,
    this.chapterNumber,
    this.chapterSummary,
    this.chapterSummaryHindi,
    this.imageName,
    this.name,
    this.nameMeaning,
    this.nameTranslation,
    this.nameTransliterated,
    this.versesCount,
  });

  int? id;
  int? chapterNumber;
  String? chapterSummary;
  String? chapterSummaryHindi;
  String? imageName;
  String? name;
  String? nameMeaning;
  String? nameTranslation;
  String? nameTransliterated;
  int? versesCount;

  factory GitaChapterModel.fromJson(Map<String, dynamic> json) => GitaChapterModel(
    id: json["id"],
    chapterNumber: json["chapter_number"],
    chapterSummary: json["chapter_summary"],
    chapterSummaryHindi: json["chapter_summary_hindi"],
    imageName: json["image_name"],
    name: json["name"],
    nameMeaning: json["name_meaning"],
    nameTranslation: json["name_translation"],
    nameTransliterated: json["name_transliterated"],
    versesCount: json["verses_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chapter_number": chapterNumber,
    "chapter_summary": chapterSummary,
    "chapter_summary_hindi": chapterSummaryHindi,
    "image_name": imageName,
    "name": name,
    "name_meaning": nameMeaning,
    "name_translation": nameTranslation,
    "name_transliterated": nameTransliterated,
    "verses_count": versesCount,
  };
}
