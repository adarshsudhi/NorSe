import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Data/Models/MusicModels/usermodel.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/LaunchDataEntity/LaunchDataEntity.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/SearchSongEntity/SearchEntity.dart';
import 'package:nebula/features/Presentation/CustomWidgets/shimmer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../injection_container.dart' as di;
import '../../../Domain/UseCases/Sql_UseCase/initializedatabase_Usecase.dart';
import '../../Blocs/Musicbloc/LocalSongs_bloc/localsong_bloc.dart';
import '../../Blocs/Musicbloc/Trending_Song_bloc/trending_song_bloc.dart';
import '../../Blocs/Musicbloc/User_bloc/user_bloc_bloc.dart';
import '../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../Blocs/Musicbloc/favorite_bloc/favoriteplaylist_bloc.dart';
import '../../Blocs/Musicbloc/playlist_Bloc/playlist_bloc.dart';
import '../../Blocs/Musicbloc/recents_bloc/recents_bloc.dart';
import '../../Blocs/youtubeBloc/ytsearch_bloc/ytsearch_bloc.dart';
import '../../CustomWidgets/CustomTextFormField.dart';
import 'subscreens/SearchResultPage/SearchResultPage.dart';
import 'subscreens/SongDetailsPage/SongDetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _scrollController.dispose();
  }

  call() async {
    BlocProvider.of<PlaylistBloc>(context)
        .add(const PlaylistEvent.getallplaylist());
    BlocProvider.of<LocalsongBloc>(context)
        .add(const LocalsongEvent.getallsongs());
    BlocProvider.of<FavoriteplaylistBloc>(context)
        .add(const FavoriteplaylistEvent.getallsongs());
    BlocProvider.of<TrendingSongBloc>(context).add(TrendingSongs());
    BlocProvider.of<YtsearchBloc>(context).add(const YtsearchEvent.freestate());
    await di.di<initializedbusecase>().call();
  }

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<UserBlocBloc>(context)
        .add(const UserBlocEvent.getuserdetails());
    super.initState();
    BlocProvider.of<RecentsBloc>(context)
        .add(const RecentsEvent.getallrecent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black.withOpacity(0.8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return call();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ClipRRect(
                                  child: SizedBox(
                                    height: 86,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Userspace(
                                                  size: size,
                                                  controller: _controller)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          SearchResultscreen.Searchscreen,
                                          arguments: 'null');
                                    },
                                    child: Hero(
                                      tag: "search",
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(CupertinoIcons.search),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Text(
                                                    "Search songs,artists,albums",
                                                    style: GoogleFonts.aldrich(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black
                                                            .withOpacity(0.4))))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Spaces.Kheight10,
                              const TitleText(titleTextt: 'Trending now'),
                              BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                builder: (context, state) {
                                  if (state is Songstate) {
                                    return TrendingSongsWidget(
                                        details: state.trendingnow, size: size);
                                  } else if (state is TrendingSongLoading) {
                                    return Songloadingwidget(size: size);
                                  } else {
                                    return Songloadingwidget(size: size);
                                  }
                                },
                              ),
                              const TitleText(titleTextt: 'Top charts'),
                              Spaces.Kheight10,
                              BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                builder: (context, state) {
                                  if (state is Songstate) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                4,
                                        width: size.width,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.charts.length,
                                          itemBuilder: (context, index) {
                                            final charts = state.charts[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    SongDetailsPage.SongDetials,
                                                    arguments: SongDetailsPage(
                                                        type: charts.type,
                                                        imageurl: charts.image,
                                                        albumurl:
                                                            charts.playlisturl,
                                                        name: charts.title,
                                                        id: charts.id));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: CachedNetworkImage(
                                                            imageUrl: charts
                                                                .image
                                                                .replaceAll(
                                                                    '150x150',
                                                                    '500x500')),
                                                      ),
                                                    ),
                                                    Spaces.Kheight10,
                                                    Textutil(
                                                        text: charts.title,
                                                        fontsize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    Spaces.Kheight10,
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  } else if (state is TrendingSongLoading) {
                                    return Songloadingwidget(size: size);
                                  } else {
                                    return Songloadingwidget(size: size);
                                  }
                                },
                              ),
                              const TitleText(titleTextt: 'Top playlists'),
                              Spaces.Kheight10,
                              BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                builder: (context, state) {
                                  if (state is Songstate) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height / 4,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.newlyreleased.length,
                                        itemBuilder: (context, index) {
                                          final results =
                                              state.newlyreleased[index];
                                          return Column(
                                            children: [
                                              TrendingImageWidgets(
                                                  size: size,
                                                  results: results,
                                                  index: index),
                                              Text(
                                                state.newlyreleased[index]
                                                    .suntitle,
                                                style: Spaces.Getstyle(
                                                    8,
                                                    Colors.white,
                                                    FontWeight.normal),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  } else if (state is TrendingSongLoading) {
                                    return Songloadingwidget(size: size);
                                  } else {
                                    return Songloadingwidget(size: size);
                                  }
                                },
                              ),
                              const TitleText(titleTextt: 'Top albums'),
                              BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                builder: (context, state) {
                                  if (state is Songstate) {
                                    return TrendingSongsWidget(
                                        details: state.topalbums, size: size);
                                  } else if (state is TrendingSongLoading) {
                                    return Songloadingwidget(size: size);
                                  } else {
                                    return Songloadingwidget(size: size);
                                  }
                                },
                              ),
                              const TitleText(titleTextt: 'Malayalam'),
                              BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                builder: (context, state) {
                                  if (state is Songstate) {
                                    return TrendingSongsWidget(
                                        details: state.Malayalam, size: size);
                                  } else if (state is TrendingSongLoading) {
                                    return Songloadingwidget(size: size);
                                  } else {
                                    return Songloadingwidget(size: size);
                                  }
                                },
                              ),
                              const TitleText(titleTextt: 'Hindi'),
                              BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                builder: (context, state) {
                                  if (state is Songstate) {
                                    return TrendingSongsWidget(
                                        details: state.hindi, size: size);
                                  } else if (state is TrendingSongLoading) {
                                    return Songloadingwidget(size: size);
                                  } else {
                                    return Songloadingwidget(size: size);
                                  }
                                },
                              ),
                              const TitleText(titleTextt: 'Tamil'),
                              BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                builder: (context, state) {
                                  if (state is Songstate) {
                                    return TrendingSongsWidget(
                                        details: state.Tamil, size: size);
                                  } else if (state is TrendingSongLoading) {
                                    return Songloadingwidget(size: size);
                                  } else {
                                    return Songloadingwidget(size: size);
                                  }
                                },
                              ),
                              const TitleText(titleTextt: 'English'),
                              BlocBuilder<TrendingSongBloc, TrendingSongState>(
                                builder: (context, state) {
                                  if (state is Songstate) {
                                    return TrendingSongsWidget(
                                        details: state.English, size: size);
                                  } else if (state is TrendingSongLoading) {
                                    return Songloadingwidget(size: size);
                                  } else {
                                    return Songloadingwidget(size: size);
                                  }
                                },
                              ),
                              const Spaceadjust()
                            ],
                          ),
                        ],
                      ),
                    )
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

