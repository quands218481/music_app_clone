import 'package:apple_music_clone/builders/functions/format_time.dart';
import 'package:apple_music_clone/models/song_api.dart';
import 'package:apple_music_clone/models/play_list_provider.dart';
import 'package:apple_music_clone/models/player_state_provider.dart';
import 'package:apple_music_clone/models/songs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key? key, required this.callback}) : super(key: key);
  Function callback;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late TextEditingController _songNameController;
   late Future<List> _songApi;
  @override  
void initState(){ 
  _songNameController = TextEditingController();
_songApi = SongApi().fetchSongsFromName('');
super.initState();
} 
  @override
  Widget build(BuildContext context) {
    PlayerStateProvider playerStateInstance = Provider.of<PlayerStateProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 49.5,
            ),
            Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: size.height / 49.5 * 2,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 227, 227),
          borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, right: 10),
                  child: Icon(
                    size: 20,
                    Icons.search_rounded,
                    color: Color.fromARGB(255, 115, 115, 115),
                  ),
                ),
                SizedBox(
                  width: size.width / 1.6,
                  child: TextField(
                    autofocus: true,
                    onSubmitted: (_) {
                      setState(() {
                        _songApi = SongApi().fetchSongsFromName(_songNameController.text);
                      });
                    },
                    controller: _songNameController,
                    decoration: const InputDecoration(
          hintText: 'Artists, Songs, Lyrics, and More',
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 115, 115, 115),
              fontSize: 16,
              fontWeight: FontWeight.w300),
          border: InputBorder.none)
                  ),
                )
              ]),
            ),
            TextButton(onPressed: () {widget.callback();}, child: const Text('Cancel', style: TextStyle(color:Colors.red, fontWeight: FontWeight.w400)))
          ],
        )),
            Container(height: size.height,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StreamBuilder(
              stream: playerStateInstance.playingStateStream,
              builder: (context, snapshot) {
                return Consumer<PlayListProvider>(builder: (context, playListInstance, child ){
                  return FutureBuilder(  
                      future: _songApi,  
                      builder: (context, response) {  
                      if (response.hasData) {
                        // print(data[3].thumb);
                        // if (response.data != null && response.data.length > 0) {
                          var data = response.data as List;
                          if (data.isEmpty) {
                            return Container(
                              width: size.width,
                              height: size.height, color: Colors.white,
                              alignment: Alignment.center, child: const Text('Mời bạn tìm bài hát!!'),);
                          }
                          return ListView.builder(itemBuilder: ((context, index) {
                          return SizedBox(
                            height: size.height/10,
                            child: Card(
                              child: InkWell(
                                onTap: (() async{
                                String baseUrl = 'http://api.mp3.zing.vn/api/streaming/audio/${data[index].id}/320';
                                if(playListInstance.playList.isEmpty || 
                                (playListInstance.playList.isNotEmpty &&
                                playListInstance.playList[playListInstance.currentIndex]['baseUrl'] != baseUrl))
                                {
                                  String httpUrl = await SongApi().loadSongUrl(baseUrl: baseUrl);
                                 String httpsUrl = httpUrl.replaceFirst('http', 'https');
                                 playListInstance.addSong(baseUrl,data[index]);
                                 playerStateInstance.setNewUrl(httpsUrl);   
                                }
                                }),
                                child: Row(children: [
                                  Container(width: size.width/6,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Image.network(data[index].thumb),
                                  ),
                                  Expanded(
                                    child: Container(padding: const EdgeInsets.only(top:10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text(data[index].name, style: const TextStyle(fontSize: 15),),
                                        Text(data[index].artistName, style: const TextStyle(fontSize: 12))
                                      ],),
                                    ),
                                  ),
                                  SizedBox(width: size.width/6,child: Center(child: Text(formatedTime(timeInSecond: data[index].duration.toInt() ))),)
                                ],),
                              ),
                            ),
                          );
                        }),itemCount: data.length,);
                      } else if (response.hasError) { 
                        print(response.error); 
                        return Text("${response.error}");  
                      }  
                        return Container();  
                    },  
                  );}
                );
              }
            )),
            Container(height: size.height, color: Colors.red,)     
        ]))
    );
  }
}
// class LoadSongUrlFuture extends StatefulWidget {
//   LoadSongUrlFuture({
//     Key? key,
//     required this.id,
//   }) : super(key: key);
//   String? id;

//   @override
//   State<LoadSongUrlFuture> createState() => _LoadSongUrlFutureState();
// }

// class _LoadSongUrlFutureState extends State<LoadSongUrlFuture> {
//   initSong() async{
//     String songUrl = await SongApi().loadSongUrl(baseUrl: 'https://api.mp3.zing.vn/api/streaming/audio/${widget.id}/128');
//     httpsUrl = songUrl.replaceAll("http", "https");
//   }
//   late String httpsUrl;
//   @override
//   void initState() {
//     super.initState();
//     initSong();
//   }
//   @override
//   Widget build(BuildContext context) {
//     print('build context');
//     PlayerStateProvider playerStateInstance = Provider.of<PlayerStateProvider>(context);
//     return StreamBuilder(
//       stream: playerStateInstance.playingStateStream,
//       builder: (context, snapshot) {
//         return InkWell(onTap: (() {
//           playerStateInstance.setNewUrl(httpsUrl);
//         }),child: Text('${widget.id}'),);
//       }
//     );
//   }
// }