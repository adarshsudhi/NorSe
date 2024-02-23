import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/backupandrestore/backupandrestore.dart';

class Settingpage extends StatelessWidget {
  static const String settingpage = './settingpage';
  const Settingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 20,)),
        title: const Textutil(text: 'Settings', fontsize: 23, color: Colors.white, fontWeight: FontWeight.normal),
      ),
      body: Stack(
        children: [
          Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
              Colors.indigo,
              Colors.black
            ])
          ),
        ),  
                  Container(
            color: Colors.black.withOpacity(0.8),
          ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Spaces.Kheight20,
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context,Backupandrestore.backupandrestore);
                  },
                  leading: const Icon(Icons.restore,color: Colors.white,size: 27,),
                  title: const Textutil(text: 'Backup & restore', fontsize: 17, color: Colors.white, fontWeight: FontWeight.normal),
                  subtitle: Textutil(text: "Backup data", fontsize: 10, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        )
        ],
      )
    );
  }
}