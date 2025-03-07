import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/features/Presentation/Blocs/youtubeBloc/downloadvideo_bloc/download_video_bloc.dart';
import 'package:norse/features/Presentation/Blocs/youtubeBloc/managevideo_bloc/manage_video_download_bloc.dart';
import 'package:norse/features/Presentation/CustomWidgets/bgblur.dart';
import 'package:norse/features/Presentation/CustomWidgets/custumlistviewbuilder.dart';
import 'package:norse/injection_container.dart' as di;
import '../../../../Domain/UseCases/Sql_UseCase/initializedatabase_Usecase.dart';
import '../../../Blocs/Musicbloc/Download_Bloc/download_song_bloc.dart';
import '../../../Blocs/Musicbloc/LocalData/localdata_bloc.dart';
import '../MySongPage.dart';
import 'dart:developer' as dev;

class Downloadpage extends StatefulWidget {
  static const String downloadscreen = "/downloadscreen";
  const Downloadpage({super.key});

  @override
  State<Downloadpage> createState() => _DownloadpageState();
}

class _DownloadpageState extends State<Downloadpage> {
  @override
  void initState() {
    super.initState();
    di.di<initializedbusecase>().call();
    BlocProvider.of<LocaldataBloc>(context)
        .add(const LocaldataEvent.getDownloads());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text(
            "Downloads",
            style: Spaces.Getstyle(25, Colors.white, FontWeight.bold),
          ),
        ),
        body: const DownlaodQueue());
  }
}

