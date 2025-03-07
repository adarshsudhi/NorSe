import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norse/features/Presentation/CustomWidgets/nullmusicWidget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../Blocs/Musicbloc/LocalSongs_bloc/localsong_bloc.dart';
import '../SongDetailsPage/SongDetailsPage.dart';
import '../albumsongscreen/albumsongspage.dart';

class AlbumWidget extends StatefulWidget {
  final int count;
  const AlbumWidget({
    super.key,
    required this.count,
  });

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: BlocBuilder<LocalsongBloc, LocalsongState>(
          builder: (context, state) {
            return state.maybeWhen(
                songs: (songlist, albums, genre, artist, isloading, failed) {
                  return Column(
                    children: [
                      Spaces.kheight10,
                      Expanded(
                        child: ListView.builder(
                          itemCount: albums.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Albumsongspage(
                                              type: 'album',
                                              id: albums[index].id,
                                              albumname: albums[index].album)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 9),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 55,
                                        height: 54,
                                        child: QueryArtworkWidget(
                                          nullArtworkWidget:
                                              const NullMusicAlbumWidget(),
                                          id: albums[index].id,
                                          type: ArtworkType.ALBUM,
                                          keepOldArtwork: true,
                                          artworkWidth: 55,
                                          artworkHeight: 54,
                                          artworkBorder:
                                              BorderRadius.circular(9),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Textutil(
                                                text: albums[index].album,
                                                fontsize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                            Textutil(
                                                text:
                                                    "${albums[index].numOfSongs} Tracks",
                                                fontsize: 9,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.normal)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                      const Spaceadjust()
                    ],
                  );
                },
                orElse: () => const SizedBox());
          },
        ))
      ],
    );
  }
}
