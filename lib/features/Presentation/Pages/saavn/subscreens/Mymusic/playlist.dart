import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../Blocs/Musicbloc/favorite_bloc/favoriteplaylist_bloc.dart';
import '../../../../Blocs/Musicbloc/playlist_Bloc/playlist_bloc.dart';
import '../../../../CustomWidgets/CustomTextFormField.dart';
import '../../Favpage/localfavsongpage.dart';
import '../playlistsongscreen/playlistsongspage.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({
    super.key,
    required this.size,
    required TextEditingController controller,
  }) : _controller = controller;

  final Size size;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                            controller: _controller,
                            ContentType: "Playlist Name",
                            obscureText: false,
                            prefixicon: Icons.playlist_add),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                    child: Textutil(
                                        text: 'Cancel',
                                        fontsize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<PlaylistBloc>(context).add(
                                    PlaylistEvent.createplaylist(
                                        _controller.text.trim()));
                                BlocProvider.of<PlaylistBloc>(context)
                                    .add(const PlaylistEvent.getallplaylist());
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                    child: Textutil(
                                        text: 'Create',
                                        fontsize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
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
                const Textutil(
                    text: 'Create playlist',
                    fontsize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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
              child: BlocBuilder<FavoriteplaylistBloc, FavoriteplaylistState>(
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.1)),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Textutil(
                                  text: 'My Favorites',
                                  fontsize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: QueryArtworkWidget(
                                  artworkHeight: 60,
                                  artworkWidth: 60,
                                  artworkBorder: BorderRadius.circular(10),
                                  id: int.parse(songs[0]['id']),
                                  type: ArtworkType.AUDIO),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Textutil(
                                text: 'My Favorites',
                                fontsize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)
                          ],
                        );
                      },
                      orElse: () => Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.1)),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Textutil(
                                  text: 'My Favorites',
                                  fontsize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      Playlistsongspage.playlistsongpage,
                                      arguments: playlists[index]['title']);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white.withOpacity(0.1)),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Textutil(
                                              text: playlists[index]['title'],
                                              fontsize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal)
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton(
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                      itemBuilder: (BuildContext contex) {
                                        return [
                                          PopupMenuItem(
                                              onTap: () {
                                                BlocProvider.of<PlaylistBloc>(
                                                        context)
                                                    .add(PlaylistEvent
                                                        .removePlaylist(
                                                            playlists[index]
                                                                ['id'],
                                                            playlists[index]
                                                                ['title']));
                                                BlocProvider.of<PlaylistBloc>(
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
    );
  }
}
