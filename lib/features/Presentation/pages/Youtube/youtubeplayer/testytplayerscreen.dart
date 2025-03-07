import 'package:cached_network_image/cached_network_image.dart';
import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:norse/injection_container.dart' as di;
import 'package:norse/configs/notifier/notifiers.dart';
import 'package:norse/features/Presentation/Blocs/youtubeBloc/youtubeplayer_bloc/youtubeplayer_bloc.dart';
import 'package:norse/features/Presentation/Blocs/youtubeBloc/ytrelatedvideos_bloc/ytrelatedvideos_bloc.dart';
import 'package:norse/features/Presentation/CustomWidgets/custumlistviewbuilder.dart';
import 'package:norse/features/Presentation/pages/Youtube/youtubescreen/ytdownloadoptionspage.dart';

import '../../../../../configs/constants/Spaces.dart';
import '../../../../Domain/UseCases/yt_usecase/getvideoinfo_usecase.dart';
import '../youtubescreen/ytpage.dart';

bool isfloating = false;
bool isready = false;

late YoutubePlayerController controller;

class Testytplayer extends StatefulWidget {
  static const String testytplayer = "./testytplayer";

  const Testytplayer({
    Key? key,
    required this.video,
    required this.index,
    required this.height,
    required this.persentage,
    required this.context,
  }) : super(key: key);

  final List<Video> video;

  final int index;

  final double height;

  final double persentage;

  final BuildContext context;

  @override
  State<Testytplayer> createState() => _TestytplayerState();
}

class _TestytplayerState extends State<Testytplayer> {
  String channelid = '';
  String channeltitle = '';
  String logourl = '';
  String bannerurl = '';

  @override
  void initState() {
    loadInitialvid(widget.index);

    super.initState();
  }

  loadInitialvid(int index) async {
    BlocProvider.of<YtrelatedvideosBloc>(context).add(
        YtrelatedvideosEvent.relatedvideos(
            widget.video[widget.index].id.toString()));
  }

  String formatdatetime(DateTime dateTime) {
    String date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return date;
  }

  String formatLikeCount(int count) {
    if (count >= 1000000000) {
      return '${(count / 1000000000).toStringAsFixed(1)}B';
    } else if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }

