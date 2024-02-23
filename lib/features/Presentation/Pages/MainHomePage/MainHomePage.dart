import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nebula/features/Domain/UseCases/Sql_UseCase/initializedatabase_Usecase.dart';
import 'package:nebula/features/Presentation/Bloc/audio_bloc/audio_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/playlist_Bloc/playlist_bloc.dart';
import 'package:nebula/features/Presentation/Pages/Aboutpage/aboutpage.dart';
import 'package:nebula/features/Presentation/Pages/Settings/settingspage.dart';
import 'package:nebula/features/Presentation/Pages/Testingplayerscreen/testonlineplayerscreen.dart';
import 'package:nebula/features/Presentation/Pages/Testingplayerscreen/testplayerscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:nebula/injection_container.dart' as di;
import 'package:shimmer/shimmer.dart';
import '../../../../configs/constants/Spaces.dart';
import '../../../Domain/UseCases/Platform_UseCase/GetPermissions_UseCase.dart';
import '../../Bloc/LocalSongs_bloc/localsong_bloc.dart';
import '../../Bloc/Trending_Song_bloc/trending_song_bloc.dart';
import '../../Bloc/favorite_bloc/favoriteplaylist_bloc.dart';
import '../../Bloc/ytsearch_bloc/ytsearch_bloc.dart';
import '../DownloadPages/Downloadpages.dart';
import '../HomePage.dart';
import '../MySongPage.dart';
import '../SearchPage.dart';
import '../onlinefavepage.dart';
import '../subscreens/youtubescreen/ytpage.dart';


