// ignore_for_file: public_member_api_docs, sort_constructors_firs
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import '../../../Blocs/youtubeBloc/ytsearch_bloc/ytsearch_bloc.dart';
import '../youtubeplayer/testytplayerscreen.dart';
import '../../saavn/subscreens/SongDetailsPage/SongDetailsPage.dart';
import '../youtube_playlistpage.dart';

class Youtubepage extends StatefulWidget {
  const Youtubepage({super.key});

  @override
  State<Youtubepage> createState() => _YoutubepageState();
}

class _YoutubepageState extends State<Youtubepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Column(
        children: [
          Spaces.kheight10,
          Expanded(
            child: SafeArea(
              child: BlocBuilder<YtsearchBloc, YtsearchState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    fres: (videos, vidoes1, videos2, videos3, isloading,
                        isfailed) {
                      return ListView(
                        children: [
                          Spaces.kheight10,
                          CarouselSlider(
                              options: CarouselOptions(
                                height: 200.0,
                                viewportFraction: 1,
                                autoPlayInterval: const Duration(seconds: 5),
                                autoPlay: true,
                              ),
                              items: List.generate(
                                videos.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Testytplayer.testytplayer,
                                        arguments: Testytplayer(
                                            video: videos, index: index));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: CachedNetworkImage(
                                      errorWidget: (context, url, error) {
                                        return const Center(
                                            child: Icon(
                                          Icons.music_note,
                                          color: Colors.white,
                                        ));
                                      },
                                      imageUrl:
                                          videos[index].thumbnails.maxResUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )),
                          Spaces.kheight10,
                          SizedBox(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                padding: const EdgeInsets.only(left: 19),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  YtplaylistWidget(
                                    ontap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Youtubeplaylistpage
                                              .youtubeplaylistpage,
                                          arguments: Youtubeplaylistpage(
                                              songs: videos2,
                                              title: "Top 100 party songs"));
                                    },
                                    video: videos2,
                                    title: "Top 100 party songs",
                                    subtitle: 'YOUTUBE',
                                  ),
                                  YtplaylistWidget(
                                    ontap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Youtubeplaylistpage
                                              .youtubeplaylistpage,
                                          arguments: Youtubeplaylistpage(
                                              songs: vidoes1,
                                              title:
                                                  "All time best bollywood songs"));
                                    },
                                    video: vidoes1,
                                    title: "All time best bollywood songs",
                                    subtitle: 'YOUTUBE',
                                  ),
                                ],
                              )),
                          YtplaylistWidget(
                            ontap: () {
                              Navigator.pushNamed(context,
                                  Youtubeplaylistpage.youtubeplaylistpage,
                                  arguments: Youtubeplaylistpage(
                                      songs: videos3,
                                      title: "Top 100 Indian Music 2024-2025"));
                            },
                            video: videos3,
                            title: "Top 100 Indian Music 2024-2025",
                            subtitle: 'YOUTUBE',
                          ),
                        ],
                      );
                    },
                    loader: () => const Syncaudiolaoding(),
                    orElse: () => const Syncaudiolaoding(),
                  );
                },
              ),
            ),
          ),
          const Spaceadjust()
        ],
      ),
    );
  }
}

class Syncaudiolaoding extends StatelessWidget {
  const Syncaudiolaoding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          Spaces.kheight20,
          Textutil(
            text: 'Synchronizing audio stream',
            fontsize: 16,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
          Spaces.kheight10,
          Textutil(
            text: 'please wait ...',
            fontsize: 16,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          )
        ],
      ),
    );
  }
}

class YtplaylistWidget extends StatelessWidget {
  final List<Video> video;
  final String title;
  final VoidCallback ontap;
  final String subtitle;
  const YtplaylistWidget({
    Key? key,
    required this.video,
    required this.title,
    required this.ontap,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width / 1.1,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    errorListener: (value) async {},
                    errorWidget: (context, url, error) {
                      return Thumbnailfuturebuilder(video: video[0].thumbnails);
                    },
                    imageUrl: video[0].thumbnails.maxResUrl,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 150,
                      color: Colors.black.withOpacity(0.8),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Textutil(
                                text: "${video.length}",
                                fontsize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                            const SizedBox(
                              height: 3,
                            ),
                            const Icon(
                              Icons.playlist_play,
                              color: Colors.white,
                              size: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Textutil(
              text: title,
              fontsize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          Textutil(
              text: subtitle,
              fontsize: 8,
              color: Colors.white,
              fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}

class Thumbnailfuturebuilder extends StatelessWidget {
  const Thumbnailfuturebuilder({
    super.key,
    required this.video,
  });

  final ThumbnailSet video;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: gethumbnail(video),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
              period: const Duration(seconds: 2),
              baseColor: const Color.fromARGB(255, 18, 41, 61),
              highlightColor:
                  const Color.fromARGB(255, 2, 38, 68).withOpacity(0.5),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 3, 33, 57),
                  borderRadius: BorderRadius.circular(6),
                ),
              ));
        } else if (snapshot.hasError) {
          return Text('Error fetching thumbnail: ${snapshot.error}');
        } else {
          return CachedNetworkImage(imageUrl: snapshot.data as String);
        }
      },
    );
  }
}

gethumbnail(ThumbnailSet thumbnailSet) async {
  String url = await Spaces().Gethumbnail(thumbnailSet);
  return url;
}