  String formatViewCount(int count) {
    if (count >= 1000000000) {
      return '${(count / 1000000000).toStringAsFixed(1)}B'; // Billions
    } else if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M'; // Millions
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K'; // Thousands
    } else {
      return count.toString();
    }
  }

  Future<Map<String, dynamic>> _getInfo(String videoid) async {
    Map<String, dynamic> infomap =
        await di.di<Getvideoinfousecase>().call(videoid);
    return infomap;
  }

  @override
  void dispose() {
    super.dispose();
    Notifiers.isytvisible.value = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Material(
          color: Spaces.backgroundColor,
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: BlocBuilder<YoutubeplayerBloc, YoutubeplayerState>(
                builder: (context, state) {
              return state.maybeWhen(
                  switchstate: () {
                    return Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                              color: Colors.black,
                              height: 60,
                              width: 100,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Spaces.baseColor,
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        const Textutil(
                            text: 'Player Busy try Again later',
                            fontsize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                        const SizedBox(),
                      ],
                    );
                  },
                  youtubeplayerstate: (info, index, vid, isloading, failed) {
                    return Column(
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               ValueListenableBuilder(
                                 valueListenable: Notifiers.ytexpandnotifer,
                                 builder: (context, value, child) {
                                   return SizedBox(
                                     height: value <= size.width
                                         ? 60
                                         : size.height / 4,
                                     width: value >= size.width
                                         ? size.width
                                         : value <= 100
                                             ? 100
                                             : value,
                                     child: YoutubePlayer(
                                       
                                       enableFullScreenOnVerticalDrag: false,
                                       controller: controller,),
                                   );
                                 },
                               ),
                               const SizedBox(
                                 width: 10,
                               ),
                               isloading
                                   ? const Column(
                                       crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                       mainAxisAlignment:
                                           MainAxisAlignment.center,
                                       children: [
                                         Customshimmer(
                                             height: 11,
                                             width: 200,
                                             radius: 20),
                                         SizedBox(height: 5),
                                         Customshimmer(
                                             height: 8,
                                             width: 100,
                                             radius: 20)
                                       ],
                                     )
                                   : ValueListenableBuilder(
                                     valueListenable: Notifiers.ytexpandnotifer,
                                   builder:(context, value, child) {
                                     return SizedBox(
                                       width:
                                           value <= size.width ? 200 : 0,
                                       child: Column(
                                         crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                         mainAxisAlignment:
                                             MainAxisAlignment.center,
                                         children: [
                                           Textutil(
                                             text:
                                                 "${(info['video'] as Video).title}  •  ",
                                             fontsize: 11,
                                             color: Spaces.textColor,
                                             fontWeight: FontWeight.bold,
                                           ),
                                           const SizedBox(height: 5),
                                           Textutil(
                                             text:
                                                 "${(info['video'] as Video).author}  •  ",
                                             fontsize: 9,
                                             color: Spaces.textColor,
                                             fontWeight: FontWeight.normal,
                                           ),
                                         ],
                                       ));
                                   },)
                             ],
                           ),
                           isloading
                               ? SizedBox(
                                   width: size.width,
                                   child: Column(
                                     crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                     mainAxisAlignment:
                                         MainAxisAlignment.center,
                                     children: [
                                       Spaces.kheigth5,
                                       Customshimmer(
                                           height: 17,
                                           width: size.width / 1.2,
                                           radius: 20),
                                       Spaces.kheigth5,
                                       SizedBox(
                                         width: size.width,
                                         child: const Row(
                                           children: [
                                             Customshimmer(
                                                 height: 10,
                                                 width: 60,
                                                 radius: 20),
                                             SizedBox(
                                               width: 5,
                                             ),
                                             Customshimmer(
                                                 height: 10,
                                                 width: 60,
                                                 radius: 20),
                                             SizedBox(
                                               width: 5,
                                             ),
                                             Customshimmer(
                                                 height: 10,
                                                 width: 60,
                                                 radius: 20),
                                             SizedBox(
                                               width: 5,
                                             ),
                                             Customshimmer(
                                                 height: 10,
                                                 width: 60,
                                                 radius: 20),
                                           ],
                                         ),
                                       ),
                                       Spaces.kheigth5,
                                     ],
                                   ),
                                 )
                               : SizedBox(
                                   width: size.width,
                                   child: Column(
                                     crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                     mainAxisAlignment:
                                         MainAxisAlignment.center,
                                     children: [
                                       Textutil(
                                         text: (info['video'] as Video).title,
                                         fontsize: 16,
                                         color: Spaces.textColor,
                                         fontWeight: FontWeight.bold,
                                       ),
                                       const SizedBox(height: 2),
                                       SizedBox(
                                         width: size.width,
                                         child: Row(
                                           children: [
                                             Textutil(
                                               text:
                                                   "${(info['video'] as Video).author}  •  ",
                                               fontsize: 10,
                                               color: Spaces.textColor,
                                               fontWeight: FontWeight.bold,
                                             ),
                                             Textutil(
                                                 text:
                                                     "${formatLikeCount(((info['video'] as Video).engagement.viewCount).toInt())} views  • ",
                                                 fontsize: 10,
                                                 color: Spaces.textColor,
                                                 fontWeight: FontWeight.bold),
                                             Textutil(
                                               text: timeago.format(
                                                   (info['video'] as Video)
                                                       .uploadDate!),
                                               fontsize: 10,
                                               color: Spaces.textColor,
                                               fontWeight: FontWeight.bold,
                                             ),
                                             GestureDetector(
                                               onTap: () {
                                                 showModalBottomSheet(
                                                   shape:
                                                       const RoundedRectangleBorder(
                                                           borderRadius:
                                                               BorderRadius
                                                                   .zero),
                                                   backgroundColor:
                                                       Spaces.backgroundColor,
                                                   context: context,
                                                   builder: (context) {
                                                     return SingleChildScrollView(
                                                       padding:
                                                           EdgeInsets.zero,
                                                       child: SafeArea(
                                                         child: Column(
                                                           children: [
                                                             Padding(
                                                                 padding:
                                                                     const EdgeInsets
                                                                         .all(
                                                                         20),
                                                                 child: Text(
                                                                   (info['video']
                                                                           as Video)
                                                                       .description,
                                                                   style: Spaces.Getstyle(
                                                                       12,
                                                                       Spaces
                                                                           .textColor,
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
                                               child: const Textutil(
                                                 text: "  ...more",
                                                 fontsize: 10,
                                                 color: Spaces.textColor,
                                                 fontWeight: FontWeight.bold,
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       Spaces.kheigth5,
                                     ],
                                   ),
                                 ),
                           
                           isloading
                               ? const LoadingMetadataContaiiners()
                               : MetaDataSection(
                                   video: info,
                                 ),
                           Spaces.kheight10,
                           Expanded(
                             child: BlocBuilder<YtrelatedvideosBloc,
                                 YtrelatedvideosState>(
                               builder: (context, state) {
                                 return state.maybeWhen(
                                     suggestion: (relatedvideo) {
                                       return RepaintBoundary(
                                           child: CustomListViewBuilderwidget(
                                         physics:
                                             const BouncingScrollPhysics(),
                                         length: relatedvideo.length,
                                         widget: (p0, index) {
                                           Video vid = relatedvideo[index];
                                           return InkWell(
                                             onTap: () {
                                               BlocProvider.of<
                                                           YtrelatedvideosBloc>(
                                                       context)
                                                   .add(YtrelatedvideosEvent
                                                       .relatedvideos(
                                                           relatedvideo[index]
                                                               .id
                                                               .toString()));
                                               BlocProvider.of<
                                                           YoutubeplayerBloc>(
                                                       context)
                                                   .add(YoutubeplayerEvent
                                                       .ytplayerevent(
                                                           relatedvideo,
                                                           index));
                                             },
                                             child: Column(
                                               crossAxisAlignment:
                                                   CrossAxisAlignment.start,
                                               children: [
                                                 Container(
                                                   height: 220,
                                                   width: MediaQuery.sizeOf(
                                                           context)
                                                       .width,
                                                   clipBehavior:
                                                       Clip.antiAlias,
                                                   decoration: BoxDecoration(
                                                     borderRadius:
                                                         BorderRadius.circular(
                                                             5),
                                                   ),
                                                   child: Cachednetimagewidget(
                                                     thumbnailSet:
                                                         vid.thumbnails,
                                                   ),
                                                 ),
                                                 Spaces.kheight10,
                                                 Textutil(
                                                   text: vid.title,
                                                   fontsize: 15,
                                                   color: Spaces.textColor,
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 Row(
                                                   children: [
                                                     Textutil(
                                                       text:
                                                           "${vid.author}  •",
                                                       fontsize: 10,
                                                       color: Spaces.textColor,
                                                       fontWeight:
                                                           FontWeight.bold,
                                                     ),
                                                     const SizedBox(width: 10),
                                                     Textutil(
                                                       text:
                                                           "${formatViewCount(vid.engagement.viewCount)} views  •",
                                                       fontsize: 10,
                                                       color: Spaces.textColor,
                                                       fontWeight:
                                                           FontWeight.bold,
                                                     ),
                                                     const SizedBox(width: 10),
                                                     Textutil(
                                                       text: timeago.format(
                                                           vid.uploadDate!),
                                                       fontsize: 10,
                                                       color: Spaces.textColor,
                                                       fontWeight:
                                                           FontWeight.bold,
                                                     ),
                                                   ],
                                                 ),
                                                 const Textutil(
                                                   text: '',
                                                   fontsize: 10,
                                                   color: Spaces.textColor,
                                                   fontWeight:
                                                       FontWeight.normal,
                                                 ),
                                                 Spaces.kheight20,
                                               ],
                                             ),
                                           );
                                         },
                                       ));
                                     },
                                     laoding: () =>
                                         CustomListViewBuilderwidget(
                                             length: 3,
                                             widget: (p0, p1) => Column(
                                                   crossAxisAlignment:
                                                       CrossAxisAlignment
                                                           .start,
                                                   children: [
                                                     Customshimmer(
                                                         height:
                                                             size.height / 4,
                                                         width: size.width,
                                                         radius: 5),
                                                     const Column(
                                                       crossAxisAlignment:
                                                           CrossAxisAlignment
                                                               .start,
                                                       children: [
                                                         Spaces.kheight10,
                                                         Customshimmer(
                                                             height: 16,
                                                             width: 250,
                                                             radius: 30),
                                                         Spaces.kheight10,
                                                         Customshimmer(
                                                             height: 10,
                                                             width: 170,
                                                             radius: 30),
                                                         Spaces.kheight10,
                                                       ],
                                                     ),
                                                   ],
                                                 ),
                                             physics:
                                                 const NeverScrollableScrollPhysics()),
                                     orElse: () => RepaintBoundary(
                                         child:
                                             ListTobe(video: widget.video)));
                               },
                             ),
                           ),
                         ],
                       );
                  },
                  orElse: () => const SizedBox());
            }),
          )),
    );
  }
}



class LoadingMetadataContaiiners extends StatelessWidget {
  const LoadingMetadataContaiiners({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Customshimmer(height: 30, width: 90, radius: 20),
        SizedBox(
          width: 5,
        ),
        Customshimmer(height: 30, width: 90, radius: 20),
        SizedBox(
          width: 5,
        ),
        Customshimmer(height: 30, width: 90, radius: 20)
      ],
    );
  }
}

class Loadingg extends StatelessWidget {
  const Loadingg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Spaces.baseColor),
    );
  }
}

class ListTobe extends StatelessWidget {
  const ListTobe({
    super.key,
    required this.video,
  });

  final List<Video> video;

  String formatViewCount(int count) {
    if (count >= 1000000000) {
      return '${(count / 1000000000).toStringAsFixed(1)}B'; // Billions
    } else if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M'; // Millions
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K'; // Thousands
    } else {
      return count.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomListViewBuilderwidget(
      physics: const BouncingScrollPhysics(),
      length: video.length,
      widget: (p0, index) {
        Video vid = video[index];
        return InkWell(
          onTap: () {
            BlocProvider.of<YtrelatedvideosBloc>(context).add(
                YtrelatedvideosEvent.relatedvideos(video[index].id.toString()));
            BlocProvider.of<YoutubeplayerBloc>(context)
                .add(YoutubeplayerEvent.ytplayerevent(video, index));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220,
                width: MediaQuery.sizeOf(context).width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Cachednetimagewidget(
                  thumbnailSet: vid.thumbnails,
                ),
              ),
              Spaces.kheight10,
              Textutil(
                text: vid.title,
                fontsize: 15,
                color: Spaces.textColor,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  Textutil(
                    text: "${vid.author}  •",
                    fontsize: 10,
                    color: Spaces.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 10),
                  Textutil(
                    text:
                        "${formatViewCount(vid.engagement.viewCount)} views  •",
                    fontsize: 10,
                    color: Spaces.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 10),
                  Textutil(
                    text: timeago.format(vid.uploadDate!),
                    fontsize: 10,
                    color: Spaces.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const Textutil(
                text: '',
                fontsize: 10,
                color: Spaces.textColor,
                fontWeight: FontWeight.normal,
              ),
              Spaces.kheight20,
            ],
          ),
        );
      },
    );
    /* ListView.builder(
        itemCount: video.length,
        itemBuilder: (context, index) {
          Video vid = video[index];
          return InkWell(
            onTap: () {
              BlocProvider.of<YtrelatedvideosBloc>(context).add(
                  YtrelatedvideosEvent.relatedvideos(
                      video[index].id.toString()));
              BlocProvider.of<YoutubeplayerBloc>(context)
                  .add(YoutubeplayerEvent.ytplayerevent(video, index));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  width: MediaQuery.sizeOf(context).width,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Cachednetimagewidget(
                    thumbnailSet: vid.thumbnails,
                  ),
                ),
                Spaces.kheight10,
                Textutil(
                  text: vid.title,
                  fontsize: 15,
                  color: Spaces.textColor,
                  fontWeight: FontWeight.bold,
                ),
                Row(
                  children: [
                    Textutil(
                      text: "${vid.author}  •",
                      fontsize: 10,
                      color: Spaces.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 10),
                    Textutil(
                      text:
                          "${formatViewCount(vid.engagement.viewCount)} views  •",
                      fontsize: 10,
                      color: Spaces.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 10),
                    Textutil(
                      text: timeago.format(vid.uploadDate!),
                      fontsize: 10,
                      color: Spaces.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const Textutil(
                  text: '',
                  fontsize: 10,
                  color: Spaces.textColor,
                  fontWeight: FontWeight.normal,
                ),
                Spaces.kheight20,
              ],
            ),
          );
        }); */

    /* CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              Video vid = video[index];

              return InkWell(
                onTap: () {
                  BlocProvider.of<YtrelatedvideosBloc>(context).add(
                      YtrelatedvideosEvent.relatedvideos(
                          video[index].id.toString()));
                  BlocProvider.of<YoutubeplayerBloc>(context)
                      .add(YoutubeplayerEvent.ytplayerevent(video, index));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      width: MediaQuery.sizeOf(context).width,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Cachednetimagewidget(
                        thumbnailSet: vid.thumbnails,
                      ),
                    ),
                    Spaces.kheight10,
                    Textutil(
                      text: vid.title,
                      fontsize: 15,
                      color: Spaces.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        Textutil(
                          text: "${vid.author}  •",
                          fontsize: 10,
                          color: Spaces.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(width: 10),
                        Textutil(
                          text:
                              "${formatViewCount(vid.engagement.viewCount)} views  •",
                          fontsize: 10,
                          color: Spaces.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(width: 10),
                        Textutil(
                          text: timeago.format(vid.uploadDate!),
                          fontsize: 10,
                          color: Spaces.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const Textutil(
                      text: '',
                      fontsize: 10,
                      color: Spaces.textColor,
                      fontWeight: FontWeight.normal,
                    ),
                    Spaces.kheight20,
                  ],
                ),
              );
            },
            childCount: video.length,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 60,
          ),
        )
      ],
    ); */
  }
}

class MetaDataSection extends StatefulWidget {
  const MetaDataSection({
    super.key,
    required this.video,
  });
  final Map video;

  @override
  State<MetaDataSection> createState() => _MetaDataSectionState();
}

class _MetaDataSectionState extends State<MetaDataSection> {
  final floating = Floating();
  String formatLikeCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Likeicons(
                  mainAxisAlignment: MainAxisAlignment.center,
                  icon: Icons.thumb_up,
                  text:
                      "${formatLikeCount((widget.video['video'] as Video).engagement.likeCount!.toInt())} likes",
                ),
                const SizedBox(
                  width: 5,
                ),
                Likeicons(
                  mainAxisAlignment: MainAxisAlignment.center,
                  icon: Icons.thumb_down,
                  text: formatLikeCount(widget.video['dislike']),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YtDownloadPagesOptions(
                            info: widget.video,
                          ),
                        ));
                  },
                  child: const Likeicons(
                    mainAxisAlignment: MainAxisAlignment.center,
                    icon: Icons.download,
                    text: 'Download',
                  ),
                ),
                
              ],
            ),
          ),
        )
      ],
    );
  }
}

