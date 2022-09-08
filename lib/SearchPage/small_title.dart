import 'package:flutter/material.dart';

class SmallTitle extends StatelessWidget {
  const SmallTitle({
    Key? key,
    required this.smallTitleHeight,
    required this.showTitle,
  }) : super(key: key);

  final double smallTitleHeight;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: smallTitleHeight,
      alignment: Alignment.center,
      child: showTitle
          ? Column(
              children: [
                SizedBox(
                  height: smallTitleHeight / 2.3,
                ),
                Text(
                  'Search',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
