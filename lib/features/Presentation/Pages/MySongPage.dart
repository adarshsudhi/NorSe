import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Data/Models/songmodel.dart';
import 'package:nebula/features/Presentation/Bloc/LocalSongs_bloc/localsong_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/audio_bloc/audio_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/playlist_Bloc/playlist_bloc.dart';
import 'package:nebula/features/Presentation/Pages/Favpage/localfavsongpage.dart';
import 'package:nebula/features/Presentation/Pages/MainHomePage/MainHomePage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Bloc/favorite_bloc/favoriteplaylist_bloc.dart';
import '../CustomWidgets/CustomTextFormField.dart';
import 'subscreens/SongDetailsPage/SongDetailsPage.dart';
import 'subscreens/albumsongscreen/albumsongspage.dart';
import 'subscreens/playlistsongscreen/playlistsongspage.dart';

class MySongPage extends StatefulWidget {
  const MySongPage({super.key});

  @override
  State<MySongPage> createState() => _MySongPageState();
}

class _MySongPageState extends State<MySongPage> {
  final TextEditingController _controller = TextEditingController();

       _getallsongs(BuildContext context){
  BlocProvider.of<LocalsongBloc>(context).add(const LocalsongEvent.getallsongs());
       }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.8),
          extendBodyBehindAppBar: true,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SafeArea(
              child: Column(
                children: [
                  Spaces.Kheight10,
                  TabBar(
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      labelStyle:
                          Spaces.Getstyle(13, Colors.black, FontWeight.bold),
                      labelColor: const Color.fromARGB(255, 255, 255, 255),
                      unselectedLabelColor:
                          const Color.fromARGB(255, 69, 69, 69),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      tabs: const [
                       Text("SONGS"),
                       Text('ALBUMS'),
                       Text("PLAYLISTS")
                      ]),
                  Expanded(
                    child: TabBarView(children: [
                      Column(
                        children: [
                          Spaces.Kheight20,
                          Expanded(
                            child: BlocBuilder<LocalsongBloc, LocalsongState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () => const SizedBox(),
                                  songs: (songlist, albums, isloading, failed) {
                                    if (isloading) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ));
                                    } else {
                                      return SingleChildScrollView(
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Spaces.Kheight10,
                                            SizedBox(
                                                height: 70,
                                                width: double.infinity,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 130,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.2)),
                                                            child: Center(
                                                              child: TextButton
                                                                  .icon(
                                                                      onPressed:
                                                                          () {
                                                                        BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio(songlist,[],Random().nextInt(songlist.length)));
                                                                        BlocProvider.of<AudioBloc>(context).add(const AudioEvent.shuffleon(true));    
                                                                        setState(() {
                                                                        isSuffled = true;
                                                                        });
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .shuffle,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      label:
                                                                         const Textutil(text: "Shuffle", fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal)),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: 130,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.2)),
                                                            child: Center(
                                                              child: TextButton
                                                                  .icon(
                                                                      onPressed:
                                                                          () {
                                                                        BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio(songlist,[],0));
                                                                        BlocProvider.of<AudioBloc>(context).add(const AudioEvent.shuffleon(false));
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .play_arrow,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      label:
                                                                         const Textutil(text: "Play", fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal)),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ])),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: BlocBuilder<
                                                  FavoriteplaylistBloc,
                                                  FavoriteplaylistState>(
                                                builder: (context, state) {
                                                  return state.maybeWhen(
                                                      favsongs: (songs) {
                                                        return songs.isNotEmpty
                                                            ? SizedBox(
                                                                height: 290,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Textutil(text: 'Favorite(${songs.length})', fontsize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                                                                    Spaces
                                                                        .Kheight10,
                                                                    Expanded(
                                                                        child: PageView
                                                                            .builder(
                                                                      controller:
                                                                          PageController(
                                                                        viewportFraction:
                                                                            1,
                                                                      ),
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      itemCount:
                                                                          (songs.length / 3)
                                                                              .ceil(),
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return SizedBox(
                                                                          width:
                                                                              size.width,
                                                                          child:
                                                                              Column(
                                                                            children:
                                                                                List.generate(
                                                                              3,
                                                                              (innerIndex) {
                                                                                final itemIndex = index * 3 + innerIndex;
                                                                                if (itemIndex < songs.length) {
                                                                                  return Padding(
                                                                                    padding: const EdgeInsets.all(3),
                                                                                    child: Card(
                                                                                      elevation: 15,
                                                                                      shadowColor: Colors.grey.withOpacity(0.3),
                                                                                      color: Colors.transparent,
                                                                                      surfaceTintColor: Colors.transparent,
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                                                                      child: Container(
                                                                                        height: 70,
                                                                                        width: double.infinity,
                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.grey.withOpacity(0.2)),
                                                                                        child: Center(
                                                                                          child: GestureDetector(
                                                                                            onTap: () {
                                                                                               BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio([],songs, itemIndex));
                                                                                            },
                                                                                            child: ListTile(
                                                                                              leading: SizedBox(
                                                                                                height: 60,
                                                                                                width: 60,
                                                                                                child: Stack(
                                                                                                  alignment: Alignment.center,
                                                                                                  children: [
                                                                                                    Container(
                                                                                                      height: 46,
                                                                                                      width: 46,
                                                                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(60)),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                                      child: QueryArtworkWidget(
                                                                                                        id: int.parse(songs[itemIndex]['id']),
                                                                                                        type: ArtworkType.AUDIO,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              title: Textutil(text: songs[itemIndex]['title'], fontsize:13, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                              subtitle: Textutil(text: songs[itemIndex]['artist'], fontsize:10, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                              trailing: Container(
                                                                                                height: 40,
                                                                                                width: 40,
                                                                                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(60)),
                                                                                                child: const Center(
                                                                                                  child: Icon(
                                                                                                    CupertinoIcons.play_arrow,
                                                                                                    color: Colors.white,
                                                                                                    size: 15,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
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
                                                                    )),
                                                                  ],
                                                                ),
                                                              )
                                                            : const SizedBox();
                                                      },
                                                      orElse: () =>
                                                          const SizedBox());
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                 Textutil(text:'songs(${songlist.length})', fontsize:15, color: Colors.white, fontWeight: FontWeight.bold),
                                                  TextButton.icon(onPressed: (){
                                                    _getallsongs(context);
                                                  }, icon: const Icon(Icons.refresh,color: Colors.red,size: 17,), label: Text('Refresh',style: Spaces.Getstyle(13,Colors.red,FontWeight.bold),))
                                                ],
                                              ),
                                            ),
                                            Spaces.Kheight10,
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: songlist.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                    BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio(songlist,[],index));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.transparent,
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          children: [
                                                            QueryArtworkWidget(
                                                              artworkHeight: 55,
                                                              artworkWidth: 60,
                                                              artworkBorder: BorderRadius.circular(10),
                                                              id: songlist[index].id,
                                                              type: ArtworkType.AUDIO),
                                                              const SizedBox(width: 10,),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [                                      
                                                                       Textutil(text: songlist[index].displayNameWOExt, fontsize:18, color: Colors.white, fontWeight: FontWeight.bold),
                                                                       Textutil(text: songlist[index].artist!=null?songlist[index].artist!:"unknown", fontsize:13, color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold)
                                                                  ],
                                                                ),
                                                              ),
                                                              PopupMenuButton(
                                                                iconColor: Colors.white,
                                                              itemBuilder:
                                                            (BuildContext contex) {
                                                          return [
                                                            PopupMenuItem(
                                                                onTap: () {
                                                                  Songmodel songmodel = Songmodel(
                                                                    id: songlist[index].id, 
                                                                    title: songlist[index].displayNameWOExt, 
                                                                    subtitle: songlist[index].artist ?? "unkown", 
                                                                    uri: songlist[index].uri!);
                                                                  BlocProvider.of<AudioBloc>(context).add(AudioEvent.addsongtoqueue('local',songmodel));
                                                                },
                                                                child: const Text(
                                                                    'Add to Queue')),
                                                            
                                                          ];
                                                        },
                                                      ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                     
                                                   
                                                  ),
                                                );
                                              },
                                            ),
                                            const Spaceadjust()
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: BlocBuilder<LocalsongBloc,LocalsongState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  songs: (songlist, albums, isloading, failed) {
                                    return Column(
                                      children: [
                                        Spaces.Kheight20,
                                        Expanded(
                                          child: GridView.builder(
                                                itemCount: albums.length,
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                                                mainAxisSpacing: 20),
                                                itemBuilder:(context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(context,Albumsongspage.albumsongspage,arguments: albums[index].id);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                                      child: SizedBox(
                                                        width: size.width/2,
                                                        child: Stack(
                                                          alignment: Alignment.center,
                                                          children: [
                                                               QueryArtworkWidget(
                                                               artworkHeight: size.height/3,
                                                               artworkBorder: BorderRadius.circular(10),
                                                               size: 500,
                                                               artworkWidth: size.width/2,
                                                               id: albums[index].id,
                                                               type:ArtworkType.ALBUM),
                                                               Container(
                                                                decoration: BoxDecoration(
                                                                  gradient: RadialGradient(colors: [
                                                                    Colors.black.withOpacity(0.5),
                                                                    Colors.black.withOpacity(0.5)
                                                                  ])
                                                                ),
                                                               ),
                                                               Padding(
                                                                 padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                 child: Column(
                                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                                     children: [
                                                                      Text(albums[index].album,overflow: TextOverflow.ellipsis,style: Spaces.Getstyle(18,Colors.white,FontWeight.bold),textAlign: TextAlign.center,),
                                                                      Text('Songs ${albums[index].numOfSongs}',style: Spaces.Getstyle(9,Colors.white,FontWeight.normal),)
                                                                     ],
                                                                 ),
                                                               ) 
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  );
                                                },),
                                        ),
                                        const Spaceadjust()
                                      ],
                                    );
                                  },
                                  orElse: ()=>const SizedBox());
                              },
                            )
                            )
                        ],
                      ),
                      Column(
                        children: [
                          Spaces.Kheight20,
                          GestureDetector(
                            onTap: () {
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
                                              ContentType: "Playlist Name",
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
                                                  BlocProvider.of<PlaylistBloc>(
                                                          context)
                                                      .add(PlaylistEvent
                                                          .createplaylist(
                                                              _controller.text
                                                                  .trim()));
                                                  BlocProvider.of<PlaylistBloc>(
                                                          context)
                                                      .add(const PlaylistEvent
                                                          .getallplaylist());
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
                                                    child: Textutil(text:'Create', fontsize: 13, color: Colors.black, fontWeight: FontWeight.bold)
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 27,
                                      ),
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Textutil(text: 'Create playlist', fontsize: 17, color: Colors.white, fontWeight: FontWeight.bold)
                                   ,
                                ],
                              ),
                            ),
                          ),
                          Spaces.Kheight20,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(Localfavsongpage.localfavpage),
                                child: BlocBuilder<FavoriteplaylistBloc,
                                    FavoriteplaylistState>(
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                        favsongs: (songs) {
                                          if (songs.isEmpty) {
                                            return Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white
                                                          .withOpacity(0.1)),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                               const Textutil(text: 'My Favorites', fontsize: 17, color: Colors.white, fontWeight: FontWeight.normal)
                                              ],
                                            );
                                          }
                                          return Row(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white),
                                                child: QueryArtworkWidget(
                                                    artworkHeight: 60,
                                                    artworkWidth: 60,
                                                    artworkBorder:
                                                        BorderRadius.circular(
                                                            10),
                                                    id: int.parse(
                                                        songs[0]['id']),
                                                    type: ArtworkType.AUDIO),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const Textutil(text: 'My Favorites', fontsize: 17, color: Colors.white, fontWeight: FontWeight.bold)
                                            ],
                                          );
                                        },
                                        orElse: () => Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white
                                                          .withOpacity(0.1)),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                const Textutil(text: 'My Favorites', fontsize: 18, color: Colors.white, fontWeight: FontWeight.normal)
                                                
                                              ],
                                            ));
                                  },
                                )),
                          ),
                          Expanded(
                            child: BlocBuilder<PlaylistBloc, PlaylistState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                    allplaylists: (playlists) {
                                      if (playlists.isEmpty) {
                                        return const SizedBox();
                                      }
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: playlists.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        Playlistsongspage
                                                            .playlistsongpage,
                                                        arguments:
                                                            playlists[index]
                                                                ['title']);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.1)),
                                                        child: const Icon(
                                                          Icons.music_note,
                                                          color: Colors.white,
                                                          size: 25,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Textutil(text: playlists[index]['title'], fontsize: 18, color: Colors.white, fontWeight: FontWeight.normal)
                                                           
                                                          ],
                                                        ),
                                                      ),
                                                      PopupMenuButton(
                                                        icon: const Icon(
                                                          Icons.more_vert,
                                                          color: Colors.white,
                                                        ),
                                                        itemBuilder:
                                                            (BuildContext
                                                                contex) {
                                                          return [
                                                            PopupMenuItem(
                                                                onTap: () {
                                                                  BlocProvider.of<PlaylistBloc>(context).add(PlaylistEvent.removePlaylist(
                                                                      playlists[
                                                                              index]
                                                                          [
                                                                          'id'],
                                                                      playlists[
                                                                              index]
                                                                          [
                                                                          'title']));
                                                                  BlocProvider.of<
                                                                              PlaylistBloc>(
                                                                          context)
                                                                      .add(const PlaylistEvent
                                                                          .getallplaylist());
                                                                },
                                                                child: const Text(
                                                                    "Delete Playlist")),
                                                          ];
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        },
                                      );
                                    },
                                    orElse: () => const SizedBox());
                              },
                            ),
                          )
                        ],
                      )
                    ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
