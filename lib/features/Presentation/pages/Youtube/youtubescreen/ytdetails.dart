import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../Blocs/youtubeBloc/ytdownload_bloc/ytdownload_bloc.dart';
import 'ytpage.dart';

class Ytdetails extends StatefulWidget {
  const Ytdetails({
    super.key,
    required this.info,
    required this.audioOnlyStreamInfo,
    required this.videostreamInfo,
  });
  final Map info;
  final AudioOnlyStreamInfo audioOnlyStreamInfo;
  final List<VideoOnlyStreamInfo> videostreamInfo;
  @override
  State<Ytdetails> createState() => _YtdetailsState();
}

class _YtdetailsState extends State<Ytdetails> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                color: Spaces.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            height: MediaQuery.sizeOf(context).height / 2,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spaces.kheight20,
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: MediaQuery.sizeOf(context).height / 4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) {
                            return Thumbnailfuturebuilder(
                                video:
                                    (widget.info['video'] as Video).thumbnails);
                          },
                          imageUrl: (widget.info['video'] as Video)
                              .thumbnails
                              .maxResUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Spaces.kheight10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Textutil(
                              text: (widget.info['video'] as Video).title,
                              fontsize: 15,
                              color: Spaces.textColor,
                              fontWeight: FontWeight.w600),
                          Textutil(
                              text: (widget.info['video'] as Video).author,
                              fontsize: 10,
                              color: Spaces.textColor,
                              fontWeight: FontWeight.normal)
                        ],
                      ),
                      Spaces.kheight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white),
                            child: const Icon(
                              Icons.music_note,
                              color: Colors.black,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Textutil(
                              text:
                                  "Audio • ${widget.audioOnlyStreamInfo.bitrate.toString().replaceAll('it', '')} •  ${widget.audioOnlyStreamInfo.audioCodec.split('.')[0]}",
                              fontsize: 14,
                              color: Spaces.textColor,
                              fontWeight: FontWeight.normal),
                        ],
                      ),
                      Spaces.kheight20,
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Textutil(
                                                text:
                                                    "${widget.audioOnlyStreamInfo.audioCodec} • ${widget.audioOnlyStreamInfo.size}",
                                                fontsize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            Textutil(
                                                text:
                                                    "${widget.audioOnlyStreamInfo.bitrate} ",
                                                fontsize: 8,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white),
                            child: Center(child:
                                BlocBuilder<YtdownloadBloc, YtdownloadState>(
                              builder: (context, state) {
                                return state.maybeWhen(loading: () {
                                  return const CircularProgressIndicator(
                                    color: Colors.black,
                                  );
                                }, downloading: (progress) {
                                  return StreamBuilder(
                                      stream: progress.stream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Center(
                                              child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                value: snapshot.data! / 100,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                snapshot.data!
                                                    .toStringAsFixed(0),
                                                style: Spaces.Getstyle(
                                                    11,
                                                    Colors.black,
                                                    FontWeight.normal),
                                              )
                                            ],
                                          ));
                                        } else {
                                          return const SizedBox();
                                        }
                                      });
                                }, orElse: () {
                                  return IconButton(
                                      onPressed: () {
                                        //  BlocProvider.of<YtdownloadBloc>(context)
                                        //     .add(YtdownloadEvent.downloadsong(
                                        //         (widget.info['video'] as Video),
                                        //           (widget.info['video'] as Video)
                                        //              .id
                                        //              .toString()));
                                      },
                                      icon: const Icon(Icons.download));
                                });
                              },
                            )),
                          ),
                        ],
                      ),
                      Spaces.kheight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white),
                            child: const Icon(
                              CupertinoIcons.videocam,
                              color: Colors.black,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Textutil(
                              text:
                                  "Video • ${widget.videostreamInfo[selectedindex].qualityLabel} • ${widget.videostreamInfo[0].codec.subtype}",
                              fontsize: 14,
                              color: Spaces.textColor,
                              fontWeight: FontWeight.normal),
                        ],
                      ),
                      Spaces.kheight20,
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2.8,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 6,
                                crossAxisCount: 3),
                        itemCount: widget.videostreamInfo.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() => selectedindex = index);
                            },
                            child: Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectedindex == index
                                      ? const Color.fromARGB(255, 31, 29, 58)
                                      : Colors.white),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(7),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Textutil(
                                                  text:
                                                      "${widget.videostreamInfo[index].qualityLabel} • ${widget.videostreamInfo[index].size}",
                                                  fontsize: 9,
                                                  color: selectedindex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              Textutil(
                                                  text:
                                                      "Quality ${widget.videostreamInfo[index].codec.mimeType} ",
                                                  fontsize: 8,
                                                  color: selectedindex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Spaces.kheight20,
                      Container(
                        height: 90,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 31, 29, 58)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Textutil(
                                text:
                                    'Download video in ${widget.videostreamInfo[selectedindex].qualityLabel}',
                                fontsize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            Textutil(
                                text:
                                    "Size ${widget.videostreamInfo[selectedindex].size} • Quality ${widget.videostreamInfo[selectedindex].qualityLabel}",
                                fontsize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }
}
