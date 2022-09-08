import 'package:apple_music_clone/SearchPage/large_title.dart';
import 'package:apple_music_clone/SearchPage/list_artists.dart';
import 'package:apple_music_clone/SearchPage/search_bar.dart';
import 'package:apple_music_clone/SearchPage/search_result_page.dart';
import 'package:apple_music_clone/SearchPage/small_title.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.screenSize}) : super(key: key);

  final Size screenSize;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ScrollController controller;
  @override
  void initState() {
    _initial();
    super.initState();
  }

  _initial() {
    final largeTitleHeight = widget.screenSize.height / 16.5 * 2;
    controller = ScrollController();
    controller.addListener(() {
      if (controller.offset > largeTitleHeight / 8 * 7 - 10) {
        if (showTitle != true) {
          setState(() {
            showTitle = true;
          });
        }
        if (controller.offset > largeTitleHeight) {
          if (showSearchBar != true) {
            setState(() {
              showSearchBar = true;
            });
          }
        }
      } else {
        if (showTitle != false) {
          setState(() {
            showTitle = false;
          });
        }
        if (controller.offset < largeTitleHeight) {
          if (showSearchBar != false) {
            setState(() {
              showSearchBar = false;
            });
          }
        }
      }
    });
  }
  bool isSearchState = false;
  bool showTitle = false;
  bool showSearchBar = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final smallTitleHeight = size.height / 14;
    return Stack(
      children: [Column(
        children: [
          /// TABBAR (WHEN USER SCROLL TO TOP)
          Column(
            children: [
              SmallTitle(
                  smallTitleHeight: smallTitleHeight, showTitle: showTitle),
              if (showSearchBar)
                SearchBar(
                  isPadding: true,
                ),
            ],
          ),
          Expanded(
            child: SingleScrollViewBuildWidget(
              callback: (() {
                setState(() {
                  isSearchState = true;
                });
              }) ,
              controller: controller,
              // size: size.height,
              showSearchBar: showSearchBar,
            ),
          ),
        ],
      ),
      //man hinh 1
    if (isSearchState) SearchResultPage(callback: (() {
                setState(() {
                  isSearchState = false;
                });
              }))
    ],
    
    );
  }
}

class SingleScrollViewBuildWidget extends StatefulWidget {
  SingleScrollViewBuildWidget({
    this.callback,
    Key? key,
    required this.controller,
    // required this.size,
    required this.showSearchBar,
  }) : super(key: key);

  final ScrollController controller;
  // final Size size;
  final bool showSearchBar;
  Function()? callback;

  @override
  State<SingleScrollViewBuildWidget> createState() => _SingleScrollViewBuildWidgetState();
}

class _SingleScrollViewBuildWidgetState extends State<SingleScrollViewBuildWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final largeTitleHeight = size.height / 16.5 * 2;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      controller: widget.controller,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LargeTitle(largeTitleHeight: largeTitleHeight, size: size),
          if (!widget.showSearchBar)
            SearchBar(callback: widget.callback,
              isPadding: false,
            ),
          const ListArtist(),
        ],
      ),
    );
  }
}
