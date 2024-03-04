import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marquee/marquee.dart';

class Spaces {
  static const kheigth5 = SizedBox(height: 5,);
  static const Kheight10 = SizedBox(height: 10,); 
  static const Kheight20 = SizedBox(height: 20,);

  static showtoast(String Content){
    return Fluttertoast.showToast(msg: Content,textColor: Colors.black,backgroundColor: Colors.white,gravity: ToastGravity.SNACKBAR);
  }

  static songtitle(String title,double size,Color color,FontWeight weight,BuildContext context) {
  return Marquee(
  text: title,
  style: Getstyle(size, color, weight),
  scrollAxis: Axis.horizontal,
  crossAxisAlignment: CrossAxisAlignment.start,
  blankSpace: MediaQuery.sizeOf(context).width/2,
  velocity: 30.0,
  pauseAfterRound: const Duration(seconds: 3),
  startPadding: 10.0,
  accelerationDuration: const Duration(seconds: 1),
  accelerationCurve: Curves.linear,
  decelerationDuration: const Duration(milliseconds: 500),
  decelerationCurve: Curves.easeOut,
);
  }

static  LinearGradient musicgradient() {
    return const LinearGradient(
                      colors: [
                               Color.fromARGB(255, 48, 48, 48),
                               Color.fromARGB(255, 33, 33, 33),
                               Color.fromARGB(255, 25, 25, 25),
                               Color.fromARGB(255, 0, 0, 0)
                    ]);
  }
 
 static TextStyle Getstyle(double fontSize,Color color,FontWeight fontWeight){
     return GoogleFonts.ubuntu(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: TextDecoration.none,
     );
  }

  static loading(Color color){
    return LoadingAnimationWidget.fourRotatingDots(color: color, size: 50);
  }
}

class Textutil extends StatelessWidget {
  const Textutil({super.key, required this.text, required this.fontsize, required this.color, required this.fontWeight,});
  final String text;
  final double fontsize;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: Spaces.Getstyle(fontsize, color,fontWeight),overflow: TextOverflow.ellipsis,);
  }

}