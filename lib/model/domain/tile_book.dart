// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

TileBook bookFromJson(String str) => TileBook.fromJson(json.decode(str));

String bookToJson(TileBook data) => json.encode(data.toJson());

class TileBook {
    TileBook({
        required this.title,
        required this.authorName,
        required this.key,
        required this.firstPublishYear,
        required this.coverI
    });

    String title;
    String key;
    int firstPublishYear;
    int coverI;
    List<String> authorName;

    factory TileBook.fromJson(Map<String, dynamic> json) => TileBook(
        key: json["key"],
        coverI: json["cover_i"] ?? 0,
        title: json["title"],
        firstPublishYear: json['first_publish_year'] ?? 0,
        authorName: json["author_name"] == null ? [] : List<String>.from(json["author_name"]),
    );

    Map<String, dynamic> toJson() => {
        "first_publish_year": firstPublishYear,
        "cover_i":coverI,
        "key":key,
        "title": title,
        "author_name": List<dynamic>.from(authorName.map((x) => x)),
    };

}
