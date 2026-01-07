// lib/models/episode_model.dart

import 'dart:convert';

EpisodeModel episodeModelFromJson(String str) =>
    EpisodeModel.fromJson(json.decode(str));

String episodeModelToJson(EpisodeModel data) => json.encode(data);

class EpisodeModel {
  EpisodeModel({
    required this.id,
    required this.airdate,
    required this.episodeNumber,
    required this.imagePath,
    required this.name,
    required this.season,
    required this.synopsis,
  });

  final int id;
  final String airdate;
  final int episodeNumber;
  final String imagePath;
  final String name;
  final int season;
  final String synopsis;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        airdate: json["airdate"] ?? "",
        episodeNumber: json["episode_number"],
        imagePath: json["image_path"] ?? "",
        name: json["name"] ?? "",
        season: json["season"],
        synopsis: json["synopsis"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "airdate": airdate,
        "episode_number": episodeNumber,
        "image_path": imagePath,
        "name": name,
        "season": season,
        "synopsis": synopsis,
      };
}
