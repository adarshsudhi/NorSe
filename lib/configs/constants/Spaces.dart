import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:marquee/marquee.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Spaces {
  static const kheigth5 = SizedBox(
    height: 5,
  );
  static const kheight10 = SizedBox(
    height: 10,
  );
  static const kheight20 = SizedBox(
    height: 20,
  );

  static showtoast(String Content) {
    return Fluttertoast.showToast(
        timeInSecForIosWeb: 03,
        msg: Content,
        textColor: Colors.black,
        backgroundColor: Colors.white,
        gravity: ToastGravity.SNACKBAR);
  }

  static songtitle(String title, double size, Color color, FontWeight weight,
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
  }

  static LinearGradient musicgradient() {
    return const LinearGradient(colors: [
      Color.fromARGB(255, 27, 27, 27),
      Color.fromARGB(255, 0, 0, 0)
    ]);
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
        Response response =
            await http.get(Uri.parse(thumbnailSet.mediumResUrl));
        if (response.statusCode == 200) {
          return thumbnailSet.mediumResUrl;
        } else {
          return 'https://cdn.pixabay.com/photo/2016/11/19/03/08/youtube-1837872_1280.png';
        }
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
