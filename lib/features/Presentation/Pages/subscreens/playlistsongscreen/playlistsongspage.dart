import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/playlistsongs_bloc/playlistsongs_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../Bloc/audio_bloc/audio_bloc.dart';
import '../../../CustomWidgets/backgroundGradient.dart';
import '../../Favpage/localfavsongpage.dart';
import '../../MainHomePage/MainHomePage.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class Playlistsongspage extends StatefulWidget {
  static const String playlistsongpage = "./playlistsongpage";
  const Playlistsongspage({
    Key? key,
    required this.playlistid,
  }) : super(key: key);
  final String playlistid;

  @override
  State<Playlistsongspage> createState() => _PlaylistsongspageState();
}

class _PlaylistsongspageState extends State<Playlistsongspage> {
  get details => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlaylistsongsBloc>(context)
        .add(PlaylistsongsEvent.getplaylistsongs(widget.playlistid));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
                      const backgroundgradient(), 
                Container(
          color: Colors.black.withOpacity(0.8),
        ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(Localfavsongpage.localfavpage),
                        child:
                            BlocBuilder<PlaylistsongsBloc, PlaylistsongsState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                                songs: (songs) {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                        child: songs.isNotEmpty
                                            ? QueryArtworkWidget(
                                                artworkHeight: 70,
                                                artworkWidth: 70,
                                                artworkBorder:
                                                    BorderRadius.circular(10),
                                                id: int.parse(songs[0]['id']),
                                                type: ArtworkType.AUDIO)
                                            : const Center(child: Icon(Icons.music_note,color: Colors.white,),),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        widget.playlistid,
                                        style: Spaces.Getstyle(18, Colors.white,
                                            FontWeight.normal),
                                      ),
                                    ],
                                  );
                                },
                                orElse: () => Row(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white
                                                  .withOpacity(0.3)),
                                          child: const Center(child: Icon(Icons.music_note,color: Colors.white,),),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          widget.playlistid,
                                          style: Spaces.Getstyle(18,
                                              Colors.white, FontWeight.normal),
                                        ),
                                      ],
                                    ));
                          },
                        )),
                  ),
                  Spaces.Kheight20,
                  Spaces.Kheight10,
                  BlocBuilder<PlaylistsongsBloc, PlaylistsongsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        songs: (songs) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              Container(
                                height: 50,
                                width: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.2)),
                                child: Center(
                                  child: TextButton.icon(
                                      onPressed: () {
                                        BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio([],songs,0));
                                      },
                                      icon: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Play',
                                        style: Spaces.Getstyle(15, Colors.white,
                                            FontWeight.normal),
                                      )),
                                ),
                              )
                            ],
                          );
                        },
                        orElse: () {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 50,
                                width: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.2)),
                                child: Center(
                                  child: TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.shuffle,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Shuffle',
                                        style: Spaces.Getstyle(15, Colors.white,
                                            FontWeight.normal),
                                      )),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.2)),
                                child: Center(
                                  child: TextButton.icon(
                                      onPressed: () {
                      
                                      },
                                      icon: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Play',
                                        style: Spaces.Getstyle(15, Colors.white,
                                            FontWeight.normal),
                                      )),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Spaces.Kheight20,
                  Expanded(
                    child: BlocBuilder<PlaylistsongsBloc, PlaylistsongsState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                            songs: (songs) {
                              if (songs.isEmpty) {
                                return const SizedBox();
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        'songs(${songs.length})',
                                        style: Spaces.Getstyle(18, Colors.white,
                                            FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: songs.length,
                                        itemBuilder: (context, index) {
                                          final songdetails = songs[index];
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                         BlocProvider.of<AudioBloc>(context).add(AudioEvent.localaudio([],songs,index,));
                                              },
                                              child: ListTile(
                                                  trailing: PopupMenuButton(
                                                    itemBuilder:
                                                        (BuildContext contex) {
                                                      return [
                                                        PopupMenuItem(
                                                            onTap: () {
                      
                                                            },
                                                            child: const Text(
                                                                'Play')),
                                                        PopupMenuItem(
                                                            onTap: () {
                                                              BlocProvider.of<
                                                                          PlaylistsongsBloc>(
                                                                      contex)
                                                                  .add(PlaylistsongsEvent.deletesong(
                                                                      widget
                                                                          .playlistid,
                                                                      songdetails[
                                                                          'id']));
                                                              BlocProvider.of<
                                                                          PlaylistsongsBloc>(
                                                                      context)
                                                                  .add(PlaylistsongsEvent
                                                                      .getplaylistsongs(
                                                                          widget
                                                                              .playlistid));
                                                            },
                                                            child: const Text(
                                                                'Remove')),
                                                      ];
                                                    },
                                                  ),
                                                  title: Text(
                                                    songdetails['title'],
                                                    style: Spaces.Getstyle(
                                                        17,
                                                        Colors.white,
                                                        FontWeight.normal),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  subtitle: Text(
                                                    songdetails['artist'],
                                                    style: Spaces.Getstyle(
                                                        10,
                                                        Colors.white.withOpacity(0.5),
                                                        FontWeight.normal),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  leading: QueryArtworkWidget(
                                                      artworkHeight: 60,
                                                      artworkWidth: 60,
                                                      artworkBorder:
                                                          BorderRadius.circular(
                                                              10),
                                                      id: int.parse(
                                                          songdetails['id']),
                                                      type: ArtworkType.AUDIO)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                   const Spaceadjust()
                                  ],
                                );
                              }
                            },
                            orElse: () => const SizedBox());
                      },
                    ),
                  )
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: BottomMusicBar(),
            )
          ],
        ),
      ),
    );
  }
}
