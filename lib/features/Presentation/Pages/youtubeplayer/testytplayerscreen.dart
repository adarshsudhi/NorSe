import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/youtubescreen/ytpage.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Bloc/youtubeBloc/videoinfo_bloc/videoinfo_bloc.dart';
import 'package:nebula/features/Presentation/Pages/musicplayerpage/testonlineplayerscreen.dart';
import '../subscreens/youtubescreen/ytdetails.dart';


class Testytplayer extends StatefulWidget {
  static const String testytplayer = "./testytplayer";
  const Testytplayer({
    Key? key,
    required this.video,
    required this.index,
  }) : super(key: key);
  final List<Video> video;
  final int index;

  @override
  State<Testytplayer> createState() => _TestytplayerState();
}

class _TestytplayerState extends State<Testytplayer> {
  List<String> videoid = [];

  bool isswaped = false;

  int currentindex = 0;

  _getall() async {
    for (var element in widget.video) {
      videoid.add(element.id.toString());
    }
    await controller.loadPlaylist(
        list: videoid, index: widget.index, startSeconds: 0);

    await controller.setSize(double.infinity, double.infinity);
  }

  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    _getall();
  }

  clea() async {
    await controller.stopVideo();
  }

  @override
  void dispose() {
    clea();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
        autoFullScreen: false,
        builder: (context, player) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                SafeArea(child: player),
                const SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: Column(
                      children: [
                        MetaDataSection(),
                      ],
                    )),
                Expanded(
                  child: Stack(
                    children: [
                      Buildlists(controller: controller, videos: widget.video),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: YoutubeValueBuilder(
                            buildWhen: (o, n) {
                              return o.metaData != n.metaData ||
                                  o.playbackQuality != n.playbackQuality;
                            },
                            builder: (p0, p1) {
                              return Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 76, 76, 76)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    PlayIcons(
                                        playicons: CupertinoIcons.stop,
                                        iconscolors: Colors.white,
                                        iconsize: 20,
                                        ontap: () async {
                                          await controller
                                              .stopVideo()
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        }),
                                    PlayIcons(
                                        playicons:
                                            CupertinoIcons.backward_end_fill,
                                        iconscolors: Colors.white,
                                        iconsize: 20,
                                        ontap: () async {
                                          await controller.previousVideo();
                                        }),
                                    PlayIcons(
                                        playicons:
                                            CupertinoIcons.forward_end_fill,
                                        iconscolors: Colors.white,
                                        iconsize: 20,
                                        ontap: () async {
                                          await controller.nextVideo();
                                        }),
                                    PlayIcons(
                                        playicons: Icons.fullscreen,
                                        iconscolors: Colors.white,
                                        iconsize: 20,
                                        ontap: () {
                                          controller.enterFullScreen(
                                              lock: true);
                                        }),
                                  ],
                                ),
                              );
                            },
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        },
        controller: controller);
  }
}

class MetaDataSection extends StatelessWidget {
  const MetaDataSection({super.key});

