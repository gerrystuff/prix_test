// To parse this JSON data, do
//
//     final fullBook = fullBookFromJson(jsonString);

import 'dart:convert';

FullBook fullBookFromJson(String str) => FullBook.fromJson(json.decode(str));

String fullBookToJson(FullBook data) => json.encode(data.toJson());

class FullBook {
    FullBook({
        required this.title,
        required this.covers,
        required this.firstPublishDate,
        required this.key,
        required this.subjects,
        required this.description
    });

    dynamic description;
    String title;
    List<int> covers;
    String? firstPublishDate;
    String key;
    List<String> subjects;

//Lord of the flies book


    factory FullBook.fromJson(Map<String, dynamic> json) => FullBook(
        description:json["description"],
        title: json["title"],
        covers: List<int>.from( json["covers"] == null ? [] : json["covers"].map((x) => x)),
        firstPublishDate: json["first_publish_date"],
        key: json["key"],
        subjects: List<String>.from(  json["subjects"] == null ? [] : json["subjects"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "title": title,
        "covers": List<dynamic>.from(covers.map((x) => x)),
        "first_publish_date": firstPublishDate,
        "key": key,
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
    };


    

}


