
import 'dart:convert';

import 'package:apple_music_clone/models/songs.dart';
import 'package:http/http.dart' as http;

class SongApi {
  static final SongApi _singleton = SongApi._internal();
  factory SongApi() => _singleton;
  SongApi._internal();
  // static SongApi get shared => _singleton;
  Future<List> fetchSongsFromName(songName) async {
    // print(songName);
   final response = await http.get(Uri.parse('https://ac.zingmp3.vn/v1/web/featured?query=${songName}'));
   if (response.statusCode == 200) {  
    var decodeBody = json.decode(response.body);
    // print(decodeBody);
        if(decodeBody['data'] != null && decodeBody['data']['items'].length > 0) {
          var data= decodeBody['data']['items'][1]["items"] as List;
        data.removeAt(0);
      List<Song> songs = [];
        data.forEach((element) {
          if(element['type'] == 1 &&
        (element['duration'] != null) &&
        (element['title']!= null) &&
        (element['artists'] != null) &&
        (element['artists'][0] != null) &&
        (element['artists'][0]['name'] != null) &&
        element['thumb'] != null) {
            songs.add(Song.fromJson2(element));
          }
        });
        // print(songs);
        return songs;
        } else {
          return  [];
        }
   } else {  
      throw Exception('Failed to load post');  
   }  
   }
  Future<String> loadSongUrl({String baseUrl = ''}) async{
    http.Request req = http.Request("Get", Uri.parse(baseUrl))..followRedirects = false;
http.Client baseClient = http.Client();
http.StreamedResponse response = await baseClient.send(req);
var location = response.headers['location'] ?? '';
http.Request req2 = http.Request("Get", Uri.parse(location))..followRedirects = false;
http.StreamedResponse response2 = await baseClient.send(req2);
return response2.headers['location'] ?? '';
  }
 }