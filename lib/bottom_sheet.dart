import 'package:apple_music_clone/DetailPlaylistPage/detail_playlist_page.dart';
import 'package:apple_music_clone/models/song_api.dart';
import 'package:apple_music_clone/main.dart';
import 'package:apple_music_clone/models/play_list_provider.dart';
import 'package:apple_music_clone/models/player_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Main widget;

  @override
  Widget build(BuildContext context) {
    PlayerStateProvider playerStateInstance = Provider.of<PlayerStateProvider>(context);
    return StreamBuilder(
      stream: playerStateInstance.playingStateStream,
      builder: (context, snapshot) {
        return Consumer<PlayListProvider>(builder: (context, playListInstance, child){
          return InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            height: widget.screenSize.height / 16,
            width: widget.screenSize.width,
            // color: Colors.red,
            child: Row(children: [
              SizedBox(
                height: (widget.screenSize.height / 16) - 8,
                width: (widget.screenSize.height / 16) - 8,
                child: Image.network(
                  playListInstance.songInfo.thumb,
                ),
              ),
              Container(
                width: widget.screenSize.width/2,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // width: (widget.screenSize.width - 32) / 1.6,
                child: Text(playListInstance.songInfo.name),
                // color: Colors.red,
              ),
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                    InkWell(
                      onTap: () async{
                        if(playerStateInstance.processingState == ProcessingState.idle) {
                          String newUrl = await SongApi().loadSongUrl(baseUrl: playListInstance.playList[playListInstance.currentIndex]['baseUrl']);
                      playerStateInstance.setNewUrl(newUrl);
                      // playerStateInstance.advancedPlayer.play();
                    }
                    playerStateInstance.togglePlayer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          (playerStateInstance.playing && playerStateInstance.processingState != ProcessingState.completed)?Icons.pause:Icons.play_arrow,
                          size: 28,
                        ),
                      ),
                    ),
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.fast_forward,
                          size: 28,
                        ),
                      ), onTap: () { 
                        // playerStateInstance.setNewUrl(playListInstance.getNextSong()); 
                        },
                    )
                  ]))
            ]),
          ),
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder: (context, anim1, anim2) {
                return const DetailPlaylistPage();
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position:
                      Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                          .animate(anim1),
                  child: child,
                );
              },
            );
          },
        );
        });
      }
    );
  }
}
