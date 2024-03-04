// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Data/Models/usermodel.dart';
import 'package:nebula/features/Domain/Entity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import 'package:nebula/features/Domain/Entity/LaunchDataEntity/LaunchDataEntity.dart';
import 'package:nebula/features/Presentation/Bloc/LocalData/localdata_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/Trending_Song_bloc/trending_song_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/User_bloc/user_bloc_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/audio_bloc/audio_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/recents_bloc/recents_bloc.dart';
import 'package:nebula/features/Presentation/CustomWidgets/CustomSearchTextFormfield.dart';
import 'package:nebula/features/Presentation/CustomWidgets/shimmer.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/SearchResultPage/SearchResultPage.dart';
import '../../../../injection_container.dart' as di;
import '../../Data/Models/onlinesongmodel.dart';
import '../../Domain/UseCases/Sql_UseCase/initializedatabase_Usecase.dart';
import '../Bloc/LocalSongs_bloc/localsong_bloc.dart';
import '../Bloc/SearchSong_bloc/search_song_bloc.dart';
import '../Bloc/favorite_bloc/favoriteplaylist_bloc.dart';
import '../Bloc/playlist_Bloc/playlist_bloc.dart';
import '../CustomWidgets/CustomTextFormField.dart';
import 'subscreens/SongDetailsPage/SongDetailsPage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _SearchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();



  @override
  void dispose() {
    super.dispose();
    _SearchController.dispose();
    _scrollController.dispose();
  }

    call()async{
    BlocProvider.of<PlaylistBloc>(context).add(const PlaylistEvent.getallplaylist());
    BlocProvider.of<LocalsongBloc>(context).add(const LocalsongEvent.getallsongs());
    BlocProvider.of<FavoriteplaylistBloc>(context).add(const FavoriteplaylistEvent.getallsongs());
    BlocProvider.of<TrendingSongBloc>(context).add(TrendingSongs());
    await di.di<initializedbusecase>().call();
  }

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<UserBlocBloc>(context).add(const UserBlocEvent.getuserdetails());
    super.initState();
    BlocProvider.of<RecentsBloc>(context).add(const RecentsEvent.getallrecent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black.withOpacity(0.8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return call();
                },
                child: Column(
                  children: [
                             Expanded(
                               child: ListView(
                                                 physics: const BouncingScrollPhysics(),
                                                 children: [
                                                   Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                             Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ClipRRect(
                                  child: SizedBox(
                                    height: 86,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Userspace(size: size, controller: _controller)
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                            
                                ),
                              ),
                                  Hero(
                                   tag: 12,
                                   child: Padding(
                                     padding: const EdgeInsets.only(right: 10,left: 10),
                                     child: CustomSearchTextFormfield(
                                       search: true,
                                       SearchController: _SearchController,
                                       ontap: () {
                                                if (_SearchController.text.isNotEmpty) {
                                                  BlocProvider.of<SearchSongBloc>(context).add(
                                                                       GetSearchSong(
                                                                           Querydata:
                                                                               _SearchController.text.trim()));
                                                  Navigator.pushNamed(
                                                                       context, SearchResultscreen.Searchscreen,
                                                                       arguments: _SearchController.text.trim());
                                                }
                                        },
                                     ),
                                   )),
                                          const SizedBox(
                                                width: 5,
                                           ),
                                                  BlocBuilder<RecentsBloc,RecentsState>(
                                                    builder: (context, state) {
                                                             return state.maybeWhen(recents: (recents) {
                                                               return recents.length >=4 && recents.isNotEmpty
                                  ? Lastsession(size: size,recents: recents,)
                                  : const SizedBox();
                                                             }, orElse: () {
                                                               return const SizedBox();
                                                             });
                                                    },
                                                  ),
                                                  Spaces.Kheight10,
                                                  const TitleText(titleTextt: 'Trending now'),
                                                  BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                                    builder: (context, state) {
                                                             if (state is Songstate) {
                                                               return TrendingSongsWidget(
                                  details: state.trendingnow, size: size);
                                                             } else if (state is TrendingSongLoading) {
                                                               return Songloadingwidget(size: size);
                                                             } else {
                                                               return Songloadingwidget(size: size);
                                                             }
                                                    },
                                                  ),
                                                  const TitleText(titleTextt: 'Top playlists'),
                                                  Spaces.Kheight10,
                                                  BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                                    builder: (context, state) {
                                                             if (state is Songstate) {
                                                               return SizedBox(
                                height: MediaQuery.sizeOf(context).height / 4,
                                width: double.infinity,
                                child: ListView.builder(
                                                             padding: EdgeInsets.zero,
                                                             scrollDirection: Axis.horizontal,
                                                             itemCount: state.newlyreleased.length,
                                                             itemBuilder: (context, index) {
                                                               final results = state.newlyreleased[index];
                                                               return Column(
                                children: [
                                  TrendingImageWidgets(
                                      size: size, results: results, index: index),
                                      Text(state.newlyreleased[index].suntitle,style: Spaces.Getstyle(8,Colors.white,FontWeight.normal),)
                                ],
                                                               );
                                                             },
                                ),
                                                               );
                                                             } else if (state is TrendingSongLoading) {
                                                               return Songloadingwidget(size: size);
                                                             } else {
                                                               return Songloadingwidget(size: size);
                                                             }
                                                    },
                                                  ),
                                                  const TitleText(titleTextt: 'Top albums'),
                                                  BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                                    builder: (context, state) {
                                                             if (state is Songstate) {
                                                               return TrendingSongsWidget(
                                  details: state.topalbums, size: size);
                                                             } else if (state is TrendingSongLoading) {
                                                               return Songloadingwidget(size: size);
                                                             } else {
                                                               return Songloadingwidget(size: size);
                                                             }
                                                    },
                                                  ),
                                                  const TitleText(titleTextt: 'Malayalam'),
                                                  BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                                    builder: (context, state) {
                                                             if (state is Songstate) {
                                                               return TrendingSongsWidget(
                                  details: state.Malayalam, size: size);
                                                             } else if (state is TrendingSongLoading) {
                                                               return Songloadingwidget(size: size);
                                                             } else {
                                                               return Songloadingwidget(size: size);
                                                             }
                                                    },
                                                  ),
                                                  const TitleText(titleTextt: 'Hindi'),
                                                 
                                                  BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                                    builder: (context, state) {
                                                             if (state is Songstate) {
                                                               return TrendingSongsWidget(
                                  details: state.hindi, size: size);
                                                             } else if (state is TrendingSongLoading) {
                                                               return Songloadingwidget(size: size);
                                                             } else {
                                                               return Songloadingwidget(size: size);
                                                             }
                                                    },
                                                  ),
                                                  const TitleText(titleTextt: 'Tamil'),
                                                  BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                                    builder: (context, state) {
                                                             if (state is Songstate) {
                                                               return TrendingSongsWidget(
                                  details: state.Tamil, size: size);
                                                             } else if (state is TrendingSongLoading) {
                                                               return Songloadingwidget(size: size);
                                                             } else {
                                                               return Songloadingwidget(size: size);
                                                             }
                                                    },
                                                  ),
                                                  const TitleText(titleTextt: 'English'),
                                                  BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                                    builder: (context, state) {
                                                             if (state is Songstate) {
                                                               return TrendingSongsWidget(
                                  details: state.English, size: size);
                                                             } else if (state is TrendingSongLoading) {
                                                               return Songloadingwidget(size: size);
                                                             } else {
                                                               return Songloadingwidget(size: size);
                                                             }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 70,
                                                  )
                                                            
                                                   ],
                                                   ),
                                                 ],
                                               ),
                             )
                    

                          
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class Userspace extends StatelessWidget {
  const Userspace({
    super.key,
    required this.size,
    required TextEditingController controller,
  }) : _controller = controller;

  final Size size;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBlocBloc,UserBlocState>(
      builder: (context, state) {
        return state.maybeWhen(
          userdetails: (user) {
            return user.name.isEmpty? SizedBox(
      height: double.infinity,
      width: size.width,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Spaces.Kheight10,
          const Textutil(text: 'Hello', fontsize: 20, color: Colors.white, fontWeight:FontWeight.normal),
          Spaces.kheigth5,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onLongPress: () {
                    showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        surfaceTintColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          height: size.height / 3.5,
                                          width: size.width / 1.1,
                                          decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius:
          BorderRadius.circular(20)),
                                          child: Column(
    mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
    crossAxisAlignment:
        CrossAxisAlignment.center,
    children: [
      CustomTextFormField(
          controller: _controller,
          ContentType: "Name",
          obscureText: false,
          prefixicon: Icons.playlist_add),
      Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          20)),
              child: const Center(
                child: Textutil(text: 'Cancel', fontsize: 13, color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Usermodel user = Usermodel(name: _controller.text.trim(), date: DateTime.now().toString());
              BlocProvider.of<UserBlocBloc>(context).add(UserBlocEvent.userdetails(user,'initial'));
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          20)),
              child: const Center(
                child: Textutil(text:'Update', fontsize: 13, color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      )
    ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                  },
                  child: const Textutil(text: 'guest', fontsize: 25, color: Colors.red, fontWeight:FontWeight.normal)),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Spaces.kheigth5,
        ],
      ),
      ):SizedBox(
      height: double.infinity,
      width: size.width,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Spaces.Kheight10,
          const Textutil(text: 'Hello', fontsize: 20, color: Colors.white, fontWeight:FontWeight.normal),
          Spaces.kheigth5,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onLongPress: () {
                     showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        surfaceTintColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          height: size.height / 3.5,
                                          width: size.width / 1.1,
                                          decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius:
          BorderRadius.circular(20)),
                                          child: Column(
    mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
    crossAxisAlignment:
        CrossAxisAlignment.center,
    children: [
      CustomTextFormField(
          controller: _controller,
          ContentType: "Name",
          obscureText: false,
          prefixicon: Icons.playlist_add),
      Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          20)),
              child: const Center(
                child: Textutil(text: 'Cancel', fontsize: 13, color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Usermodel user = Usermodel(name: _controller.text.trim(), date: DateTime.now().toString());
              BlocProvider.of<UserBlocBloc>(context).add(UserBlocEvent.userdetails(user,'update'));
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          20)),
              child: const Center(
                child: Textutil(text:'Update', fontsize: 13, color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      )
    ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                  },
                  child: Textutil(text: user.name, fontsize: 25, color: Colors.red, fontWeight:FontWeight.normal)),
              ],
            ),
          ),
          Spaces.kheigth5,
        ],));
          },
          orElse: ()=> SizedBox(
      height: double.infinity,
      width: size.width,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Spaces.Kheight10,
          const Textutil(text: 'Hello', fontsize: 20, color: Colors.white, fontWeight:FontWeight.normal),
          Spaces.kheigth5,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Textutil(text: 'USER', fontsize: 25, color: Colors.red, fontWeight:FontWeight.normal),
                const SizedBox(
                  width: 10,
                ),
                 IconButton(onPressed: (){
                   showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        surfaceTintColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          height: size.height / 3.5,
                                          width: size.width / 1.1,
                                          decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius:
          BorderRadius.circular(20)),
                                          child: Column(
    mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
    crossAxisAlignment:
        CrossAxisAlignment.center,
    children: [
      CustomTextFormField(
          controller: _controller,
          ContentType: "Name",
          obscureText: false,
          prefixicon: Icons.playlist_add),
      Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          20)),
              child: const Center(
                child: Textutil(text: 'Cancel', fontsize: 13, color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Usermodel user = Usermodel(name: _controller.text.trim(), date: DateTime.now().toString());
              BlocProvider.of<UserBlocBloc>(context).add(UserBlocEvent.userdetails(user,'initial'));
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          20)),
              child: const Center(
                child: Textutil(text:'Update', fontsize: 13, color: Colors.black, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      )
    ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                 }, icon: const Icon(Icons.edit,color: Colors.white,size: 20,))
              ],
            ),
          ),
          Spaces.kheigth5,
        ],
      ),
      ));
      },
    );
  }
}

