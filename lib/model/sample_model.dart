// To parse this JSON data, do
//
//     final gitaAllAdyayHindiModel = gitaAllAdyayHindiModelFromJson(jsonString);

import 'dart:convert';

GitaAllAdyayHindiModel gitaAllAdyayHindiModelFromJson(String str) =>
    GitaAllAdyayHindiModel.fromJson(json.decode(str));

String gitaAllAdyayHindiModelToJson(GitaAllAdyayHindiModel data) =>
    json.encode(data.toJson());

class GitaAllAdyayHindiModel {
  GitaAllAdyayHindiModel({
    this.chapterHindi,
    this.verseHindi,
    this.verseMeaningHindi,
    this.wordMeaningHindi,
    this.chapters,
  });

  String? chapterHindi;
  String? verseHindi;
  String? verseMeaningHindi;
  String? wordMeaningHindi;
  List<Chapter>? chapters;

  factory GitaAllAdyayHindiModel.fromJson(Map<String, dynamic> json) =>
      GitaAllAdyayHindiModel(
        chapterHindi: json["chapter_hindi"],
        verseHindi: json["verse_hindi"],
        verseMeaningHindi: json["verse_meaning_hindi"],
        wordMeaningHindi: json["word_meaning_hindi"],
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapter_hindi": chapterHindi,
        "verse_hindi": verseHindi,
        "verse_meaning_hindi": verseMeaningHindi,
        "word_meaning_hindi": wordMeaningHindi,
        "chapters": List<dynamic>.from(chapters!.map((x) => x.toJson())),
      };
}

class Chapter {
  Chapter({
    this.chapterId,
    this.chapterNumber,
    this.chapterSummary,
    this.name,
    this.nameMeaning,
    this.versesCount,
    this.verse,
  });

  int? chapterId;
  String? chapterNumber;
  String? chapterSummary;
  String? name;
  String? nameMeaning;
  String? versesCount;
  List<Verse>? verse;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterId: json["chapter_id"],
        chapterNumber: json["chapter_number"],
        chapterSummary: json["chapter_summary"],
        name: json["name"],
        nameMeaning: json["name_meaning"],
        versesCount: json["verses_count"],
        verse: List<Verse>.from(json["verse"].map((x) => Verse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapter_id": chapterId,
        "chapter_number": chapterNumber,
        "chapter_summary": chapterSummary,
        "name": name,
        "name_meaning": nameMeaning,
        "verses_count": versesCount,
        "verse": List<dynamic>.from(verse!.map((x) => x.toJson())),
      };
}

class Verse {
  Verse({
    this.verseId,
    this.verseNumber,
    this.meaning,
    this.text,
    this.wordMeanings,
  });

  int? verseId;
  String? verseNumber;
  String? meaning;
  String? text;
  String? wordMeanings;

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        verseId: json["verse_id"],
        verseNumber: json["verse_number"],
        meaning: json["meaning"],
        text: json["text"],
        wordMeanings: json["word_meanings"],
      );

  Map<String, dynamic> toJson() => {
        "verse_id": verseId,
        "verse_number": verseNumber,
        "meaning": meaning,
        "text": text,
        "word_meanings": wordMeanings,
      };
}
