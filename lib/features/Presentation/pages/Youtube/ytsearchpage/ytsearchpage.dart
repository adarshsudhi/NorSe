import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/features/Presentation/CustomWidgets/custumlistviewbuilder.dart';
import 'package:norse/features/Presentation/pages/Youtube/youtubeplayer/testytplayerscreen.dart';
import '../../../../../configs/notifier/notifiers.dart';
import '../../../Blocs/youtubeBloc/searchyt_bloc/searchyt_bloc_bloc.dart';
import '../../../Blocs/youtubeBloc/youtubeplayer_bloc/youtubeplayer_bloc.dart';
import '../../../Blocs/youtubeBloc/ytrelatedvideos_bloc/ytrelatedvideos_bloc.dart';
import '../../saavn/musicplayerpage/testonlineplayerscreen.dart';

class Ytsearchpage extends StatelessWidget {
  static const String ytsearchpage = "./searchpagescreen";
  Ytsearchpage({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  String formatdatetime(DateTime dateTime) {
    String date = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                PlayIcons(
                    playicons: Icons.arrow_back_ios,
                    iconscolors: Colors.white,
                    iconsize: 17,
                    ontap: () {
                      Navigator.pop(context);
                    }),
                Expanded(
                  child: Ytsearchtextformfield(
                      enableFocusMode: true,
                      textEditingController: _textEditingController),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<SearchytBlocBloc, SearchytBlocState>(
                builder: (context, state) {
                  return state.maybeWhen(
                      loader: () => const Ytloadingshimmer(),
                      searchedvideo: (videos, isloading, isfailed) {
                        return isloading != true
                            ? Column(
                                children: [
                                  Spaces.kheight20,
                                  Expanded(
                                      child: CustomListViewBuilderwidget(
                                          length: videos.length,
                                          widget: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Notifiers.showplayer.value =
                                                    false;
                                                BlocProvider.of<
                                                            YtrelatedvideosBloc>(
                                                        context)
                                                    .add(YtrelatedvideosEvent
                                                        .relatedvideos(
                                                            videos[index]
                                                                .id
                                                                .toString()));
                                                BlocProvider.of<
                                                            YoutubeplayerBloc>(
                                                        context)
                                                    .add(YoutubeplayerEvent
                                                        .ytplayerevent(
                                                            videos, index));
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                      context)
                                                                  .width,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Cachednetimagewidget(
                                                              thumbnailSet:
                                                                  videos[index]
                                                                      .thumbnails),
                                                        ),
                                                      ),
                                                      Spaces.kheight20,
                                                      Textutil(
                                                          text: videos[index]
                                                              .title,
                                                          fontsize: 17,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                      Textutil(
                                                          text: videos[index]
                                                              .author,
                                                          fontsize: 13,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      Textutil(
                                                          text: videos[index]
                                                                      .uploadDate !=
                                                                  null
                                                              ? formatdatetime(
                                                                  videos[index]
                                                                      .uploadDate!)
                                                              : 'unknown',
                                                          fontsize: 12,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          physics:
                                              const BouncingScrollPhysics()) /* ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      itemCount: videos.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Notifiers.showplayer.value = false;
                                            BlocProvider.of<
                                                        YtrelatedvideosBloc>(
                                                    context)
                                                .add(YtrelatedvideosEvent
                                                    .relatedvideos(videos[index]
                                                        .id
                                                        .toString()));
                                            BlocProvider.of<YoutubeplayerBloc>(
                                                    context)
                                                .add(YoutubeplayerEvent
                                                    .ytplayerevent(
                                                        videos, index));
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
                                                      width: MediaQuery.sizeOf(
                                                              context)
                                                          .width,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Cachednetimagewidget(
                                                          thumbnailSet:
                                                              videos[index]
                                                                  .thumbnails),
                                                    ),
                                                  ),
                                                  Spaces.kheight20,
                                                  Textutil(
                                                      text: videos[index].title,
                                                      fontsize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  Textutil(
                                                      text:
                                                          videos[index].author,
                                                      fontsize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  Textutil(
                                                      text: videos[index]
                                                                  .uploadDate !=
                                                              null
                                                          ? formatdatetime(
                                                              videos[index]
                                                                  .uploadDate!)
                                                          : 'unknown',
                                                      fontsize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ), */
                                      ),
                                ],
                              )
                            : const SizedBox();
                      },
                      orElse: () {
                        return SizedBox.expand(
                          child: Center(
                            child: Image.asset(
                              'assets/yt.png',
                              scale: 4,
                            ),
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Ytsearchtextformfield extends StatefulWidget {
  const Ytsearchtextformfield({
    super.key,
    required TextEditingController textEditingController,
    required this.enableFocusMode,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final bool enableFocusMode;

  @override
  State<Ytsearchtextformfield> createState() => _YtsearchtextformfieldState();
}

class _YtsearchtextformfieldState extends State<Ytsearchtextformfield> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.enableFocusMode ? focusNode.requestFocus() : null;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: TextFormField(
        focusNode: focusNode,
        controller: widget._textEditingController,
        cursorColor: Colors.black,
        style: Spaces.Getstyle(15, Colors.black, FontWeight.normal),
        onFieldSubmitted: (value) {
          BlocProvider.of<SearchytBlocBloc>(context)
              .add(SearchytBlocEvent.getsearchdetails(value));
        },
        decoration: InputDecoration(
            prefixIcon: Image.asset(
              'assets/yt.png',
              scale: 18,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 10),
            hintText: 'YouTube',
            hintStyle: Spaces.Getstyle(13, Colors.grey, FontWeight.normal)),
      ),
    );
  }
}
