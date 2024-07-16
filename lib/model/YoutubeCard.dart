import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class YouTubeCard {
  final String title;
  final String subTitle;
  final String videoId;
  final String imagePath;

  YouTubeCard({
    required this.title,
    required this.subTitle,
    required this.videoId,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subTitle': subTitle,
      'videoId': videoId,
      'imagePath': imagePath,
    };
  }

  factory YouTubeCard.fromJson(Map<String, dynamic> json) {
    return YouTubeCard(
      title: json['title'],
      subTitle: json['subTitle'],
      videoId: json['videoId'],
      imagePath: json['imagePath'],
    );
  }
   
}