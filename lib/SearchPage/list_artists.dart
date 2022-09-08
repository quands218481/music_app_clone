import 'package:apple_music_clone/models/artists.dart';
import 'package:flutter/material.dart';

class ListArtist extends StatelessWidget {
  const ListArtist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: size.height / 49.5 * 2,
          child: Text(
            'Khám Phá Danh Mục',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: artists.map((artist) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                  height: size.height / 7,
                  width: (size.width - 42) / 2,
                  child: Stack(
                    children: [
                      Image.asset(
                        artist.imgUri,
                        fit: BoxFit.cover,
                        height: size.height / 7,
                        width: (size.width - 34) / 2,
                      ),
                      Container(
                          padding: const EdgeInsets.only(
                              left: 8, bottom: 5, right: 8, top: 8),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            artist.name,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                          ))
                    ],
                  )),
            );
          }).toList(),
        ),
      ],
    );
  }
}