bool islooped = false;
bool isSuffled = false;
class MainHomePage extends StatefulWidget {
  static const String MainHomePAge = '/mainhomepage';
   const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); 
  
   int Currentindex = 0;

  List<Widget> pages = [
      const HomePage(),
      MySongPage(),
      const SearchResultPage(Querydata: ''),
      const Youtubepage()
  ];
  void OpenDrawer(){
    scaffoldKey.currentState!.openDrawer();
  }
  void CloseDrawer(){
    scaffoldKey.currentState!.closeDrawer();
  }
  void call()async{
    BlocProvider.of<PlaylistBloc>(context).add(const PlaylistEvent.getallplaylist());
    BlocProvider.of<FavoriteplaylistBloc>(context).add(const FavoriteplaylistEvent.getallsongs());
    BlocProvider.of<TrendingSongBloc>(context).add(TrendingSongs());
  }

        _getallsongs(){
     
             BlocProvider.of<LocalsongBloc>(context)
            .add(const LocalsongEvent.getallsongs());
    
  }


    getpermission() async {
    try {
     await di.di<initializedbusecase>().call();
     bool check = await di.di<GetpermissionUseCase>().call().then((value) async {
              await _getallsongs();
              return value?value:false;
     });
      if (check != true) {
        Spaces.showtoast(
            'Some Permissions are not Granted Some App Features May not work');
      }
    } catch (e) {
      log(e.toString());
    }
  }

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      getpermission();
      call();
    });
  }

    final TextEditingController _textEditingController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: scaffoldKey,
       appBar: AppBar(backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          title: Currentindex == 0? const Textutil(text: 'Discover', fontsize: 23, color: Colors.white, fontWeight:FontWeight.bold):
          Currentindex == 1?const Textutil(text: 'My Music', fontsize: 23, color: Colors.white, fontWeight:FontWeight.bold):
          Currentindex == 2?const Textutil(text: 'Search', fontsize: 23, color: Colors.white, fontWeight:FontWeight.bold,)
          : Currentindex == 3?Row(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                         controller: _textEditingController,
                         style: Spaces.Getstyle(15,Colors.black,FontWeight.normal),
                         onFieldSubmitted: (value) {
                          BlocProvider.of<YtsearchBloc>(context).add(YtsearchEvent.getsearchdetails(_textEditingController.text));
                         },
                         decoration: InputDecoration(
                          prefixIcon: IconButton(onPressed: (){
                            BlocProvider.of<YtsearchBloc>(context).add(YtsearchEvent.getsearchdetails(_textEditingController.text));
                            }, icon: const Icon(Icons.search,color: Colors.black,)),
                          border: InputBorder.none,
                          
                          hintText: 'Search on Youtube',
                          hintStyle: Spaces.Getstyle(15,Colors.grey,FontWeight.normal)
                        ),
                      ),
              ),
            )
          ],):null,
          leading:InkWell(
           onTap: () => OpenDrawer(),
           child: Image.asset('assets/list.png',color: Colors.white,scale: 25,)),
           
          ),
     
       backgroundColor: Colors.transparent,
       extendBodyBehindAppBar: true,
       bottomNavigationBar: SalomonBottomBar(
       onTap: (p0) {
         setState(() {
           Currentindex = p0;
         });
       },
       currentIndex: Currentindex,
       selectedItemColor:  const Color.fromARGB(255, 255, 255, 255),
       backgroundColor:  Colors.black,
       selectedColorOpacity: 0.1,
       unselectedItemColor: Colors.grey.withOpacity(0.5),
       itemPadding:  const EdgeInsets.all(12),
       items: [
       SalomonBottomBarItem(icon:  const Icon(Icons.home), title:  Text('Discover',style: Spaces.Getstyle(11,Colors.white, FontWeight.normal),)),
       SalomonBottomBarItem(icon:  const Icon(Icons.folder_outlined), title:   Text('Local',style: Spaces.Getstyle(11,Colors.white, FontWeight.normal),)),
       SalomonBottomBarItem(icon:  const Icon(Icons.search), title:  Text('Search',style: Spaces.Getstyle(11,Colors.white, FontWeight.normal),)),
       SalomonBottomBarItem(icon:   SizedBox(
        width: 25,
        height: 25,
        child: Center(
          child: Image.asset('assets/yt.png',filterQuality: FilterQuality.low,color: Colors.white.withOpacity(0.5),),
        ),
       ), title:  Text('YouTube',style: Spaces.Getstyle(10,Colors.white, FontWeight.normal),)),
      ]),
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
         pages[Currentindex],
         const Align(
       alignment: Alignment.bottomCenter,
       child: BottomMusicBar()
      ),
       ],
      ),
      drawer: Drawer(
       backgroundColor:Colors.black.withOpacity(0.95),
       child: Column(
         children: [
           Expanded(
             child: ListView(
               children: [
                 SizedBox(
                   height: MediaQuery.sizeOf(context).height/4,
                   child: Center(
                     child: Stack(
                       alignment: Alignment.center,
                       children: [
                         SizedBox(
                           width:double.infinity,
                           child: Image.asset('assets/sound-wave.png',fit: BoxFit.fill,color: Colors.blue.withOpacity(0.1),)),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               AutoSizeText('NEBULA',style: GoogleFonts.aldrich(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                               Text('v 1.0.1',style: Spaces.Getstyle(10,Colors.white.withOpacity(0.7),FontWeight.normal),)
                             ],
                           ),
                        
                       ],
                     ),
                   ),
                 ),
                 Divider(thickness: 1,color: Colors.grey.withOpacity(0.1),),
                 Column(
                   children: [
                    Draweritems(ontap: (){
                     Currentindex = 0;
                     setState(() { });
                     CloseDrawer();
                    }, title: "Home", iconsdata: Icons.home),
                                       Draweritems(ontap: (){
                      Navigator.pushNamed(context,Onlinefavscreen.onlinefavscreen);
                    }, title: "My Library",
                     iconsdata: Icons.library_music_outlined),
                    Draweritems(ontap: (){
                     Navigator.pushNamed(context, Downloadpage.Downloadscreen);
                    }, title: "Downloads", iconsdata: Icons.download),
  
                     Draweritems(ontap: (){
                     Navigator.pushNamed(context,Settingpage.settingpage);
                    }, title: "Settings", iconsdata: Icons.settings),
                     Draweritems(ontap: (){
                      Navigator.pushNamed(context,Aboutpage.aboutpage);
                    }, title: "About", iconsdata: Icons.info_outline_rounded),
                   ],
                 ),
               ],
             ),
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Text("Build with ",style: Spaces.Getstyle(10,Colors.white,FontWeight.normal),),
              const Icon(Icons.favorite,color: Colors.red,size: 12,),
               Text(' by Adarsh N S ',style: Spaces.Getstyle(10,Colors.white,FontWeight.normal),),
             ],
           ),
           Spaces.Kheight20,
         ],
       ),
      ), 
    );
  }
}

class Draweritems extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  final IconData iconsdata;
  const Draweritems({
    Key? key,
    required this.ontap,
    required this.title,
    required this.iconsdata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ListTile(
        leading: Icon(iconsdata,color: Colors.white,size: 21,),
        title: Text(title,style: GoogleFonts.aldrich(color: Colors.white,fontSize: 15)),
      ),
    );
  }
}








