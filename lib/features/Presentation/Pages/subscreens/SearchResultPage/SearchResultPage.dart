import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:nebula/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/Domain/Entity/SongsDetailsEntity/SongsEntity.dart';
import 'package:nebula/features/Presentation/Pages/MainHomePage/MainHomePage.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../Data/Models/onlinesongmodel.dart';
import '../../../../Domain/UseCases/Sql_UseCase/addtodownloads_Usecase.dart';
import '../../../Bloc/SearchSong_bloc/search_song_bloc.dart';
import '../../../Bloc/audio_bloc/audio_bloc.dart';
import '../../../CustomWidgets/CustomSearchTextFormfield.dart';
import '../../../CustomWidgets/shimmer.dart';
import '../../Testingplayerscreen/testonlineplayerscreen.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class SearchResultscreen extends StatefulWidget {
  static const String Searchscreen = '/Searchpage';
  final String Querydata;
  const SearchResultscreen({
    Key? key,
    required this.Querydata,
  }) : super(key: key);

  @override
  State<SearchResultscreen> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultscreen> {
   final TextEditingController _searchController = TextEditingController();

 void closeKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchSongBloc>(context).add(GetSearchSong(Querydata: widget.Querydata));
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.black,
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
      title: Text("Search",style: Spaces.Getstyle(23,Colors.white,FontWeight.bold),),
    ),
      body:DefaultTabController(
        length: 3,
       child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
             child:Padding(
               padding: const EdgeInsets.only(top: 10,left: 2),
               child: Stack(
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
                     child: Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Hero(
                                     tag: 12,
                                     child: CustomSearchTextFormfield(search: false,SearchController: _searchController,ontap: () {
                                        if (_searchController.text.isNotEmpty) {
                                    BlocProvider.of<SearchSongBloc>(context).add(GetSearchSong(Querydata: _searchController.text.trim()));
                                 }
                                     },))
                         ),
                         SizedBox(
                           height: 50,
                           child: TabBar(                    
                             dividerColor: Colors.black,
                             indicatorColor: const Color.fromARGB(255, 0, 0, 0),
                              labelStyle: Spaces.Getstyle(13,Colors.black, FontWeight.bold),
                         labelColor: const Color.fromARGB(255, 255, 255, 255),
                         unselectedLabelColor: const Color.fromARGB(255, 94, 94, 94),
                         indicator: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: Colors.transparent),
                             tabs: const [
                             Text('Songs'),
                             Text('Albums'),
                             Text('Playlists'),
                           ]),                 
                         ),
                         Expanded(
                           child: BlocBuilder<SearchSongBloc,SearchSongState>(
                             builder: (context, state) {
                               if (state is SearchSongLoading) {
                                  return Column(
                                   children: [
                                     Expanded(
                                       child: SizedBox(
                                                           child:    
                                       TabBarView(
                                                             children: [
                                                              ListView.builder(
                                                                itemCount: 20,
                                                                itemBuilder:(context, index) {
                                       return const Searchsongloading();
                                                              },),
                                                              ListView.builder(
                                                                itemCount: 20,
                                                                itemBuilder:(context, index) {
                                       return const Searchsongloading();
                                                              },),
                                                              ListView.builder(
                                                                itemCount: 20,
                                                                itemBuilder:(context, index) {
                                       return const Searchsongloading();
                                                             },),
                                                           ]),
                                                                  ),
                                     )],
                                 );
                               }else if (state is SearchSongLoaded){
                                 return TabBarView(
                             children: [
                              ListView.builder(
                                itemCount: state.Seachsong.length,
                                itemBuilder:(context, index) {
                                  final data = state.Seachsong[index];
                                 return InkWell(
                                   onTap: () {
                                     List<Map<dynamic,dynamic>> moreinfo = [];
                                     moreinfo.isNotEmpty?moreinfo.clear():null;
                                     for (var items in state.Seachsong) {
                                        moreinfo.add(items.moreinfo);
                                     }
                                     log(moreinfo.length.toString());
                                     Recents(state.Seachsong, index, context,'null');
                                  
                                  
                                       BlocProvider.of<AudioBloc>(context)
                                      .add(AudioEvent.
                                      onlineaudio(
                                       state.Seachsong[index].id, 
                                       index,
                                       state.Seachsong[index].downloadUrl, 
                                       state.Seachsong[index].image, 
                                       moreinfo[index]['album'], 
                                       state.Seachsong[index].primaryArtists, 
                                      moreinfo, 
                                      const [],
                                      state.Seachsong, 
                                      const []));
                                   },
                                   child: Songtiles(name: data.name, image: data.image,
                                    artist: data.primaryArtists, icons1: Icons.download, icons2: Icons.favorite_outline, 
                                    visible1: true,
                                     visible2: false, ontap: () { 
                                        
                                     },
                                     ontapqueue: () {
                                           OnlineSongModel onlineSongModel = OnlineSongModel(
                                              id: state.Seachsong[index].id, 
                                              title: state.Seachsong[index].name, 
                                              imageurl: state.Seachsong[index].image, 
                                              downloadurl: state.Seachsong[index].downloadUrl, 
                                              artist: state.Seachsong[index].primaryArtists);
                                                         
                                               BlocProvider.of<AudioBloc>(context).add(AudioEvent.addtonlinequeue('online',onlineSongModel));
                                              
                                     },),
                                 );
                              },),
                              ListView.builder(
                                itemCount: state.albums.length,
                                itemBuilder:(context, index) {
                                  final details = state.albums[index];
                                 return InkWell(
                                   onTap: () {
                                     Navigator.pushNamed(context,SongDetailsPage.SongDetials,arguments: SongDetailsPage(
                                     type: 'album',
                                     imageurl: details.image,
                                     albumurl: details.albumurl,
                                     name: details.name,
                                     id: details.id));
                                   },
                                   child: Songtiles(name: details.name, image: details.image,
                                    artist: details.primaryArtists, icons1: Icons.download, icons2: Icons.favorite_outline, visible1: false,
                                     visible2: false, ontap: () async{
                                     final data =  state.Seachsong[index];
                                                           AlbumElements
                                                               albumElements =
                                                               AlbumElements(
                                                                   id: data.id,
                                                                   name: data.name,
                                                                   year: '',
                                                                   type: data.moreinfo['album'],
                                                                   language: 'null',
                                                                   Artist: data
                                                                       .primaryArtists,
                                                                   url: data
                                                                       .downloadUrl,
                                                                   image:
                                                                       data.image);
                                                           await di
                                                               .di<addtodownloadsUsecase>()
                                                               .call(albumElements);
                                     },
                                     ontapqueue: () {
                                       
                                     },
                                     ),
                                 );
                              },),
                              ListView.builder(
                                itemCount: state.playlists.length,
                                itemBuilder:(context, index) {
                                  final details = state.playlists[index];
                                 return InkWell(
                                   onTap: () {
                                     Navigator.pushNamed(context,SongDetailsPage.SongDetials,arguments: SongDetailsPage(
                                     type: details.type,
                                     imageurl: details.image,
                                     albumurl: details.albumurl,
                                     name: details.title,
                                     id: details.id));
                                   },
                                   child: Songtiles(name: details.title, image: details.image,
                                    artist: details.type, icons1: Icons.download, icons2: Icons.favorite_outline, visible1: false,
                                     visible2: false, ontap: () {  },ontapqueue: () {
                                       
                                     },),
                                 );
                              },),
                           ]);
                               }else{
                                 return const SizedBox();
                               }
                             },
                           ),
                         )
                       ],
                     ),
                   ),
                   const Align(
                 alignment: Alignment.bottomCenter,
                 child: BottomMusicBar()
               )
                 ],
               ),
             ),
           
       )),);
  }
}


class Loadingwidget extends StatelessWidget {
  const Loadingwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     height: MediaQuery.sizeOf(context).height,
     width: MediaQuery.sizeOf(context).width,
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Spaces.loading(Colors.white),
         Spaces.Kheight10,
         Text('Fetching Details',style: Spaces.Getstyle(17, const Color.fromARGB(255, 255, 255, 255),FontWeight.normal),),
         Spaces.Kheight10,
         Text('Please Wait...',style: Spaces.Getstyle(17, const Color.fromARGB(255, 255, 255, 255),FontWeight.normal),),
       ],
      ),
    );
  }
}
