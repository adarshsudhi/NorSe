import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Spaces {
  static const kheigth5 = SizedBox(height: 5,);
  static const Kheight10 = SizedBox(height: 10,); 
  static const Kheight20 = SizedBox(height: 20,);

  static showtoast(String Content){
    return Fluttertoast.showToast(msg: Content,textColor: Colors.black,backgroundColor: Colors.white,gravity: ToastGravity.SNACKBAR);
  }

 static TextStyle Getstyle(double fontSize,Color color,FontWeight fontWeight){
   // GoogleFonts.roboto()
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