class Lastsession extends StatelessWidget {
  final List<Map<String,dynamic>> recents;
  const Lastsession({
    Key? key,
    required this.recents,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 330,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
              children: [
                const TitleText(
                    titleTextt: 'Last Session'),
                Padding(
                  padding:
                      const EdgeInsets.only(
                          right: 20),
                  child: TextButton.icon(
                      onPressed: () {
                        BlocProvider.of<
                                    RecentsBloc>(
                                context)
                            .add(const 
                               RecentsEvent.clearecents());
                      },
                      icon: const Icon(
                        Icons.clear_all,
                        color: Colors.red,
                      ),
                      label: const Textutil(text: 'Clear all', fontsize: 13, color: Colors.red, fontWeight: FontWeight.normal)),
                ),
              ],
            ),
            Expanded(
              child: recents.isNotEmpty
                  ? PageView.builder(
                      scrollDirection:
                          Axis.horizontal,
                      itemCount:
                          (recents.length / 4)
                              .ceil(),
                      itemBuilder:
                          (BuildContext context,
                              int index) {
                        return SizedBox(
                          width: size.width,
                          child: Column(
                            children:
                                List.generate(
                              4,
                              (innerIndex) {
                                final itemIndex =
                                    index * 4 +
                                        innerIndex;
                                if (itemIndex <
                                    recents
                                        .length) {
                                  return InkWell(
                                    onTap: () {
                                      List<AlbumSongEntity>
                                          allsongs =
                                          [];
                                      for (var element
                                          in recents) {
                                        final song = AlbumSongEntity(
                                            id: element[
                                                'id'],
                                            name: element[
                                                'title'],
                                            year:
                                                'null',
                                            primaryArtists:
                                                element['artist'],
                                            image: element['imageurl'],
                                            songs: element['downloadurl'],
                                            albumurl: element['downloadurl']);
                                        allsongs
                                            .add(song);
                                      }
                                      
                                      BlocProvider.of<AudioBloc>(context)
                                      .add(AudioEvent.onlineaudio(
                                        allsongs[itemIndex].id, 
                                        itemIndex,
                                        allsongs[itemIndex].songs, 
                                        allsongs[itemIndex].image, 
                                        allsongs[itemIndex].name, 
                                        allsongs[itemIndex].primaryArtists, 
                                         const [], 
                                        allsongs, 
                                        const [], 
                                        const []));
                                   

                                    },
                                    child:
                                        SizedBox(
                                      height:
                                          70,
                                      child:
                                          Padding(
                                        padding: const EdgeInsets
                                            .only(
                                            bottom:
                                                7),
                                        child:
                                            ListTile(
                                          trailing:
                                              PopupMenuButton(
                                                iconColor: Colors.white,
                                                color: Colors.white.withOpacity(0.9),
                                                surfaceTintColor: Colors.transparent,
                                            itemBuilder:
                                                (BuildContext contex) {
                                              return [
                                                PopupMenuItem(
                                                    onTap: () {

                                                    },
                                                    child: const Text('Play')),
                                                PopupMenuItem(
                                                    onTap: () {
                                                      BlocProvider.of<LocaldataBloc>(context).add(LocaldataEvent.removefromRecents(recents[itemIndex]['id']));
                                                      BlocProvider.of<RecentsBloc>(context).add(const RecentsEvent.getallrecent());
                                                    },
                                                    child: const Text('Remove')),
                                                  PopupMenuItem(
                                                    onTap: () {
                                         OnlineSongModel onlineSongModel = OnlineSongModel(
                                         id: recents[itemIndex]['id'], 
                                         title: recents[itemIndex]['title'], 
                                         imageurl: recents[itemIndex]['imageurl'], 
                                         downloadurl: recents[itemIndex]['downloadurl'], 
                                         artist: recents[itemIndex]['artist']);
                                                    
                                         BlocProvider.of<AudioBloc>(context).add(AudioEvent.addtonlinequeue('online',onlineSongModel));
                                         
                                                    },
                                                    child: const Text('Add to Queue')),   
                                              ];
                                            },
                                          ),
                                          leading:
                                              Container(
                                            height:
                                                90,
                                            width:
                                                55,
                                            decoration:
                                                BoxDecoration(borderRadius: BorderRadius.circular(6), image: DecorationImage(image: CachedNetworkImageProvider(recents[itemIndex]['imageurl']), fit: BoxFit.cover)),
                                          ),
                                          subtitle:
                                              Text(
                                            recents[itemIndex]['artist'],
                                            style: Spaces.Getstyle(
                                                10,
                                                Colors.white,
                                                FontWeight.normal),
                                            overflow:
                                                TextOverflow.ellipsis,
                                          ),
                                          title:
                                              Text(
                                            recents[itemIndex]['title'],
                                            style: Spaces.Getstyle(
                                                15,
                                                Colors.white,
                                                FontWeight.bold),
                                            overflow:
                                                TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(); 
                                }
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
            )
          ],
        ),
      );
  }
}

class TitleText extends StatelessWidget {
  final String titleTextt;
  const TitleText({
    Key? key,
    required this.titleTextt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
          height: 30,
          child: Center(
              widthFactor: 1.0,
              child: Textutil(text: titleTextt, fontsize:  22, color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }
}

class TrendingSongsWidget extends StatelessWidget {
  final List<launchdataEntity> details;
  final Size size;
  const TrendingSongsWidget({
    Key? key,
    required this.details,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 4,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: details.length,
        itemBuilder: (context, index) {
          final results = details[index];
          return TrendingImageWidgets(
              size: size, results: results, index: index);
        },
      ),
    );
  }
}

class TrendingImageWidgets extends StatelessWidget {
  const TrendingImageWidgets({
    Key? key,
    required this.size,
    required this.results,
    required this.index,
  }) : super(key: key);

  final Size size;
  final launchdataEntity results;
  final int index;

  @override
  Widget build(BuildContext context) {
    final img = results.image.replaceAll('150x150.jpg', '500x500.jpg');
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
               if (results.type == 'album') {
              Navigator.pushNamed(context, SongDetailsPage.SongDetials,
                  arguments: SongDetailsPage(
                      type: results.type,
                      imageurl: results.image,
                      albumurl: results.albumurl,
                      name: results.title,
                      id: results.id));
            } else if (results.type == 'playlist') {
              Navigator.pushNamed(context, SongDetailsPage.SongDetials,
                  arguments: SongDetailsPage(
                      type: results.type,
                      imageurl: results.image,
                      albumurl: results.albumurl,
                      name: results.title,
                      id: results.id));
            }
          },
          child: SizedBox(
            width: size.width / 2.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 5.7,
                  padding: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: SizedBox(
                    width: size.width / 2.3,
                    child: CachedNetworkImage(
                      imageUrl: img,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/musical-note.png',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Textutil(text: results.title, fontsize: 12, color: Colors.white, fontWeight: FontWeight.normal) 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