class LoadingContainers extends StatelessWidget {
  const LoadingContainers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Customshimmer(height: 30, width: 90, radius: 30),
            SizedBox(
              width: 5,
            ),
            Customshimmer(height: 30, width: 90, radius: 30),
            SizedBox(
              width: 5,
            ),
            Customshimmer(height: 30, width: 90, radius: 30),
          ],
        ),
      ],
    );
  }
}

class Likeicons extends StatelessWidget {
  final String text;
  final IconData icon;
  final MainAxisAlignment mainAxisAlignment;
  const Likeicons({
    super.key,
    required this.text,
    required this.icon,
    required this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Spaces.iconColor, borderRadius: BorderRadius.circular(15)),
      height: 30,
      width: 90,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Icon(
            icon,
            size: 11,
            color: Colors.white,
          ),
          const SizedBox(
            width: 6,
          ),
          Textutil(
              text: text,
              fontsize: 8,
              color: Spaces.textColor,
              fontWeight: FontWeight.bold)
        ],
      ),
    );
  }
}

class Customshimmer extends StatelessWidget {
  const Customshimmer({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
  });
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Spaces.baseColor,
        borderRadius: BorderRadius.circular(radius),
      ),
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

class Ytloadingshimmer extends StatelessWidget {
  const Ytloadingshimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Spaces.kheight10,
      Expanded(
          child: CustomListViewBuilderwidget(
        physics: const BouncingScrollPhysics(),
        length: 7,
        widget: (p0, p1) {
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
      ) /* ListView.builder(
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
      )*/
          )
    ]);
  }
}