class Loadingpicks extends StatelessWidget {
  const Loadingpicks({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spaces.Kheight10,
          const TitleText(titleTextt: 'Quick picks'),
          Spaces.Kheight10,
          Expanded(
            child: PageView.builder(
              controller: PageController(viewportFraction: 1, initialPage: 0),
              scrollDirection: Axis.horizontal,
              itemCount: (10 / 4).ceil(),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: size.width,
                  child: Column(
                    children: List.generate(
                      4,
                      (innerIndex) {
                        final itemIndex = index * 4 + innerIndex;
                        if (itemIndex < 10) {
                          return SizedBox(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: ListTile(
                                leading: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Shimmer.fromColors(
                                      period: const Duration(seconds: 2),
                                      baseColor:
                                          const Color.fromARGB(255, 18, 41, 61),
                                      highlightColor:
                                          const Color.fromARGB(255, 2, 38, 68)
                                              .withOpacity(0.5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 3, 33, 57),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      )),
                                ),
                                subtitle: SizedBox(
                                  width: 150,
                                  height: 7,
                                  child: Shimmer.fromColors(
                                      period: const Duration(seconds: 2),
                                      baseColor:
                                          const Color.fromARGB(255, 18, 41, 61),
                                      highlightColor:
                                          const Color.fromARGB(255, 2, 38, 68)
                                              .withOpacity(0.5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 3, 33, 57),
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      )),
                                ),
                                title: SizedBox(
                                  width: MediaQuery.sizeOf(context).width / 1.5,
                                  height: 10,
                                  child: Shimmer.fromColors(
                                      period: const Duration(seconds: 2),
                                      baseColor:
                                          const Color.fromARGB(255, 18, 41, 61),
                                      highlightColor:
                                          const Color.fromARGB(255, 2, 38, 68)
                                              .withOpacity(0.5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 3, 33, 57),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Userspace extends StatelessWidget {
  const Userspace({
    super.key,
    required this.size,
    required TextEditingController controller,
  }) : _controller = controller;

  final Size size;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBlocBloc, UserBlocState>(
      builder: (context, state) {
        return state.maybeWhen(
            userdetails: (user) {
              return user.name.isEmpty
                  ? SizedBox(
                      height: double.infinity,
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spaces.Kheight10,
                          const Textutil(
                              text: 'Hello',
                              fontsize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                          Spaces.kheigth5,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            surfaceTintColor:
                                                Colors.transparent,
                                            backgroundColor: Colors.transparent,
                                            child: Container(
                                              height: size.height / 3.5,
                                              width: size.width / 1.1,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomTextFormField(
                                                      controller: _controller,
                                                      ContentType: "Name",
                                                      obscureText: false,
                                                      prefixicon:
                                                          Icons.playlist_add),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Center(
                                                              child: Textutil(
                                                                  text:
                                                                      'Cancel',
                                                                  fontsize: 13,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Usermodel user = Usermodel(
                                                              name: _controller
                                                                  .text
                                                                  .trim(),
                                                              date: DateTime
                                                                      .now()
                                                                  .toString());
                                                          BlocProvider.of<
                                                                      UserBlocBloc>(
                                                                  context)
                                                              .add(UserBlocEvent
                                                                  .userdetails(
                                                                      user,
                                                                      'initial'));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Center(
                                                              child: Textutil(
                                                                  text:
                                                                      'Update',
                                                                  fontsize: 13,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Textutil(
                                        text: 'guest',
                                        fontsize: 25,
                                        color: Colors.red,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Spaces.kheigth5,
                        ],
                      ),
                    )
                  : SizedBox(
                      height: double.infinity,
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spaces.Kheight10,
                          const Textutil(
                              text: 'Hello',
                              fontsize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                          Spaces.kheigth5,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            surfaceTintColor:
                                                Colors.transparent,
                                            backgroundColor: Colors.transparent,
                                            child: Container(
                                              height: size.height / 3.5,
                                              width: size.width / 1.1,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CustomTextFormField(
                                                      controller: _controller,
                                                      ContentType: "Name",
                                                      obscureText: false,
                                                      prefixicon:
                                                          Icons.playlist_add),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Center(
                                                              child: Textutil(
                                                                  text:
                                                                      'Cancel',
                                                                  fontsize: 13,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Usermodel user = Usermodel(
                                                              name: _controller
                                                                  .text
                                                                  .trim(),
                                                              date: DateTime
                                                                      .now()
                                                                  .toString());
                                                          BlocProvider.of<
                                                                      UserBlocBloc>(
                                                                  context)
                                                              .add(UserBlocEvent
                                                                  .userdetails(
                                                                      user,
                                                                      'update'));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: const Center(
                                                              child: Textutil(
                                                                  text:
                                                                      'Update',
                                                                  fontsize: 13,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Textutil(
                                        text: user.name,
                                        fontsize: 25,
                                        color: Colors.red,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          Spaces.kheigth5,
                        ],
                      ));
            },
            orElse: () => SizedBox(
                  height: double.infinity,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spaces.Kheight10,
                      const Textutil(
                          text: 'Hello',
                          fontsize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      Spaces.kheigth5,
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Textutil(
                                text: 'USER',
                                fontsize: 25,
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        surfaceTintColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          height: size.height / 3.5,
                                          width: size.width / 1.1,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CustomTextFormField(
                                                  controller: _controller,
                                                  ContentType: "Name",
                                                  obscureText: false,
                                                  prefixicon:
                                                      Icons.playlist_add),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Center(
                                                          child: Textutil(
                                                              text: 'Cancel',
                                                              fontsize: 13,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Usermodel user =
                                                          Usermodel(
                                                              name: _controller
                                                                  .text
                                                                  .trim(),
                                                              date: DateTime
                                                                      .now()
                                                                  .toString());
                                                      BlocProvider.of<
                                                                  UserBlocBloc>(
                                                              context)
                                                          .add(UserBlocEvent
                                                              .userdetails(user,
                                                                  'initial'));
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: const Center(
                                                          child: Textutil(
                                                              text: 'Update',
                                                              fontsize: 13,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ))
                          ],
                        ),
                      ),
                      Spaces.kheigth5,
                    ],
                  ),
                ));
      },
    );
  }
}

class Lastsession extends StatelessWidget {
  final List<SearchEntity> quickpicks;
  const Lastsession({
    Key? key,
    required this.quickpicks,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spaces.Kheight10,
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TitleText(titleTextt: 'Quick picks'),
            ],
          ),
          Spaces.Kheight10,
          Expanded(
            child: quickpicks.isNotEmpty
                ? PageView.builder(
                    controller:
                        PageController(viewportFraction: 1, initialPage: 0),
                    scrollDirection: Axis.horizontal,
                    itemCount: (quickpicks.length / 4).ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: size.width,
                        child: Column(
                          children: List.generate(
                            4,
                            (innerIndex) {
                              final itemIndex = index * 4 + innerIndex;
                              if (itemIndex < quickpicks.length) {
                                return InkWell(
                                  onTap: () {
                                    List<AlbumSongEntity> allsongs = [];
                                    for (var element in quickpicks) {
                                      final song = AlbumSongEntity(
                                          id: element.id,
                                          name: element.name,
                                          year: 'null',
                                          primaryArtists:
                                              element.primaryArtists,
                                          image: element.image,
                                          songs: element.downloadUrl,
                                          albumurl: element.moreinfo['album']);
                                      allsongs.add(song);
                                    }

                                    BlocProvider.of<AudioBloc>(context).add(
                                        AudioEvent.onlineaudio(
                                            allsongs[itemIndex].id,
                                            itemIndex,
                                            allsongs[itemIndex].songs,
                                            allsongs[itemIndex].image,
                                            allsongs[itemIndex].name,
                                            allsongs[itemIndex].primaryArtists,
                                            const [],
                                            allsongs,
                                            const [],
                                            const []));
                                  },
                                  child: SizedBox(
                                    height: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 7),
                                      child: ListTile(
                                        leading: Container(
                                          height: 90,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          quickpicks[itemIndex]
                                                              .image),
                                                  fit: BoxFit.cover)),
                                        ),
                                        subtitle: Text(
                                          quickpicks[itemIndex].primaryArtists,
                                          style: Spaces.Getstyle(
                                              10,
                                              const Color.fromARGB(
                                                  255, 129, 129, 129),
                                              FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        title: Text(
                                          quickpicks[itemIndex].name,
                                          style: Spaces.Getstyle(15,
                                              Colors.white, FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String titleTextt;
  const TitleText({
    Key? key,
    required this.titleTextt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
          height: 30,
          child: Center(
              widthFactor: 1.0,
              child: Textutil(
                text: titleTextt,
                fontsize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ))),
    );
  }
}

class TrendingSongsWidget extends StatelessWidget {
  final List<launchdataEntity> details;
  final Size size;
  const TrendingSongsWidget({
    Key? key,
    required this.details,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 4,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: details.length,
        itemBuilder: (context, index) {
          final results = details[index];
          return TrendingImageWidgets(
              size: size, results: results, index: index);
        },
      ),
    );
  }
}

class TrendingImageWidgets extends StatelessWidget {
  const TrendingImageWidgets({
    Key? key,
    required this.size,
    required this.results,
    required this.index,
  }) : super(key: key);

  final Size size;
  final launchdataEntity results;
  final int index;

  @override
  Widget build(BuildContext context) {
    final img = results.image.replaceAll('150x150.jpg', '500x500.jpg');
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (results.type == 'album') {
              Navigator.pushNamed(context, SongDetailsPage.SongDetials,
                  arguments: SongDetailsPage(
                      type: results.type,
                      imageurl: results.image,
                      albumurl: results.albumurl,
                      name: results.title,
                      id: results.id));
            } else if (results.type == 'playlist') {
              Navigator.pushNamed(context, SongDetailsPage.SongDetials,
                  arguments: SongDetailsPage(
                      type: results.type,
                      imageurl: results.image,
                      albumurl: results.albumurl,
                      name: results.title,
                      id: results.id));
            }
          },
          child: SizedBox(
            width: size.width / 2.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 5.7,
                  padding: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: SizedBox(
                    width: size.width / 2.3,
                    child: CachedNetworkImage(
                      imageUrl: img,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/musical-note.png',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                 SizedBox(
                    child: Textutil(
                        text: results.title,
                        fontsize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.normal)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
