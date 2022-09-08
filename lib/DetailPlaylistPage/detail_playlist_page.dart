import 'package:apple_music_clone/DetailPlaylistPage/components/play_audio_bar.dart';
import 'package:apple_music_clone/models/play_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPlaylistPage extends StatelessWidget {
  const DetailPlaylistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double _paddingPage = 34;
    return Dismissible(
      direction: DismissDirection.down,
      dismissThresholds: const {DismissDirection.down: 0.45},
      key: const Key('key'),
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
          body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 112, 106, 102),
            Color.fromARGB(255, 40, 42, 30)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          padding: EdgeInsets.symmetric(horizontal: _paddingPage),
          child: Column(children: [
            Container(
              height: screenSize.height * 0.09,
              alignment: Alignment.bottomCenter,
              child: const Icon(
                Icons.maximize_rounded,
                size: 40,
                color: Color.fromARGB(255, 165, 165, 165),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.14,
                  vertical: screenSize.height * 0.06),
              height: screenSize.height * 0.4,
              child: Consumer<PlayListProvider>(builder: ((context, playListInstance, child) {
                return Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Image.network(playListInstance.songInfo.thumb, fit: BoxFit.fitHeight),);
              }),
              ),
            ),
            PlayAudioBar(
              padding: _paddingPage,
            ),
          ]),
        ),
      )),
    );
  }
}
