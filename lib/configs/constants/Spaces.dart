import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:norse/features/Presentation/Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import 'package:norse/features/Presentation/pages/Youtube/youtubeplayer/testytplayerscreen.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Spaces {
  List<Widget> getList(int length, Widget Function(int) generator) {
    return List.generate(length, generator);
  }

  static const String version = '3.2.2';

  static const kheigth5 = SizedBox(
    height: 5,
  );
  static const kheight10 = SizedBox(
    height: 10,
  );
  static const kheight20 = SizedBox(
    height: 20,
  );

  static const baseColor = Color.fromARGB(255, 133, 133, 133);
  static Color highlightColor = Colors.grey;
  static const textColor = Color.fromARGB(255, 221, 221, 221);
  static const backgroundColor = Colors.black;
  static const iconColor = Color.fromARGB(255, 58, 58, 58);

  static showtoast(String content) {
    return Fluttertoast.showToast(
        timeInSecForIosWeb: 03,
        msg: content,
        textColor: Colors.black,
        backgroundColor: Colors.white,
        gravity: ToastGravity.SNACKBAR);
  }

  /* static songtitle(String title, double size, Color color, FontWeight weight,
      BuildContext context) {
    return Marquee(
      startAfter: const Duration(seconds: 3),
      text: title,
      style: Getstyle(size, color, weight),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: MediaQuery.sizeOf(context).width / 2,
      velocity: 30.0,
      pauseAfterRound: const Duration(seconds: 3),
      startPadding: 10.0,
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  } */

  static LinearGradient musicgradient() {
    return const LinearGradient(colors: [
      Color.fromARGB(255, 27, 27, 27),
      Color.fromARGB(255, 0, 0, 0)
    ]);
  }

  static bool isLateVarInitialized() {
    try {
      controller;
      return true;
    } catch (e) {
      return false;
    }
  }

  static TextStyle Getstyle(
      double fontSize, Color color, FontWeight fontWeight) {
    return GoogleFonts.openSans(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: TextDecoration.none,
    );
  }

  Future<String> Gethumbnail(ThumbnailSet thumbnailSet) async {
    Response response = await http.get(Uri.parse(thumbnailSet.maxResUrl));
    if (response.statusCode == 200) {
      return thumbnailSet.maxResUrl;
    } else {
      Response response = await http.get(Uri.parse(thumbnailSet.highResUrl));
      if (response.statusCode == 200) {
        return thumbnailSet.highResUrl;
      } else {
        return 'https://cdn.pixabay.com/photo/2016/11/19/03/08/youtube-1837872_1280.png';
      }
    }
  }
}

class Textutil extends StatelessWidget {
  const Textutil({
    super.key,
    required this.text,
    required this.fontsize,
    required this.color,
    required this.fontWeight,
  });
  final String text;
  final double fontsize;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Spaces.Getstyle(fontsize, color, fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}
