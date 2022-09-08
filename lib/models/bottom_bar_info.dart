import 'package:flutter/material.dart';

class BottomBarInfo {
  BottomBarInfo({required this.icon, required this.label});
  Icon icon;
  String label;
}

List<BottomBarInfo> bottomBarInfo = [
  BottomBarInfo(
      icon: const Icon(Icons.play_circle_filled), label: 'Listen Now'),
  BottomBarInfo(icon: const Icon(Icons.sensors_outlined), label: 'Radio'),
  BottomBarInfo(icon: const Icon(Icons.library_music_sharp), label: 'Library'),
  BottomBarInfo(icon: const Icon(Icons.search), label: 'Search'),
];
