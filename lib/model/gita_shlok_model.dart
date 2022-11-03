// To parse this JSON data, do
//
//     final gitaShlokModel = gitaShlokModelFromJson(jsonString);

import 'dart:convert';

List<GitaShlokModel> gitaShlokModelFromJson(String str) => List<GitaShlokModel>.from(json.decode(str).map((x) => GitaShlokModel.fromJson(x)));

String gitaShlokModelToJson(List<GitaShlokModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GitaShlokModel {
  GitaShlokModel({
    this.id,
    this.chapterNumber,
    this.verseSanskrit,
    this.verseNumber,
    this.verseOrder,
    this.transliteration,
    this.wordMeanings,
  });

  int? id;
  int? chapterNumber;
  String? verseSanskrit;
  int? verseNumber;
  int? verseOrder;
  String? transliteration;
  String? wordMeanings;

  factory GitaShlokModel.fromJson(Map<String, dynamic> json) => GitaShlokModel(
    id: json["id"],
    chapterNumber: json["chapter_number"],
    verseSanskrit: json["verse_sanskrit"],
    verseNumber: json["verse_number"],
    verseOrder: json["verse_order"],
    transliteration: json["transliteration"],
    wordMeanings: json["word_meanings"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chapter_number": chapterNumber,
    "verse_sanskrit": verseSanskrit,
    "verse_number": verseNumber,
    "verse_order": verseOrder,
    "transliteration": transliteration,
    "word_meanings": wordMeanings,
  };
}
