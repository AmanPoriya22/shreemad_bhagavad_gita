// To parse this JSON data, do
//
//     final gita = gitaFromJson(jsonString);

import 'dart:convert';

List<Gita> gitaFromJson(String str) => List<Gita>.from(json.decode(str).map((x) => Gita.fromJson(x)));

String gitaToJson(List<Gita> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Gita {
  Gita({
    this.chapterNumber,
    this.versesCount,
    this.name,
    this.translation,
    this.transliteration,
    this.meaning,
    this.summary,
  });

  int? chapterNumber;
  int? versesCount;
  String? name;
  String? translation;
  String? transliteration;
  Meaning? meaning;
  Meaning? summary;

  factory Gita.fromJson(Map<String, dynamic> json) => Gita(
    chapterNumber: json["chapter_number"],
    versesCount: json["verses_count"],
    name: json["name"],
    translation: json["translation"],
    transliteration: json["transliteration"],
    meaning: Meaning.fromJson(json["meaning"]),
    summary: Meaning.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "chapter_number": chapterNumber,
    "verses_count": versesCount,
    "name": name,
    "translation": translation,
    "transliteration": transliteration,
    "meaning": meaning!.toJson(),
    "summary": summary!.toJson(),
  };
}

class Meaning {
  Meaning({
    this.en,
    this.gu,
    this.hi,
  });

  String? en;
  String? gu;
  String? hi;

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
    en: json["en"],
    gu: json["gu"],
    hi: json["hi"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "gu": gu,
    "hi": hi,
  };
}
