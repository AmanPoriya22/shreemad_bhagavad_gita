// To parse this JSON data, do
//
//     final translationOfGitaAdyayModel = translationOfGitaAdyayModelFromJson(jsonString);

import 'dart:convert';

List<TranslationOfGitaAdyayModel> translationOfGitaAdyayModelFromJson(String str) => List<TranslationOfGitaAdyayModel>.from(json.decode(str).map((x) => TranslationOfGitaAdyayModel.fromJson(x)));

String translationOfGitaAdyayModelToJson(List<TranslationOfGitaAdyayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TranslationOfGitaAdyayModel {
  TranslationOfGitaAdyayModel({
    this.authorName,
    this.authorId,
    this.description,
    this.id,
    this.lang,
    this.languageId,
    this.verseNumber,
    this.verseId,
  });

  AuthorName? authorName;
  int? authorId;
  String? description;
  int? id;
  Lang? lang;
  int? languageId;
  int? verseNumber;
  int? verseId;

  factory TranslationOfGitaAdyayModel.fromJson(Map<String, dynamic> json) => TranslationOfGitaAdyayModel(
    authorName: authorNameValues.map![json["authorName"]],
    authorId: json["author_id"],
    description: json["description"],
    id: json["id"],
    lang: langValues.map![json["lang"]],
    languageId: json["language_id"],
    verseNumber: json["verseNumber"],
    verseId: json["verse_id"],
  );

  Map<String, dynamic> toJson() => {
    "authorName": authorNameValues.reverse![authorName],
    "author_id": authorId,
    "description": description,
    "id": id,
    "lang": langValues.reverse![lang],
    "language_id": languageId,
    "verseNumber": verseNumber,
    "verse_id": verseId,
  };
}

enum AuthorName { SWAMI_TEJOMAYANANDA, SWAMI_GAMBIRANANDA }

final authorNameValues = EnumValues({
  "Swami Gambirananda": AuthorName.SWAMI_GAMBIRANANDA,
  "Swami Tejomayananda": AuthorName.SWAMI_TEJOMAYANANDA
});

enum Lang { HINDI, ENGLISH }

final langValues = EnumValues({
  "english": Lang.ENGLISH,
  "hindi": Lang.HINDI
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
