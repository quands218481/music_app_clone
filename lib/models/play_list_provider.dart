import 'package:apple_music_clone/models/songs.dart';
import 'package:flutter/material.dart';

class PlayListProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  final List<Map> _playList  = <Map>[
  ];
  Song _songInfo = Song(name: 'Tình yêu hoa gió', duration: 241, id: 'sdsasd', artistName: 'Trương Thế Vinh', thumb: 'https://photo-resize-zmp3.zmdcdn.me/w165_r1x1_jpeg/avatars/3/3/33e23a4ab94e902d9850109f4fba0e24_1410142045.jpg');
  Song get songInfo => _songInfo;
  setSongInfo(Song sI) {
    _songInfo = sI;
  }
  List<Map> get playList => _playList; 
  void addSong(String baseUrl, Song data) async{
    int index = _playList.indexWhere((element) => element['baseUrl'] == baseUrl);
    if(index <0) {
      if(_playList.isNotEmpty) {
        _currentIndex++;
      }
      _playList.add({'baseUrl':baseUrl, 'data': data});
    setSongInfo(_playList[_currentIndex]['data']);
    notifyListeners();
    } else {
      _currentIndex = index;
      setSongInfo(_playList[index]['data']);
      notifyListeners();
    }
  }
  getNextSong() {
    if(_currentIndex < _playList.length -1) {
      _currentIndex++;
      setSongInfo(_playList[_currentIndex]['data']);
      notifyListeners();
      return _playList[_currentIndex];
    } else  {
      return _playList[_currentIndex];
    }
  }
  getPreviousSong() {
    if(_currentIndex>0) {
    _currentIndex--;
    setSongInfo(_playList[_currentIndex]['data']);
    notifyListeners();
      return _playList[_currentIndex];
    } else {
      return _playList[_currentIndex];   
       }
  }
} 