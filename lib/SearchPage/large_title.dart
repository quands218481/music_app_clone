import 'package:flutter/material.dart';

class LargeTitle extends StatelessWidget {
  const LargeTitle({
    Key? key,
    required this.largeTitleHeight,
    required this.size,
  }) : super(key: key);

  final double largeTitleHeight;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: largeTitleHeight,
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Search',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SizedBox(
            height: size.height / 66,
          )
        ],
      ),
    );
  }
}
