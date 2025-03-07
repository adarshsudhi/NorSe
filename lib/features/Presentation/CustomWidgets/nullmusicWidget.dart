import 'package:flutter/material.dart';

class NullMusicAlbumWidget extends StatelessWidget {
  const NullMusicAlbumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 54,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color: Colors.grey.withOpacity(0.5),
      )
    ,
    child: Image.asset('assets/music.png',fit: BoxFit.cover,),
    );
  }
}