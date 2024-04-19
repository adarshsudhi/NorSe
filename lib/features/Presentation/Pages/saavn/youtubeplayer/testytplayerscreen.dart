import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import '../../../Blocs/youtubeBloc/searchyt_bloc/searchyt_bloc_bloc.dart';
import '../../../Blocs/youtubeBloc/videoinfo_bloc/videoinfo_bloc.dart';
import '../musicplayerpage/testonlineplayerscreen.dart';
import '../subscreens/youtubescreen/ytdetails.dart';
import '../subscreens/youtubescreen/ytpage.dart';
import '../subscreens/ytsearchpage/ytsearchpage.dart';

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
    loadintialvid();
    super.initState();

  }

    loadintialvid() async {
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
        autoFullScreen: true,
        builder: (context, player) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                SafeArea(child: player),
                 SizedBox(
                    height: 186,
                    width: double.infinity,
                    child: Column(
                      children: [
                        MetaDataSection(youtubePlayerController: controller,),
                         Ytsearchtextformfield(
                            textEditingController: _textEditingController),
                      ],
                    )),
                Expanded(
                  child: Stack(
                    children: [
                      Buildlists(controller: controller, videos: widget.video),
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       value.metaData.title.isEmpty? Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Customshimmer(height:14, width: MediaQuery.sizeOf(context).width/1.5, radius: 30),
                             const SizedBox(height: 6,),
                             Customshimmer(height:10, width: MediaQuery.sizeOf(context).width/2, radius: 30)
                           ],
                         ):SizedBox(
                            height: 25,
                           child: Spaces.songtitle(value.metaData.title, 18,Colors.white,FontWeight.w700, context),
                         ),
                      Textutil(
                          text: value.metaData.author,
                          fontsize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                          const SizedBox(height: 3,),
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
            BlocBuilder<VideoinfoBloc, VideoinfoState>(
              builder: (context, state) {
                return state.maybeWhen(
                    info: (isloading, video) {
                      return isloading
                          ? const Metadataloading()
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
                                          PlayIcons(
                                              playicons: CupertinoIcons.stop,
                                              iconscolors: Colors.white,
                                              iconsize: 20,
                                              ontap: () async {
                                                await 
                                                   youtubePlayerController.stopVideo()
                                                    .then((value) {
                                            Navigator.pop(context);
                                        });
                                    }),
                                  ],
                                ),
                              ],
                            );
                    },
                    orElse: () => const Metadataloading());
              },
            ),
          ],
        );
      },
    );
  }
}

class Metadataloading extends StatelessWidget {
  const Metadataloading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 70,
      child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
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
                    itemBuilder:(context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Customshimmer(
                          height: size.height/4,
                          width:size.width, radius: 5),
                          const  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spaces.Kheight10,
                              Customshimmer(height: 16, width: 250, radius: 30),
                              Spaces.Kheight10,
                              Customshimmer(height: 10, width: 170, radius: 30),
                              Spaces.Kheight10,
                             ],
                          ),
                        ],
                      );
                    },),
                   searchedvideo: (videos, isloading, isfailed) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                          bottom: 20),
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
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context)
                                          .width,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Cachednetimagewidget(
                                          thumbnailSet:
                                              videos[index].thumbnails),
                                    ),
                                  ),
                                  Spaces.Kheight10,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                      padding:
                          const EdgeInsets.only(bottom: 70),
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
                                    text: vid.uploadDate != null
                                        ? "Uploaded on ${formatdatetime(vid.uploadDate!)}"
                                        : 'unknown',
                                    fontsize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                Spaces.Kheight20,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spaces.Kheight10,
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder:(context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Customshimmer(height: MediaQuery.sizeOf(context).height/4, width: MediaQuery.sizeOf(context).width,radius: 5,),
                      const  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Spaces.Kheight10,
                           Customshimmer(height: 16,width: 200,radius: 30,),
                           Spaces.Kheight10,
                           Customshimmer(height: 10,width: 150,radius: 30,),
                           Spaces.Kheight10,
                        ],
                      )
                ],
              );
            },)
          )
      ]
    );
  }
}