  String formatLikeCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }

  String formatdatetime(DateTime dateTime) {
    String date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return YoutubeValueBuilder(
      buildWhen: (o, n) {
        if (o.metaData.videoId != n.metaData.videoId) {
          BlocProvider.of<VideoinfoBloc>(context)
              .add(VideoinfoEvent.getinfo(n.metaData.videoId));
        }

        return o.metaData != n.metaData ||
            o.playbackQuality != n.playbackQuality;
      },
      builder: (context, value) {
        return Column(
          children: [
            Spaces.Kheight10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Textutil(
                            text: value.metaData.title,
                            fontsize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        Textutil(
                            text: value.metaData.author,
                            fontsize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    dropdownColor: Colors.black,
                    value: value.playbackRate,
                    isDense: true,
                    underline: const SizedBox(),
                    items: PlaybackRate.all
                        .map(
                          (rate) => DropdownMenuItem(
                            value: rate,
                            child: Text(
                              '${rate}x',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                      onChanged: (double? newValue) {
                      if (newValue != null) {
                        context.ytController.setPlaybackRate(newValue);
                      }
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: BlocBuilder<VideoinfoBloc, VideoinfoState>(
                builder: (context, state) {
                  return state.maybeWhen(
                      info: (isloading, video) {
                        return isloading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Textutil(
                                      text:
                                          "Uploaded on ${formatdatetime(video.uploadDate!)}",
                                      fontsize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                  Row(
                                    children: [
                                      Likeicons(
                                        icon: Icons.thumb_up,
                                        text: formatLikeCount(
                                            video.engagement.likeCount!),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Likeicons(
                                        icon: Icons.visibility,
                                        text: formatLikeCount(
                                            video.engagement.viewCount),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor: Colors.black,
                                              context: context,
                                              builder: (context) {
                                                return SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Text(
                                                            video.description,
                                                            style:
                                                                Spaces.Getstyle(
                                                                    13,
                                                                    Colors
                                                                        .white,
                                                                    FontWeight
                                                                        .w600),
                                                          ))
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.more,
                                            color: Colors.white,
                                          )),
                                      PlayIcons(
                                          playicons: Icons.download,
                                          iconscolors: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          iconsize: 22,
                                          ontap: () async {
                                            return showModalBottomSheet(
                                              backgroundColor: Colors.black,
                                              context: context,
                                              builder: (context) {
                                                return Ytdetails(
                                                    id: video.id.toString());
                                              },
                                            );
                                          }),
                                    ],
                                  ),
                                ],
                              );
                      },
                      orElse: () => const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          )));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class Likeicons extends StatelessWidget {
  final String text;
  final IconData icon;
  const Likeicons({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          Textutil(
              text: text,
              fontsize: 10,
              color: Colors.black,
              fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}

class Buildlists extends StatefulWidget {
  final YoutubePlayerController controller;
  final List<Video> videos;
  const Buildlists({
    Key? key,
    required this.controller,
    required this.videos,
  }) : super(key: key);

  @override
  State<Buildlists> createState() => _BuildlistsState();
}

class _BuildlistsState extends State<Buildlists> with TickerProviderStateMixin {
  
  late List<Animation<Offset>> animations;

  late Animation<double> fadetransitionsanimations;

  late AnimationController slidercontroller;

  @override
  void initState() {
    super.initState();
    slidercontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animations = List.generate(
        widget.videos.length,
        (index) => Tween(begin: const Offset(0,1), end: Offset.zero).animate(
            CurvedAnimation(
                parent: slidercontroller,
                curve: Interval(index * (1 / widget.videos.length), 1,
                    curve: Curves.easeIn))));
    fadetransitionsanimations =
        Tween<double>(begin: 0, end: 1).animate(slidercontroller);
    slidercontroller.forward();
  }

  String formatdatetime(DateTime dateTime) {
    String date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return date;
  }

  @override
  void dispose() {
    slidercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 70),
            itemCount: widget.videos.length,
            itemBuilder: (context, index) {
              Video vid = widget.videos[index];
              return SlideTransition(
                position: animations[index],
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: InkWell(
                      splashColor: Colors.white.withOpacity(0.5),
                      onTap: () async {
                        await widget.controller.playVideoAt(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.sizeOf(context).width,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Cachednetimagewidget(
                                  thumbnailSet: vid.thumbnails),
                            ),
                            Spaces.Kheight10,
                            Textutil(
                                text: vid.title,
                                fontsize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            Textutil(
                                text: vid.author,
                                fontsize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                            Textutil(
                                text:
                                    vid.uploadDate!=null? "Uploaded on ${formatdatetime(vid.uploadDate!)}" : 'unknown',
                                fontsize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                            Spaces.Kheight20,
                          ],
                        ),
                      )),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Cachednetimagewidget extends StatelessWidget {
  const Cachednetimagewidget({
    super.key,
    required this.thumbnailSet,
  });

  final ThumbnailSet thumbnailSet;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) {
        return Thumbnailfuturebuilder(video: thumbnailSet);
      },
      imageUrl: thumbnailSet.maxResUrl,
      fit: BoxFit.cover,
    );
  }
}
