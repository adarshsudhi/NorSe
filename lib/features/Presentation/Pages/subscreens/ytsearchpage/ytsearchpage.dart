import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Bloc/youtubeBloc/searchyt_bloc/searchyt_bloc_bloc.dart';
import 'package:nebula/features/Presentation/Pages/musicplayerpage/testonlineplayerscreen.dart';
import '../../youtubeplayer/testytplayerscreen.dart';
import '../youtubescreen/ytpage.dart';

class Ytsearchpage extends StatelessWidget {
  static const String ytsearchpage = "./searchpagescreen";
  Ytsearchpage({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SafeArea(
            child: Row(
              children: [
                PlayIcons(
                    playicons: Icons.arrow_back_ios,
                    iconscolors: Colors.white,
                    iconsize: 17,
                    ontap: () {
                      Navigator.pop(context);
                    }),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      controller: _textEditingController,
                      style:
                          Spaces.Getstyle(15, Colors.black, FontWeight.normal),
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
                          hintStyle: Spaces.Getstyle(
                              15, Colors.grey, FontWeight.normal)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchytBlocBloc, SearchytBlocState>(
              builder: (context, state) {
                return state.maybeWhen(
                    loader: () => const Ytloading(),
                    searchedvideo: (videos, isloading, isfailed) {
                      return isloading != true
                          ? Expanded(
                              child: Column(
                                children: [
                                  Spaces.Kheight20,
                                  Expanded(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: videos.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap:() {
                                            Navigator.pushNamed(context,Testytplayer.testytplayer,arguments: Testytplayer(video: videos, index: index));
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(bottom: 20,),
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
                                                  Spaces.Kheight10,
                                                  Textutil(
                                                      text: videos[index].title,
                                                      fontsize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  Textutil(
                                                      text: videos[index].author,
                                                      fontsize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500)
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                        /* Padding(
                                                padding: const EdgeInsets.only(bottom: 20),
                                                child: InkWell(
                                                  onTap: () {
                                                   Navigator.pushNamed(context,Testytplayer.testytplayer,arguments: Testytplayer(video: videos, index: index));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 400,
                                                          width: double.infinity,
                                                          clipBehavior: Clip.antiAlias,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: Image.network(
                                                            errorBuilder: (context, error, stackTrace) {
                                                             return Image.asset('assets/musical-note.png',color: Colors.white.withOpacity(0.5),);
                                                           },
                                                            videos[index].thumbnails.maxResUrl,fit: BoxFit.cover,),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Textutil(text: videos[index].title, fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                                                              Textutil(text: videos[index].author, fontsize: 9, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.normal)
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ),
                                              ); */
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            );
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
    );
  }
}