class DownlaodQueue extends StatelessWidget {
  const DownlaodQueue({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Material(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const BGblur(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Colors.black,
                      Colors.black.withOpacity(0.9),
                      Colors.transparent.withOpacity(0.4)
                    ])),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: SafeArea(
                child: Column(
                  children: [
                    TabBar(
                        indicatorPadding: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.white,
                        labelStyle: Spaces.Getstyle(
                            12,
                            const Color.fromARGB(255, 0, 0, 0),
                            FontWeight.bold),
                        labelColor: const Color.fromARGB(255, 255, 255, 255),
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor:
                            const Color.fromARGB(255, 69, 69, 69),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [Colors.yellow, Colors.red])),
                        tabs: const [
                          LocalAudioTitleContainer(
                            title: 'SONG',
                          ),
                          LocalAudioTitleContainer(
                            title: 'VIDEO',
                          ),
                        ]),
                    /*   SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Downloadswidget(
                        ontap: () {
                          BlocProvider.of<LocaldataBloc>(context)
                              .add(const LocaldataEvent.clearalldownloads());
                        },
                        iconData: Icons.clear_all_outlined,
                        title: "Clear Downloads",
                      ),
                    ),*/
                    const Expanded(
                      child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [SaavnAudios(), YtVideos()]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YtVideos extends StatefulWidget {
  const YtVideos({super.key});

  @override
  State<YtVideos> createState() => _YtVideosState();
}

class _YtVideosState extends State<YtVideos> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ManageVideoDownloadBloc>(context)
        .add(const ManageVideoDownloadEvent.getallvideos());
  }

   String formatBytesToMB(int bytes, {int decimals = 2}) {
   if (bytes >= 1024 * 1024 * 1024) {
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(decimals)} GB';
  } else if (bytes >= 1024 * 1024) {
    return '${(bytes / (1024 * 1024)).toStringAsFixed(decimals)} MB';
  } else if (bytes >= 1024) {
    return '${(bytes / 1024).toStringAsFixed(decimals)} KB';
  } else {
    return '$bytes Bytes';
  }
}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageVideoDownloadBloc, ManageVideoDownloadState>(
      builder: (context, state) {
        return state.maybeWhen(
            videos: (videos) {
              return videos.isEmpty
                  ? const nulldownloadswidget()
                  : ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        Map vid = videos[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Dismissible(
                              onDismissed: (direction) {
                                BlocProvider.of<ManageVideoDownloadBloc>(
                                        context)
                                    .add(ManageVideoDownloadEvent.removeVideo(
                                        vid['id']));
                              },
                              background: const bgiconfordismiss(),
                              direction: DismissDirection.endToStart,
                              key: Key(vid['id']),
                              child: BlocBuilder<DownloadVideoBloc,
                                  DownloadVideoState>(
                                builder: (context, state) {
                                  Map<String, dynamic> vi = videos[index];
                                  return state.maybeWhen(downloadstarted: (id,
                                      isloading,
                                      iscomplete,
                                      proccess,
                                      progresscontroller) {
                                    return id != vi['id']
                                        ? SizedBox(
                                            height: 60,
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      height: 50,
                                                      width: 70,
                                                      child: CachedNetworkImage(
                                                        imageUrl: videos[index]
                                                            ['imageurl'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Textutil(
                                                              text:
                                                                  videos[index]
                                                                      ['name'],
                                                              fontsize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          Row(
                                                            children: [
                                                              Textutil(
                                                                  text: videos[
                                                                          index]
                                                                      [
                                                                      'author'],
                                                                  fontsize: 10,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                              const Textutil(
                                                                  text: ' • ',
                                                                  fontsize: 13,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                             
                                                              Textutil(
                                                                  text: formatBytesToMB(
                                                                      int.parse(
                                                                          videos[index]
                                                                              [
                                                                              'size'])),
                                                                  fontsize: 10,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: 60,
                                                        width: 60,
                                                        child: IconButton(
                                                            onPressed: () {
                                                              Spaces.showtoast(
                                                                  'Please wait... Processing the previous request.');
                                                            },
                                                            icon: const Icon(
                                                              Icons.download,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ))),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        : Stack(
                                            children: [
                                              SizedBox(
                                                  height: 60,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                                  child: StreamBuilder(
                                                    stream: progresscontroller
                                                        .stream,
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData &&
                                                          snapshot.data !=
                                                              null) {
                                                        return LinearProgressIndicator(
                                                          backgroundColor:
                                                              Colors.black,
                                                          color: Colors.red
                                                              .withOpacity(0.5),
                                                          value: snapshot.data!
                                                                  .toDouble() /
                                                              100,
                                                        );
                                                      } else {
                                                        return const SizedBox();
                                                      }
                                                    },
                                                  )),
                                              SizedBox(
                                                height: 60,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          height: 50,
                                                          width: 70,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: videos[
                                                                    index]
                                                                ['imageurl'],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Textutil(
                                                                  text: videos[
                                                                          index]
                                                                      ['name'],
                                                                  fontsize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                              Row(
                                                                children: [
                                                                  Textutil(
                                                                      text:
                                                                          proccess,
                                                                      fontsize:
                                                                          10,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: 60,
                                                            width: 60,
                                                            child: isloading
                                                                ? const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 10,
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            10),
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                          strokeWidth:
                                                                              5,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : StreamBuilder(
                                                                    stream: progresscontroller
                                                                        .stream,
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                              .hasData &&
                                                                          snapshot.data !=
                                                                              null) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              10),
                                                                          child:
                                                                              Stack(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            children: [
                                                                              CircularProgressIndicator(
                                                                                color: Colors.red,
                                                                                value: snapshot.data!.toDouble() / 100,
                                                                                strokeWidth: 5,
                                                                              ),
                                                                              Textutil(text: "${snapshot.data.toString()} %", fontsize: 7, color: Colors.white, fontWeight: FontWeight.normal)
                                                                            ],
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return IconButton(
                                                                            onPressed:
                                                                                () {
                                                                               Spaces.showtoast(
                                                                                   'Please wait... Processing the previous request.');
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.download,
                                                                              size: 20,
                                                                              color: Colors.white,
                                                                            ));
                                                                      }
                                                                    },
                                                                  )),
                                                        const SizedBox(
                                                          width: 10,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                  }, orElse: () {
                                    return SizedBox(
                                      height: 60,
                                      width: MediaQuery.sizeOf(context).width,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                height: 50,
                                                width: 70,
                                                child: CachedNetworkImage(
                                                  imageUrl: videos[index]
                                                      ['imageurl'],
                                                  fit: BoxFit.cover,
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
                                                        text: videos[index]
                                                            ['name'],
                                                        fontsize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    Row(
                                                      children: [
                                                        Textutil(
                                                            text: videos[index]
                                                                ['author'],
                                                            fontsize: 10,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        const Textutil(
                                                            text: ' • ',
                                                            fontsize: 13,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        Textutil(
                                                            text: formatBytesToMB(
                                                                int.parse(
                                                                    videos[index]
                                                                        [
                                                                        'size'])),
                                                            fontsize: 10,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Map vid = videos[index];
                                                      dev.log(vid.toString());
                                                      BlocProvider.of<
                                                                  DownloadVideoBloc>(
                                                              context)
                                                          .add(DownloadVideoEvent
                                                              .downloadvideo(
                                                               vid['videourl'],
                                                        vid['id'],"null",
                                                        double.parse(
                                                            vid['size']),
                                                        vid['author'],
                                                        vid['name'],
                                                      )); 
                                                    },
                                                    icon: const Icon(
                                                      Icons.download,
                                                      size: 20,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  });
                                },
                              )),
                        );

                        /*
                  BlocBuilder<DownloadVideoBloc, DownloadVideoState>(
                    builder: (context, state) {
                      Map<String, dynamic> vi = videos[index];
                      return state.maybeWhen(downloadstarted: (id,
                          processing,
                          iscomplete,
                          ismerging,
                          currentprocess,
                          progresscontroller) {
                        return id != vi['id']
                            ? SizedBox(
                                height: 60,
                                width: MediaQuery.sizeOf(context).width,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 50,
                                          width: 70,
                                          child: CachedNetworkImage(
                                            imageUrl: videos[index]['imageurl'],
                                            fit: BoxFit.cover,
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
                                                  text: videos[index]['name'],
                                                  fontsize: 14,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              Row(
                                                children: [
                                                  Textutil(
                                                      text: videos[index]
                                                          ['author'],
                                                      fontsize: 10,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  const Textutil(
                                                      text: ' • ',
                                                      fontsize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  Textutil(
                                                      text: videos[index]
                                                          ['qualitylebal'],
                                                      fontsize: 10,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  const Textutil(
                                                      text: ' • ',
                                                      fontsize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  Textutil(
                                                      text: convertMegabytes(
                                                          double.parse(
                                                              videos[index]
                                                                  ['size'])),
                                                      fontsize: 10,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: IconButton(
                                                onPressed: () {
                                                  Spaces.showtoast(
                                                      'Please wait... Processing the previous request.');
                                                },
                                                icon: const Icon(
                                                  Icons.download,
                                                  size: 20,
                                                  color: Colors.white,
                                                ))),
                                        const SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : Stack(
                                children: [
                                  SizedBox(
                                      height: 60,
                                      width: MediaQuery.sizeOf(context).width,
                                      child: StreamBuilder(
                                        stream: progresscontroller.stream,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            return LinearProgressIndicator(
                                              backgroundColor: Colors.black,
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              value: snapshot.data!.toDouble() /
                                                  100,
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                      )),
                                  SizedBox(
                                    height: 60,
                                    width: MediaQuery.sizeOf(context).width,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              height: 50,
                                              width: 70,
                                              child: CachedNetworkImage(
                                                imageUrl: videos[index]
                                                    ['imageurl'],
                                                fit: BoxFit.cover,
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
                                                      text: videos[index]
                                                          ['name'],
                                                      fontsize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  Row(
                                                    children: [
                                                      Textutil(
                                                          text: currentprocess,
                                                          fontsize: 10,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ismerging && iscomplete
                                                ? SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          // Spaces.showtoast(
                                                          //     'Please wait... Processing the previous request.');
                                                        },
                                                        icon: const Icon(
                                                          Icons.done,
                                                          size: 20,
                                                          color: Colors.white,
                                                        )))
                                                : SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: ismerging
                                                        ? const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    left: 10,
                                                                    bottom: 10),
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,
                                                                  strokeWidth:
                                                                      5,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : StreamBuilder(
                                                            stream:
                                                                progresscontroller
                                                                    .stream,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .hasData &&
                                                                  snapshot.data !=
                                                                      null) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      CircularProgressIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                        value: snapshot.data!.toDouble() /
                                                                            100,
                                                                        strokeWidth:
                                                                            5,
                                                                      ),
                                                                      Textutil(
                                                                          text:
                                                                              "${snapshot.data.toString()} %",
                                                                          fontsize:
                                                                              7,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.normal)
                                                                    ],
                                                                  ),
                                                                );
                                                              } else {
                                                                return IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      // Spaces.showtoast(
                                                                      //     'Please wait... Processing the previous request.');
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .download,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .white,
                                                                    ));
                                                              }
                                                            },
                                                          )),
                                            const SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                      }, orElse: () {
                        return SizedBox(
                          height: 60,
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 50,
                                    width: 70,
                                    child: CachedNetworkImage(
                                      imageUrl: videos[index]['imageurl'],
                                      fit: BoxFit.cover,
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
                                            text: videos[index]['name'],
                                            fontsize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                        Row(
                                          children: [
                                            Textutil(
                                                text: videos[index]['author'],
                                                fontsize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                            const Textutil(
                                                text: ' • ',
                                                fontsize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                            Textutil(
                                                text: videos[index]
                                                    ['qualitylebal'],
                                                fontsize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                            const Textutil(
                                                text: ' • ',
                                                fontsize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                            Textutil(
                                                text: convertMegabytes(
                                                    double.parse(
                                                        videos[index]['size'])),
                                                fontsize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: IconButton(
                                        onPressed: () {
                                          Map vid = videos[index];
                                          BlocProvider.of<DownloadVideoBloc>(
                                                  context)
                                              .add(DownloadVideoEvent
                                                  .downloadvideo(
                                            vid['id'],
                                            vid['qualitylebal'],
                                            double.parse(vid['size']),
                                            vid['author'],
                                            vid['name'],
                                          ));
                                        },
                                        icon: const Icon(
                                          Icons.download,
                                          size: 20,
                                          color: Colors.white,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                    },
                  );
                   */
                      },
                    );
            },
            orElse: () => const SizedBox());
      },
    );
  }
}

class SaavnAudios extends StatelessWidget {
  const SaavnAudios({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaldataBloc, LocaldataState>(
        builder: (context, state) {
      return state.maybeWhen(
        orElse: () {
          return const nulldownloadswidget();
        },
        querys: (isloading, fail, downloads) {
          if (downloads.isNotEmpty) {
            return CustomListViewBuilderwidget(
                length: downloads.length,
                widget: (context, index) {
                  final data = downloads[index];
                  return Tilesitems(
                    data: data,
                    index: index,
                    songs: downloads,
                  );
                },
                physics:
                    const BouncingScrollPhysics()); 
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150, child: Image.asset('assets/folder.png')),
                Textutil(
                    text: 'No files in the downloads queue',
                    fontsize: 18,
                    color: Colors.white.withOpacity( 0.5),
                    fontWeight: FontWeight.normal)
              ],
            );
          }
        },
      );
    });
  }
}

class nulldownloadswidget extends StatelessWidget {
  const nulldownloadswidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 150, child: Image.asset('assets/folder.png')),
        Text(
          'Downloads empty',
          style: Spaces.Getstyle(15, Colors.white.withOpacity(0.5), FontWeight.bold),
        )
      ],
    );
  }
}

class Tilesitems extends StatefulWidget {
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> songs;
  final int index;
  const Tilesitems({
    Key? key,
    required this.data,
    required this.songs,
    required this.index,
  }) : super(key: key);

  @override
  State<Tilesitems> createState() => _YilesitemsState();
}

class _YilesitemsState extends State<Tilesitems> {
  _downloaddata() async {
    BlocProvider.of<DownloadSongBloc>(context).add(DownloadStated(
        itemstreamindex: widget.index,
        key: widget.data['id'],
        url: widget.data['downloadurl'],
        albumname: widget.data['albumname'],
        songname: widget.data['title'],
        artworkurl: widget.data['imageurl'],
        artists: widget.data['artist'],
        context: context));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        onDismissed: (direction) {
          BlocProvider.of<LocaldataBloc>(context)
              .add(LocaldataEvent.removefromdownloads(widget.data['id']));
        },
        background: const bgiconfordismiss(),
        direction: DismissDirection.endToStart,
        key: Key(widget.data['key'].toString()),
        child: ListTile(
          trailing: BlocBuilder<DownloadSongBloc, DownloadSongState>(
            builder: (context, state) {
              if (state is DownloadSongStarted) {
                ////    log((state.streams.firstWhere((element) =>
                //           element['id'] == widget.data['id'])['loading'] as bool)
                //       .toString());
                return state.streams.isEmpty
                    ? IconButton(
                        onPressed: () {
                          _downloaddata();
                        },
                        icon: const Icon(
                          Icons.download,
                          color: Colors.white,
                          size: 20,
                        ))
                    : SizedBox(
                        height: 50,
                        width: 50,
                        child: state.streams.any(
                                (element) => element['id'] == widget.data['id'])
                            ? (state.streams.firstWhere((element) =>
                                        element['id'] ==
                                        widget.data['id'])['id']) ==
                                    widget.data['id']
                                ? StreamBuilder(
                                    stream: (state.streams.firstWhere(
                                                (element) =>
                                                    element['id'] ==
                                                    widget.data['id'])['stream']
                                            as StreamController<double>)
                                        .stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        return snapshot.connectionState ==
                                                    ConnectionState.waiting ||
                                                snapshot.connectionState ==
                                                    ConnectionState.none
                                            ? const SizedBox(
                                                height: 40,
                                                width: 40,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ))
                                            : Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  CircularProgressIndicator(
                                                    value: snapshot.data! / 100,
                                                    color: const Color.fromARGB(
                                                        255, 255, 0, 0),
                                                    strokeWidth: 5,
                                                  ),
                                                  Text(
                                                    snapshot.data!
                                                        .toStringAsFixed(0),
                                                    style: Spaces.Getstyle(
                                                        10,
                                                        Colors.white,
                                                        FontWeight.normal),
                                                  )
                                                ],
                                              );
                                      } else {
                                        return IconButton(
                                            splashColor: Colors.white,
                                            splashRadius: 10,
                                            onPressed: () {
                                              _downloaddata();
                                            },
                                            icon: const Icon(
                                              Icons.download,
                                              color: Colors.white,
                                              size: 20,
                                            ));
                                      }
                                    },
                                  )
                                : IconButton(
                                    splashColor: Colors.white,
                                    splashRadius: 10,
                                    onPressed: () {
                                      _downloaddata();
                                    },
                                    icon: const Icon(
                                      Icons.download,
                                      color: Colors.white,
                                      size: 20,
                                    ))
                            : IconButton(
                                splashColor: Colors.white,
                                splashRadius: 10,
                                onPressed: () {
                                  _downloaddata();
                                },
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                  size: 20,
                                )));
              } else {
                return IconButton(
                    onPressed: () {
                      _downloaddata();
                    },
                    icon: const Icon(
                      Icons.download,
                      color: Colors.white,
                      size: 20,
                    ));
              }
            },
          ),
          leading: Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Image.network(widget.data['imageurl'])),
          title: Text(
            widget.data['title'],
            style: Spaces.Getstyle(15, Colors.white, FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            widget.data['artist'],
            style: Spaces.Getstyle(
                12, Colors.white.withOpacity(0.5), FontWeight.normal),
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
}

class bgiconfordismiss extends StatelessWidget {
  const bgiconfordismiss({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.delete,
            color: Colors.red,
            size: 20,
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }
}

/**
 * StreamBuilder(
                                    stream: (state.streams.firstWhere(
                                                (element) =>
                                                    element['id'] ==
                                                    widget.data['id'])['stream']
                                            as StreamController<double>)
                                        .stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        return snapshot.connectionState ==
                                                ConnectionState.waiting
                                            ? const SizedBox(
                                                height: 40,
                                                width: 40,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ))
                                            : Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  CircularProgressIndicator(
                                                    value: snapshot.data! / 100,
                                                    color: const Color.fromARGB(
                                                        255, 0, 4, 255),
                                                    strokeWidth: 5,
                                                  ),
                                                  Text(
                                                    snapshot.data!
                                                        .toStringAsFixed(0),
                                                    style: Spaces.Getstyle(
                                                        10,
                                                        Colors.white,
                                                        FontWeight.normal),
                                                  )
                                                ],
                                              );
                                      } else {
                                        return IconButton(
                                            splashColor: Colors.white,
                                            splashRadius: 10,
                                            onPressed: () {
                                              _downloaddata();
                                            },
                                            icon: const Icon(
                                              Icons.download,
                                              color: Colors.white,
                                              size: 20,
                                            ));
                                      }
                                    },
                                  )
 */

class Downloadswidget extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  final IconData iconData;
  const Downloadswidget({
    Key? key,
    required this.ontap,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: ontap,
        icon: Icon(
          iconData,
          color: Colors.white,
        ),
        label: Text(
          title,
          style: Spaces.Getstyle(10, Colors.white, FontWeight.normal),
        ));
  }
}
