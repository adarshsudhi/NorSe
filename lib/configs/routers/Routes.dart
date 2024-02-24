import 'package:flutter/material.dart';
import 'package:nebula/features/Presentation/CustomWidgets/onlinequeue.dart';
import 'package:nebula/features/Presentation/Pages/Aboutpage/aboutpage.dart';
import 'package:nebula/features/Presentation/Pages/MainHomePage/MainHomePage.dart';
import 'package:nebula/features/Presentation/Pages/Settings/settingspage.dart';
import 'package:nebula/features/Presentation/Pages/Testingplayerscreen/testonlineplayerscreen.dart';
import 'package:nebula/features/Presentation/Pages/Testingplayerscreen/testplayerscreen.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/SearchResultPage/SearchResultPage.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/backupandrestore/backupandrestore.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/youtubescreen/ytdetails.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/youtubescreen/ytpage.dart';
import '../../features/Presentation/Pages/DownloadPages/Downloadpages.dart';
import '../../features/Presentation/Pages/Favpage/localfavsongpage.dart';
import '../../features/Presentation/Pages/onlinefavepage.dart';
import '../../features/Presentation/Pages/subscreens/SongDetailsPage/SongDetailsPage.dart';
import '../../features/Presentation/Pages/subscreens/albumsongscreen/albumsongspage.dart';
import '../../features/Presentation/Pages/subscreens/playlistsongscreen/playlistsongspage.dart';

Route<dynamic>? onGenerate(RouteSettings settings){
    switch (settings.name) {

      case MainHomePage.MainHomePAge:
         return MaterialPageRoute(settings: settings,builder: (_)=>const MainHomePage());

      case SongDetailsPage.SongDetials:
      final para = settings.arguments as SongDetailsPage;
         return MaterialPageRoute(settings: settings,builder: (_)=>SongDetailsPage(imageurl: para.imageurl, albumurl: para.albumurl,name: para.name,id: para.id,type: para.type,));

      case SearchResultscreen.Searchscreen:
        final args = settings.arguments as String;
         return MaterialPageRoute(settings: settings,builder: (_)=>SearchResultscreen(Querydata: args));  
        
      case Downloadpage.Downloadscreen:
          return MaterialPageRoute(builder: (_)=>const Downloadpage());  

       case Localfavsongpage.localfavpage:
          return MaterialPageRoute(builder: (_)=>const Localfavsongpage());

       case Playlistsongspage.playlistsongpage:
          final arg = settings.arguments as String;
          return MaterialPageRoute(builder: (_)=> Playlistsongspage(playlistid: arg,)); 
      
       case Onlinefavscreen.onlinefavscreen:
          return MaterialPageRoute(builder: (_)=>const Onlinefavscreen());

       case Albumsongspage.albumsongspage:
          final arg = settings.arguments as int;
          return MaterialPageRoute(builder: (_)=> Albumsongspage(id: arg));

       case Aboutpage.aboutpage:
          return MaterialPageRoute(builder: (_)=> const Aboutpage());

       case Testplayerscreen.textscreen:
          final args = settings.arguments as String;
          return MaterialPageRoute(builder: (_)=>  Testplayerscreen(currentscreen: args,));

       case Onlineplayerscreen.onlineplayerscreen:
          return MaterialPageRoute(builder: (_)=> const Onlineplayerscreen());

       case Onlinequeue.onlinequeuescreen:
          final args = settings.arguments as Onlinequeue;
          return MaterialPageRoute(builder: (_)=> Onlinequeue(audios: args.audios,audioPlayer: args.audioPlayer,));

       case Settingpage.settingpage:
          return MaterialPageRoute(builder: (_)=> const Settingpage());

       case Backupandrestore.backupandrestore:
          return MaterialPageRoute(builder: (_)=> const Backupandrestore());

       case Ytdetailss.ytdetails:
          final args = settings.arguments as Ytdetailss;
          return MaterialPageRoute(builder: (_)=>Ytdetailss(video: args.video,));

      default:
    }
    return null;
}