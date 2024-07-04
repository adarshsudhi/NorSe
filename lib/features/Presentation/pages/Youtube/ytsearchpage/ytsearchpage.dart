import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/pages/Youtube/youtubeplayer/testytplayerscreen.dart';
import '../../../Blocs/youtubeBloc/searchyt_bloc/searchyt_bloc_bloc.dart';
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
                                    child: ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      itemCount: videos.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                Testytplayer.testytplayer,
                                                arguments: Testytplayer(
                                                    video: videos,
                                                    index: index));
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
                                    ),
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
                              color: Colors.white,
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
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        focusNode: focusNode,
        controller: widget._textEditingController,
        style: Spaces.Getstyle(15, Colors.black, FontWeight.normal),
        onFieldSubmitted: (value) {
          BlocProvider.of<SearchytBlocBloc>(context)
              .add(SearchytBlocEvent.getsearchdetails(value));
        },
        decoration: InputDecoration(
            prefixIcon: Image.asset(
              'assets/yt.png',
              scale: 19,
            ),
            border: InputBorder.none,
            hintText: 'Search on Youtube',
            hintStyle: Spaces.Getstyle(15, Colors.grey, FontWeight.normal)),
      ),
    );
  }
}
