// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/features/Presentation/pages/saavn/subscreens/SongDetailsPage/SongDetailsPage.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../CustomWidgets/nullmusicWidget.dart';
import '../albumsongscreen/albumsongspage.dart';

class ArtistWiseSongWidget extends StatelessWidget {
  const ArtistWiseSongWidget({
    super.key,
    required this.artistmodel,
  });
  final List<ArtistModel> artistmodel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Spaces.kheight10,
        artistmodel.isEmpty
            ? const SizedBox()
            : Expanded(
                child: ListView.builder(
                  itemCount: artistmodel.length,
                  itemBuilder: (context, index) {
                    ArtistModel data = artistmodel[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Albumsongspage(
                                    type: 'artist',
                                    id: data.id,
                                    albumname: data.artist)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 5),
                        child: SizedBox(
                          height: 60,
                          width: size.width,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 55,
                                width: 54,
                                child: QueryArtworkWidget(
                                  keepOldArtwork: true,
                                  nullArtworkWidget:
                                      const NullMusicAlbumWidget(),
                                  id: data.id,
                                  type: ArtworkType.ARTIST,
                                  artworkFit: BoxFit.cover,
                                  artworkWidth: 55,
                                  artworkHeight: 54,
                                  artworkBorder: BorderRadius.circular(7),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Textutil(
                                        text: data.artist,
                                        fontsize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    Textutil(
                                        text:
                                            "${data.numberOfTracks ?? 0.toString()} Tracks",
                                        fontsize: 10,
                                        color: Colors.white.withOpacity(0.5),
                                        fontWeight: FontWeight.normal),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
        const Spaceadjust(),
      ],
    );
  }
}
