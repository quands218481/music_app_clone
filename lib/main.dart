import 'package:apple_music_clone/Library/library.dart';
import 'package:apple_music_clone/Listen_now/listen_now.dart';
import 'package:apple_music_clone/Radio/radio.dart';
import 'package:apple_music_clone/SearchPage/search_page.dart';
import 'package:apple_music_clone/bottom_sheet.dart';
import 'package:apple_music_clone/builders/functions/bottom_navigation_bar_items.dart';
import 'package:apple_music_clone/config/themes/text_config.dart';
import 'package:apple_music_clone/DetailPlaylistPage/detail_playlist_page.dart';
import 'package:apple_music_clone/models/bottom_bar_info.dart';
import 'package:apple_music_clone/models/play_list_provider.dart';
import 'package:apple_music_clone/models/player_state_provider.dart';
import 'package:apple_music_clone/models/theme_app_provider.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeAppProvider()),
      ChangeNotifierProvider(create: (_) => PlayListProvider()),
      Provider(create: (_) => PlayerStateProvider()),
    ],
    child: AppleMusic(),
  ));
}

class AppleMusic extends StatelessWidget {
  AppleMusic({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeAppProvider >(
      builder: (context, themeAppInstance,child) {
        return MaterialApp(
                themeMode: themeAppInstance.themeMode,
                theme: themeAppInstance.themeMode == ThemeMode.light
                    ? ThemeAppConfig.lightTheme
                    : ThemeAppConfig.darkTheme,
                home: const GroundMain(),
              );
      });
  }
}

class GroundMain extends StatelessWidget {
  const GroundMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Main(screenSize: MediaQuery.of(context).size);
  }
}

class Main extends StatefulWidget {
  const Main({
    Key? key,
    required this.screenSize,
  }) : super(key: key);
  final Size screenSize;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const ListenNowPage(),
      const RadioPage(),
      const LibraryPage(),
      SearchPage(screenSize: widget.screenSize),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: MyBottomSheet(widget: widget),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        showUnselectedLabels: true,
        iconSize: 26,
        selectedItemColor: Colors.red,
        unselectedItemColor: const Color.fromARGB(255, 130, 130, 130),
        items: bottomBarInfo.map((e) {
          return buildNavigationBarItem(e.icon, e.label);
        }).toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}



