import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/Trending_Song_bloc/trending_song_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/audio_bloc/audio_bloc.dart';
import 'package:nebula/features/Presentation/CustomWidgets/CustomSearchTextFormfield.dart';
import 'package:nebula/features/Presentation/CustomWidgets/shimmer.dart';
import '../../../../configs/constants/Spaces.dart';
import '../../Data/Models/onlinesongmodel.dart';
import '../Bloc/SearchSong_bloc/search_song_bloc.dart';
import 'Testingplayerscreen/testonlineplayerscreen.dart';
import 'subscreens/SongDetailsPage/SongDetailsPage.dart';


class SearchResultPage extends StatefulWidget {
  static const String Searchpage = '/Searchscreen';
  final String Querydata;
  const SearchResultPage({
    Key? key,
    required this.Querydata,
  }) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {

  final TextEditingController _searchController = TextEditingController();
 void closeKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}



 @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.black.withOpacity(0.8),
    extendBodyBehindAppBar: true,
      body:DefaultTabController(
        length: 3,
       child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
             child:SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10,left: 2),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Hero(
                                tag: 12,
                                child: CustomSearchTextFormfield(
                                search: false,
                                SearchController: _searchController,ontap: () {
                                if (_searchController.text.isNotEmpty) {
                                BlocProvider.of<SearchSongBloc>(context).add(GetSearchSong(Querydata: _searchController.text.trim()));
                            }
                                },)),
                    ),
                    
                    Expanded(
                      child: BlocBuilder<TrendingSongBloc,TrendingSongState>(builder:(context, state) {
                        if (state is Songstate) {
                          return BlocBuilder<SearchSongBloc,SearchSongState>(
                        builder: (context, state) {
                          if (state is SearchSongLoading) {
                             return Column(
                              children: [
                                SizedBox(
                      height: 50,
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.white,
                         labelStyle: Spaces.Getstyle(13,Colors.black, FontWeight.bold),
                    labelColor: const Color.fromARGB(255, 255, 255, 255),
                    unselectedLabelColor: const Color.fromARGB(255, 69, 69, 69),
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
                                  child: TabBarView(
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
                              ],
                            );
                          }else if (state is SearchSongLoaded){
                            return Column(
                              children: [
                                SizedBox(
                      height: 50,
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.white,
                         labelStyle: Spaces.Getstyle(13,Colors.black, FontWeight.bold),
                    labelColor: const Color.fromARGB(255, 255, 255, 255),
                    unselectedLabelColor: const Color.fromARGB(255, 69, 69, 69),
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
                                  child: TabBarView(
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

                                      Recents(state.Seachsong, index, context,'null');
                                      
                                      BlocProvider.of<AudioBloc>(context).
                                      add(AudioEvent.onlineaudio(
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
                                     artist: data.primaryArtists, icons1: Icons.download, icons2: Icons.favorite_outline, visible1: true,
                                      visible2: false, ontap: () {},ontapqueue: () {
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
                                      visible2: false, ontap: () {
                                        Navigator.pushNamed(context,SongDetailsPage.SongDetials,arguments: SongDetailsPage(imageurl: details.image,
                                         albumurl: details.albumurl,
                                          name: details.name,
                                           id: details.id,
                                            type: 'playlist'));
                                      },ontapqueue: () {
                                        
                                      },),
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
                                                                                             visible2: false,
                                                                                             ontap: () {  },
                                                                                             ontapqueue: () {
                                                                                               
                                                                                             },),
                                                                                         );
                                                         },),
                                                      ]),
                                ),
                              ],
                            );
                          }else{
                            return SizedBox(
                              height: MediaQuery.sizeOf(context).height,
                              width: MediaQuery.sizeOf(context).width,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20,left: 20),
                                      child: BlocBuilder<TrendingSongBloc,TrendingSongState>(
                                        builder: (context, state) {
                                          if (state is Songstate) {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Spaces.Kheight10,
                                              const SizedBox(
                                                height: 40,
                                                child:Textutil(text: 'Trending now', fontsize: 20, color: Colors.white, fontWeight: FontWeight.normal),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: state.trendingnow.length,
                                                  itemBuilder: (context, index) {
                                                    final details = state.trendingnow[index];
                                                  return Padding(
                                                    padding: const EdgeInsets.only(bottom: 30),
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (details.type == 'album') {
                                                                Navigator.pushNamed(context,SongDetailsPage.SongDetials,arguments: SongDetailsPage(
                                                                  imageurl: details.image,
                                                                   albumurl: details.albumurl,
                                                                    name: details.title,
                                                                     id: details.id,
                                                                      type: details.type));
                                                             } else if(details.type == 'playlist'){
                                                                Navigator.pushNamed(context,SongDetailsPage.SongDetials,arguments: SongDetailsPage(
                                                                  imageurl: details.image,
                                                                   albumurl: details.albumurl,
                                                                    name: details.title,
                                                                     id: details.id,
                                                                      type: details.type));
                                                             }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                                        clipBehavior: Clip.antiAlias,
                                                        height: MediaQuery.sizeOf(context).width/5,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              height: 60,
                                                              width: 70,
                                                              child: CachedNetworkImage(imageUrl: details.image.replaceAll('150x150','500x500'),fit: BoxFit.cover,filterQuality: FilterQuality.medium,
                                                              placeholder: (context, url) => Padding(
                                                                   padding: const EdgeInsets.all(10),
                                                                  child: Image.asset('assets/musical-note.png',color: Colors.grey,),
                                                                ),
                                                              )
                                                            ),Expanded(child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 10),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Textutil(text: details.title, fontsize: 18, color: Colors.white, fontWeight: FontWeight.normal),
                                                                      Spaces.Kheight10,
                                                                      Textutil(text: details.title, fontsize: 12, color: Colors.white, fontWeight: FontWeight.normal)
                                                                      ],
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                            
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  );
                                                },)
                                                )
                                            ],
                                          );
                                          }else{
                                            return const SizedBox();
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )
                            );
                          }
                        },
                      );
                        }else{
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 20,
                                  itemBuilder:(context, index) {
                                return const Searchsongloading();
                                },),
                              ),
                            ],
                          );
                        }
                      },)
                    ),
                  
                  ],
                ),
              
              ],
            ),
          ),
             ),
           
       )),);
  }
}

