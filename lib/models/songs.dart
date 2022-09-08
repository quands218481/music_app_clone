import 'dart:convert';

import 'package:http/http.dart' as http;
class Song {
  String name;
  int duration;
  String id;
  String artistName;
  String thumb;
  Song({required this.name, required this.duration, required this.id, required this.artistName, required this.thumb});
  factory Song.fromJson(Map<String, dynamic> json){
    return Song(
       name: json['data']['items'][0]['items'][0]['title'],
       id: json['data']['items'][0]['items'][0]['id'],
       duration: json['data']['items'][0]['items'][0]['duration'],
       artistName: json['data']['items'][0]['items'][0]['artists'][0]['name'],
       thumb: json['data']['items'][0]['items'][0]['thumb']
    );
  }
  factory Song.fromJson2(Map<String, dynamic> item) {
    return Song(
      name: item['title'],
      id: item['id'],
      duration: item['duration'],
      artistName: item['artists'][0]['name'],
      thumb: item['thumb'],
    );
  }
}