class BottomMusicBar extends StatelessWidget {
  const BottomMusicBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc,AudioState>(
      builder: (context, state) {
        return state.maybeWhen(
            onlinesongs: (isloading, isfailed, audios, valueStream, index, audioPlayer) {
              return isloading == true? const MusicBottomBarloading(): StreamBuilder(
              stream: valueStream,
              builder:(context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {

                 int songindex = snapshot.data!.maybeMap(orElse: () => 0,onlinestreams: (val)=>val.index);

                 PlayerState dupplayerstate = PlayerState(false,ProcessingState.loading);
                  
                 PlayerState playerState = snapshot.data!.maybeMap(orElse: ()=>dupplayerstate,onlinestreams: (value) => value.playerState,);

                 
                    
            return  GestureDetector(
            onTap: () {
              Navigator.pushNamed(context,Onlineplayerscreen.onlineplayerscreen);
            },
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: Center(
                child: ListTile(
                  leading: Container(
                     clipBehavior: Clip.antiAlias,
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: Image.network(audios[songindex].imageurl,)
                  ),
                  title: SizedBox(
                    height: 20,
                    width: 150,
                    child: Textutil(text: audios[songindex].title, fontsize: 15, color: Colors.black, fontWeight:FontWeight.bold),
                  ),
                  subtitle: SizedBox(
                    height: 12,
                    width: 100,
                    child: Textutil(text: audios[songindex].artist, fontsize: 10, color: Colors.grey, fontWeight:FontWeight.normal),
                  ),
                  trailing: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                          BlocProvider.of<AudioBloc>(context).add(const AudioEvent.SeekPreviousAudio());
                        }, icon: const Icon(Icons.skip_previous,color: Colors.black,)),
                        GestureDetector(
                          onTap: () {
                            playerState.playing == true?
                            BlocProvider.of<AudioBloc>(context).add(const AudioEvent.pause()):
                            BlocProvider.of<AudioBloc>(context).add(const AudioEvent.resume());
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black
                            ),
                            child: Icon(playerState.playing == true? CupertinoIcons.pause:CupertinoIcons.play_arrow,color: Colors.white,size: 19,),
                          ),
                        ),
                        IconButton(onPressed: (){
                          BlocProvider.of<AudioBloc>(context).add(const AudioEvent.seeknextaudio());
                        }, icon: const Icon(Icons.skip_next,color: Colors.black,))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
         }else{
         return const SizedBox();
            }
              },);
            },
            Localsongs: (isloading, isfailed, audios, valueStream, index, audioPlayer) {
            return isloading == true? 
            const MusicBottomBarloading()
            :
            StreamBuilder(
              stream: valueStream,
              builder:(context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {

                PlayerState player = PlayerState(true, ProcessingState.loading);
                  
                PlayerState playerState = snapshot.data!.maybeMap(orElse: ()=>player,LocalStreams: (value) => value.playerState,);

                int songindex = snapshot.data!.maybeMap(orElse: ()=>0,LocalStreams: (value) => value.index,);
                  
                return  GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context,Testplayerscreen.textscreen,arguments: 'okey ');
                  },
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    child: Center(
                      child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: QueryArtworkWidget(
                    id: audios[songindex].id, 
                    type: ArtworkType.AUDIO,
                    keepOldArtwork: true,
                    nullArtworkWidget: const CircleAvatar(
                    radius: 30,
                    child: Shimmer(
                    gradient: LinearGradient(colors: [
                      Colors.grey,
                      Colors.white
                    ]),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                    )),
                  ),
                      ),
                  ),
                  title: SizedBox(
                    height: 20,
                    width: 150,
                    child: Textutil(text: audios[songindex].title, fontsize: 15, color: Colors.black, fontWeight:FontWeight.bold),
                  ),
                  subtitle: SizedBox(
                    height: 12,
                    width: 100,
                    child: Textutil(text: audios[songindex].subtitle, fontsize: 10, color: Colors.grey, fontWeight:FontWeight.normal),
                  ),
                  trailing: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                           BlocProvider.of<AudioBloc>(context).add(const AudioEvent.SeekPreviousAudio());
                        }, icon: const Icon(Icons.skip_previous,color: Colors.black,)),
                        GestureDetector(
                          onTap: () {
                            playerState.playing == true?
                            BlocProvider.of<AudioBloc>(context).add(const AudioEvent.pause()):
                            BlocProvider.of<AudioBloc>(context).add(const AudioEvent.resume());
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black
                            ),
                            child:  Icon(playerState.playing == true? CupertinoIcons.pause:CupertinoIcons.play_arrow,color: Colors.white,size: 19,),
                          ),
                        ),
                        IconButton(onPressed: (){
                          BlocProvider.of<AudioBloc>(context).add(const AudioEvent.seeknextaudio());
                        }, icon: const Icon(Icons.skip_next,color: Colors.black,))
                      ],
                    ),
                  ),
                                ),
                              ),
                            ),
                );
                }else{
                  return const SizedBox();
                }
              },);
          },
          orElse: ()=> const SizedBox());
      },
    );
   
  }
}



class MusicBottomBarloading extends StatelessWidget {
  const MusicBottomBarloading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
            child: Center(
              child: ListTile(
                leading:   Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                title: Container(
                  height: 12,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey
                  ),
                ),
                subtitle: Container(
                  height: 12,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey
                  ),
                ),
                trailing: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.skip_previous,color: Colors.black,)),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black
                        ),
                        child: const Icon(Icons.play_arrow,color: Colors.white,size: 19,),
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.skip_next,color: Colors.black,))
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}


