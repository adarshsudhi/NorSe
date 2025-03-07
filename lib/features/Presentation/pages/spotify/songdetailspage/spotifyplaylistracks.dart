// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/spotify.dart';

import 'package:norse/features/Presentation/Blocs/spotify/spotifyalbumorplaylist/spotifyplaylistsoralbum_bloc.dart';

import '../../../../../configs/constants/Spaces.dart';
import '../../saavn/subscreens/SongDetailsPage/SongDetailsPage.dart';

class SpotifyPlaylistTracks extends StatefulWidget {
  final String albumid;
  final SpotifyApi spotifyApi;
  final User user;
  final List<PlaylistSimple> album;
  const SpotifyPlaylistTracks({
    Key? key,
    required this.albumid,
    required this.spotifyApi,
    required this.user,
    required this.album,
  }) : super(key: key);

  @override
  State<SpotifyPlaylistTracks> createState() => _SpotifyPlaylistTracksState();
}

class _SpotifyPlaylistTracksState extends State<SpotifyPlaylistTracks> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SpotifyplaylistsoralbumBloc>(context).add(SpotifyplaylistsoralbumEvent.getplaylisttracks(widget.spotifyApi,widget.user,widget.albumid));
  }

 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              BlocBuilder<SpotifyplaylistsoralbumBloc,SpotifyplaylistsoralbumState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loadingtracks: () => SizedBox.expand(
                        child: Songslistloading(
                      size: size,
                      show: true,
                    )),
                    playlisttracks:  ( tracks) {
                      return CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                            SliverAppBar(
                              surfaceTintColor: Colors.transparent,
                              leading: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                              pinned: true,
                              expandedHeight: 280,
                              stretch: true,
                              foregroundColor: Colors.transparent,
                              automaticallyImplyLeading: false,
                              backgroundColor: Colors.transparent,
                              flexibleSpace: FlexibleSpaceBar(
                                stretchModes: const [
                                  StretchMode.zoomBackground
                                ],
                                background: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: 
                                          widget.album[0].images![0].url!,
                                      fit: BoxFit.cover,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                              Colors.black,
                                              Colors.transparent
                                            ])),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: 70,
                                width: double.infinity,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Textutil(
                                                text: widget.album[0].name!,
                                                fontsize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                            Row(
                                              children: [
                                                Textutil(
                                                    text: "${widget.album[0].type}  •  ",
                                                    fontsize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                Textutil(
                                                    text:
                                                        " ${tracks.length} Tracks",
                                                    fontsize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            )),
                            SliverPadding(
                              padding: const EdgeInsets.only(bottom: 20),
                              sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      childCount: tracks.length,
                                      (context, index) {

                                 var images = tracks[index].album!.images!;

                                 log(tracks.length.toString());
                                 log(images.length.toString());
                                        
                                return  InkWell(
                                  onTap: () {
                                   
                                  },
                                  child: ListTile(
                                     leading: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CachedNetworkImage(imageUrl:  images.isEmpty ? widget.album[0].images![0].url! : images[1].url! ),
                                    ),
                                    title: Textutil(text: tracks[index].name!, fontsize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                    subtitle:  Row(
                                  children: tracks[index].artists!.map((value) => Textutil(text: " ${value.name} ", fontsize: 8, color: Colors.white, fontWeight: FontWeight.normal)).toList(),
                                ),
                                  )
                                );
                              })),
                            ),
                            const SliverToBoxAdapter(
                              child: Spaceadjust(),
                            )
                          ],
                      );
                    },
                    orElse: ()=> SizedBox.expand(
                        child: Songslistloading(
                      size: size,
                      show: true,
                    ))
                    );
                },
              ), 
            ],
          ),
        ));
  }
}