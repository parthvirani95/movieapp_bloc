// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

import 'package:movieapp_bloc/data/models/video_result_model.dart';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  VideoModel({
    required this.id,
    required this.videos,
  });

  final int id;
  final List<VideoResultModel> videos;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        videos: List<VideoResultModel>.from(json["results"].map((x) => VideoResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}
