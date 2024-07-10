import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import '../../../Blocs/youtubeBloc/searchyt_bloc/searchyt_bloc_bloc.dart';
import '../../../Blocs/youtubeBloc/videoinfo_bloc/videoinfo_bloc.dart';
import '../../../Blocs/youtubeBloc/yt_bloc/yt_bloc.dart';
import '../../saavn/musicplayerpage/testonlineplayerscreen.dart';
import '../youtubescreen/ytdetails.dart';
import '../youtubescreen/ytpage.dart';
import '../ytsearchpage/ytsearchpage.dart';

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
  late YoutubePlayerController controller;

  @override
  void initState() {
    controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    loadInitialvid();
    super.initState();
  }

  loadInitialvid() async {
    await controller.loadVideoById(
        videoId: widget.video[widget.index].id.toString());
  }

  clea() async {
    await controller.stopVideo();
  }

  final TextEditingController _textEditingController = TextEditingController();

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
            body: SafeArea(
              child: Column(
                children: [
                  player,
                  SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: Column(
                        children: [
                          MetaDataSection(
                            youtubePlayerController: controller,
                          ),
                          Ytsearchtextformfield(
                              enableFocusMode: false,
                              textEditingController: _textEditingController),
                        ],
                      )),
                  Expanded(
                    child: Stack(
                      children: [
                        Buildlists(
                            controller: controller, videos: widget.video),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        controller: controller);
  }
}

class MetaDataSection extends StatelessWidget {
  final YoutubePlayerController youtubePlayerController;
  const MetaDataSection({
    Key? key,
    required this.youtubePlayerController,
  }) : super(key: key);

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
      controller: youtubePlayerController,
      buildWhen: (o, n) {
        if (o.metaData.videoId != n.metaData.videoId) {
          BlocProvider.of<VideoinfoBloc>(context)
              .add(VideoinfoEvent.getinfo(n.metaData.videoId));
          BlocProvider.of<YtBloc>(context)
              .add(YtEvent.getvideoinfoevent(n.metaData.videoId));
        }

        return o.metaData != n.metaData ||
            o.playbackQuality != n.playbackQuality;
      },
      builder: (context, value) {
        return Column(
          children: [
            Spaces.kheight10,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      value.metaData.title.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.indigo.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 15,
                                  width: MediaQuery.sizeOf(context).width / 1.1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.indigo.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 10,
                                  width: MediaQuery.sizeOf(context).width / 3,
                                )
                              ],
                            )
                          : Textutil(
                              text: value.metaData.title,
                              fontsize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                      Textutil(
                          text: value.metaData.author,
                          fontsize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            BlocBuilder<VideoinfoBloc, VideoinfoState>(
              builder: (context, state) {
                return state.maybeWhen(
                    info: (isloading, video) {
                      return isloading
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Likeicons(
                                      icon: Icons.thumb_up,
                                      text: "0.0 likes",
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Likeicons(
                                      icon: Icons.visibility,
                                      text: "0.0 views",
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          size: 20,
                                          Icons.more,
                                          color: Colors.white,
                                        )),
                                    PlayIcons(
                                        playicons: Icons.download,
                                        iconscolors: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        iconsize: 20,
                                        ontap: () async {}),
                                    PlayIcons(
                                        playicons: CupertinoIcons.stop,
                                        iconscolors: Colors.white,
                                        iconsize: 20,
                                        ontap: () async {}),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Likeicons(
                                      icon: Icons.thumb_up,
                                      text:
                                          "${formatLikeCount(video.engagement.likeCount!)} likes",
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Likeicons(
                                      icon: Icons.visibility,
                                      text:
                                          "${formatLikeCount(video.engagement.viewCount)} views",
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.zero),
                                            backgroundColor: Colors.black,
                                            context: context,
                                            builder: (context) {
                                              return SingleChildScrollView(
                                                child: SafeArea(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Text(
                                                            video.description,
                                                            style:
                                                                Spaces.Getstyle(
                                                                    12,
                                                                    Colors
                                                                        .white,
                                                                    FontWeight
                                                                        .w600),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          size: 20,
                                          Icons.more,
                                          color: Colors.white,
                                        )),
                                    PlayIcons(
                                        playicons: Icons.download,
                                        iconscolors: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        iconsize: 20,
                                        ontap: () async {
                                          return showModalBottomSheet(
                                            backgroundColor: Colors.black,
                                            context: context,
                                            builder: (context) {
                                              return const Ytdetails();
                                            },
                                          );
                                        }),
                                    PlayIcons(
                                        playicons: CupertinoIcons.stop,
                                        iconscolors: Colors.white,
                                        iconsize: 20,
                                        ontap: () async {
                                          await youtubePlayerController
                                              .stopVideo()
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        }),
                                  ],
                                ),
                              ],
                            );
                    },
                    orElse: () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Likeicons(
                                  icon: Icons.thumb_up,
                                  text: '0.0 likes',
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Likeicons(
                                  icon: Icons.visibility,
                                  text: '0.0 views',
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      size: 20,
                                      Icons.more,
                                      color: Colors.white,
                                    )),
                                PlayIcons(
                                    playicons: Icons.download,
                                    iconscolors:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    iconsize: 20,
                                    ontap: () async {}),
                                PlayIcons(
                                    playicons: CupertinoIcons.stop,
                                    iconscolors: Colors.white,
                                    iconsize: 20,
                                    ontap: () async {
                                      await youtubePlayerController
                                          .stopVideo()
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ));
              },
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
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      height: 25,
      width: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 22,
            color: Colors.black,
          ),
          const SizedBox(
            width: 3,
          ),
          Textutil(
              text: text,
              fontsize: 10,
              color: Colors.black,
              fontWeight: FontWeight.bold)
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
  String formatdatetime(DateTime dateTime) {
    String date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return date;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        BlocBuilder<SearchytBlocBloc, SearchytBlocState>(
          builder: (context, state) {
            return state.maybeWhen(
                loader: () => ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Customshimmer(
                                height: size.height / 4,
                                width: size.width,
                                radius: 5),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spaces.kheight10,
                                Customshimmer(
                                    height: 16, width: 250, radius: 30),
                                Spaces.kheight10,
                                Customshimmer(
                                    height: 10, width: 170, radius: 30),
                                Spaces.kheight10,
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                searchedvideo: (videos, isloading, isfailed) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await widget.controller.stopVideo();
                          await widget.controller.loadVideoById(
                              videoId: videos[index].id.toString());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: SizedBox(
                            height: 270,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Cachednetimagewidget(
                                        thumbnailSet: videos[index].thumbnails),
                                  ),
                                ),
                                Spaces.kheight10,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Textutil(
                                          text: videos[index].title,
                                          fontsize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      Textutil(
                                          text: videos[index].author,
                                          fontsize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                orElse: () {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 70),
                    itemCount: widget.videos.length,
                    itemBuilder: (context, index) {
                      Video vid = widget.videos[index];
                      return InkWell(
                          splashColor: Colors.white.withOpacity(0.5),
                          onTap: () async {
                            await widget.controller.stopVideo();
                            await widget.controller.loadVideoById(
                                videoId: widget.videos[index].id.toString());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 220,
                                width: MediaQuery.sizeOf(context).width,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Cachednetimagewidget(
                                    thumbnailSet: vid.thumbnails),
                              ),
                              Spaces.kheight10,
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
                                  text: vid.uploadDate != null
                                      ? "Uploaded on ${formatdatetime(vid.uploadDate!)}"
                                      : 'unknown',
                                  fontsize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              Spaces.kheight20,
                            ],
                          ));
                    },
                  );
                });
          },
        ),
      ],
    );
  }
}

class Customshimmer extends StatelessWidget {
  const Customshimmer({
    Key? key,
    required this.height,
    required this.width,
    required this.radius,
  }) : super(key: key);
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: const Duration(seconds: 2),
        baseColor: const Color.fromARGB(255, 18, 41, 61),
        highlightColor: const Color.fromARGB(255, 2, 38, 68).withOpacity(0.5),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 3, 33, 57),
            borderRadius: BorderRadius.circular(radius),
          ),
        ));
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

class Ytloadingshimmer extends StatelessWidget {
  const Ytloadingshimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Spaces.kheight10,
      Expanded(
          child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Customshimmer(
                height: MediaQuery.sizeOf(context).height / 4,
                width: MediaQuery.sizeOf(context).width,
                radius: 5,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spaces.kheight10,
                  Customshimmer(
                    height: 16,
                    width: 200,
                    radius: 30,
                  ),
                  Spaces.kheight10,
                  Customshimmer(
                    height: 10,
                    width: 150,
                    radius: 30,
                  ),
                  Spaces.kheight10,
                ],
              )
            ],
          );
        },
      ))
    ]);
  }
}
