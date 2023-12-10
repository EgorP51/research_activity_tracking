import 'dart:convert';

import 'package:flutter/cupertino.dart';

ScientificPublication scientificPublicationFromJson(String str) =>
    ScientificPublication.fromJson(json.decode(str));

String scientificPublicationToJson(ScientificPublication data) =>
    json.encode(data.toJson());

class ScientificPublication {
  String? id;
  String? publicationTitle;
  String? publicationYear;
  String? authorId;
  String? filePath;

  ScientificPublication({
    this.id,
    this.publicationTitle,
    this.publicationYear,
    this.authorId,
    this.filePath,
  });

  factory ScientificPublication.fromJson(Map<String, dynamic> json) =>
      ScientificPublication(
        id: json["id"],
        publicationTitle: json["publicationTitle"],
        publicationYear: json["publicationYear"],
        authorId: json["authorId"],
        filePath: json["filePath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "publicationTitle": publicationTitle,
        "publicationYear": publicationYear,
        "authorId": authorId,
        "filePath": filePath,
      };

  static List<ScientificPublication> parseFromSnapshot(collection) {
    return List.generate(collection.length, (index) {
      return ScientificPublication(
        id: collection[index]['publicationTitle'],
        authorId: collection[index]['authorId'],
        filePath: collection[index]['filePath'],
        publicationTitle: collection[index]['publicationTitle'],
        publicationYear: collection[index]['publicationYear'],
      );
    });
  }
}
