// ignore_for_file: non_constant_identifier_names

import 'dart:core';

import 'package:apple_music_clone/builders/functions/format_time.dart';
import 'package:apple_music_clone/models/song_api.dart';
import 'package:apple_music_clone/builders/widgets/custom_slider.dart';
import 'package:apple_music_clone/config/themes/color_style.dart';
import 'package:apple_music_clone/main.dart';
import 'package:apple_music_clone/models/play_list_provider.dart';
import 'package:apple_music_clone/models/player_state_provider.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PlayAudioBar extends StatelessWidget {
  final double padding;
  PlayAudioBar({Key? key, required this.padding}) : super(key: key);
  // late IconData btnPlay;
  @override
  Widget build(BuildContext context) {
    PlayerStateProvider playerStateInstance = Provider.of<PlayerStateProvider>(context, listen: false);
    final Size screenSize = MediaQuery.of(context).size;
    
        return
      Expanded(
        child: Column(
          children: [
            ArstistInfo(screenSize: screenSize, playerStateInstance: playerStateInstance,),
            SliderBar(screenSize:screenSize, playerStateInstance:playerStateInstance),
            ButtonBar(screenSize:screenSize, playerStateInstance:playerStateInstance),
            VolumeBar(screenSize: screenSize, playerStateInstance: playerStateInstance,),
          ],
        ),
      );
  }
}
class ButtonBar extends StatelessWidget {
  Size screenSize;
  PlayerStateProvider playerStateInstance;
  ButtonBar({required this.screenSize, required this.playerStateInstance, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     final List<IconData> _icons = [Icons.play_arrow, Icons.pause];
    return StreamBuilder(
      stream: playerStateInstance.playingStateStream,
      builder: (context, snapshot) {
        // print('-------${playerStateInstance.processingState}');
        return Consumer<PlayListProvider>(builder: (context, playListInstance, child ){
          return Container(
            padding: EdgeInsets.only(top:  screenSize.height*0.02),
          // height: screenSize.height * 0.12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () async{
                    String httpUrl = await SongApi().loadSongUrl(baseUrl: playListInstance.getPreviousSong()['baseUrl']);
                    String httpsUrl = httpUrl.replaceFirst('http', 'https');
                    playerStateInstance.setNewUrl(httpsUrl);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(
                      Icons.fast_rewind,
                      size: 50,
                      color: ColorConfig.activePlayBarColor,
                    ),
                  )),
              InkWell(
                  onTap: () async{
                    if(playerStateInstance.processingState == ProcessingState.completed){
                      playerStateInstance.advancedPlayer.play();
                    }
                    if(playerStateInstance.processingState == ProcessingState.idle) {
                      String httpUrl = await SongApi().loadSongUrl(baseUrl: playListInstance.playList[playListInstance.currentIndex]['baseUrl']);
                      String httpsUrl = httpUrl.replaceFirst('http', 'https');
                      playerStateInstance.setNewUrl(httpsUrl);
                    }
                    playerStateInstance.togglePlayer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(
                      (playerStateInstance.playing && playerStateInstance.processingState != ProcessingState.completed)? _icons[1]: _icons[0],
                      size: 70,
                      color: ColorConfig.activePlayBarColor,
                    ),
                  )),
              InkWell(
                  onTap: () async{
                    String httpUrl = await SongApi().loadSongUrl(baseUrl: playListInstance.getNextSong()['baseUrl']);
                    String httpsUrl = httpUrl.replaceFirst('http', 'https');
                    playerStateInstance.setNewUrl(httpsUrl);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(
                      Icons.fast_forward,
                      size: 50,
                      color: ColorConfig.activePlayBarColor,
                    ),
                  )),
            ],
          ),
        );
        });
      }
    );
  }
}
class ArstistInfo extends StatelessWidget {
  Size screenSize;
  PlayerStateProvider playerStateInstance;
  ArstistInfo({required this.screenSize, required this.playerStateInstance, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.005),
      height: screenSize.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<PlayListProvider>(builder: (context, playListInstance, child ){
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.width/1.5,
                  child: Text(
                    playListInstance.songInfo.name,
                    maxLines: 2,
                    style: TextStyle(
                        color: ColorConfig.activePlayBarColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: screenSize.width/1.5,
                  child: Text(
                    playListInstance.songInfo.artistName,
                    maxLines: 1,
                    style: TextStyle(
                        color: ColorConfig.activePlayBarColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w200),
                  ),
                )
              ],
            );},
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Icon(Icons.more_horiz_rounded,
                color: ColorConfig.activePlayBarColor),
          ),
        ],
      ),
    );
  }
}
class SliderBar extends StatelessWidget {
  Size screenSize;
  PlayerStateProvider playerStateInstance;
  SliderBar({required this.screenSize, required this.playerStateInstance, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:playerStateInstance.positionStream,
      builder: (_, __) {
        return StreamBuilder(
          stream: playerStateInstance.durationStream,
          builder:   (_, __) {
            return Consumer<PlayListProvider>(builder: (context, playListInstance, child){
              return SizedBox(
                  height: screenSize.height * 0.07,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                              trackShape: CustomTrackShape(),
                              trackHeight: 2,
                              thumbShape:
                                  const RoundSliderThumbShape(enabledThumbRadius: 3)),
                          child: Slider(
                              inactiveColor: ColorConfig.inactivePlayBarColor,
                              activeColor: ColorConfig.activePlayBarColor,
                              min: 0,
                              max: 1,
                              value: playerStateInstance.position.inMilliseconds/playerStateInstance.duration.inMilliseconds,
                              onChanged: (double value) {
                                  playerStateInstance.setPosition(value * (playerStateInstance.duration.inSeconds.toDouble()));
                              }),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatedTime(timeInSecond: playerStateInstance.position.inSeconds.toInt()),
                            style: const TextStyle(
                                color: ColorConfig.inactivePlayBarColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w200),
                          ),
                          Text(
                              formatedTime(
                                  timeInSecond:
                                      (playerStateInstance.duration.inSeconds - playerStateInstance.position.inSeconds)
                                          .toInt()),
                              style: const TextStyle(
                                  color: ColorConfig.inactivePlayBarColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200))
                        ],
                      )
                    ],
                  ));
            });
            
          }
        );
      }
    );
  }
}
class VolumeBar extends StatelessWidget {
  Size screenSize;
  PlayerStateProvider playerStateInstance;
  VolumeBar({required this.screenSize, required this.playerStateInstance, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: playerStateInstance.volumeStream,
      builder: (context, snapshot) {
        return SizedBox(
            height: screenSize.height * 0.12,
            // color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.volume_mute,
                    size: 14, color: ColorConfig.activePlayBarColor),
                Expanded(
                  child: SliderTheme(
                    data: const SliderThemeData(
                        trackHeight: 1.5,
                        // thumbColor: Colors.green,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius:10 )),
                    child: Slider(
                      min: 0,
                      max: 1,
                      value: playerStateInstance.volume,
                      inactiveColor: ColorConfig.inactivePlayBarColor,
                      activeColor: ColorConfig.activePlayBarColor,
                      onChanged: (double value) {
                        playerStateInstance.setVolumeApp(value);
                      },
                    ),
                  ),
                ),
                Icon(Icons.volume_up,
                    size: 14, color: ColorConfig.activePlayBarColor),
              ],
            ));
      }
    );
  }
}