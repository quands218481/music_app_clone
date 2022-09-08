import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatefulWidget {
  SearchBar({
    required this.isPadding,
    this.callback,
    Key? key,
  }) : super(key: key);
  bool isPadding;
  Function()? callback;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: widget.isPadding
              ? const EdgeInsets.symmetric(horizontal: 12)
              : const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
              height: size.height / 49.5 * 2,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 227, 227, 227),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12, right: 10),
                    child: Icon(
                      size: 20,
                      Icons.search_rounded,
                      color: Color.fromARGB(255, 115, 115, 115),
                    ),
                  ),
                  LookingSongTextField(callback: widget.callback,),
                ],
              )),
        ),
        SizedBox(
          height: size.height / 49.5,
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}

class LookingSongTextField extends StatefulWidget {
  LookingSongTextField({
    this.callback,
    Key? key,
  }) : super(key: key);
  Function()? callback;
  @override
  State<LookingSongTextField> createState() => _LookingSongTextFieldState();
}

class _LookingSongTextFieldState extends State<LookingSongTextField> {
  @override
  Widget build(BuildContext context) {
    String songName ='';
  // var songNameController = TextEditingController();
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          SizedBox(
            width: 200,
            height: 50,
            child: InkWell(
              child: const TextField(
                enabled: false,
                // controller: songNameController,
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.symmetric(vertical: 14),
                hintText: 'Artists, Songs, Lyrics, and More',
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 115, 115, 115),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w300),
                border: InputBorder.none),
                      ),
                      onTap: (){
                          widget.callback!();
                        
                      },
            ),
          ),
        ],
      ),
    );
  }
}
