// To parse this JSON data, do
//
//     final gitaAllAdyayEnglishModel = gitaAllAdyayEnglishModelFromJson(jsonString);

import 'dart:convert';

GitaAllAdyayEnglishModel gitaAllAdyayEnglishModelFromJson(String str) => GitaAllAdyayEnglishModel.fromJson(json.decode(str));

String gitaAllAdyayEnglishModelToJson(GitaAllAdyayEnglishModel data) => json.encode(data.toJson());

class GitaAllAdyayEnglishModel {
  GitaAllAdyayEnglishModel({
    this.chapterEnglish,
    this.verseEnglish,
    this.verseMeaningEnglish,
    this.wordMeaningEnglish,
    this.chapters,
  });

  String? chapterEnglish;
  String? verseEnglish;
  String? verseMeaningEnglish;
  String? wordMeaningEnglish;
  List<Chapter>? chapters;

  factory GitaAllAdyayEnglishModel.fromJson(Map<String, dynamic> json) => GitaAllAdyayEnglishModel(
    chapterEnglish: json["chapter_english"],
    verseEnglish: json["verse_english"],
    verseMeaningEnglish: json["verse_meaning_english"],
    wordMeaningEnglish: json["word_meaning_english"],
    chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chapter_english": chapterEnglish,
    "verse_english": verseEnglish,
    "verse_meaning_english": verseMeaningEnglish,
    "word_meaning_english": wordMeaningEnglish,
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
  int? versesCount;
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
