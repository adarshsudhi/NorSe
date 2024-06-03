import 'package:cached_network_image/cached_network_image.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/LaunchDataEntity/LaunchDataEntity.dart';
import 'package:nebula/features/Domain/UseCases/API_UseCase/gettopsearches_UseCase.dart';
import 'package:nebula/features/Domain/UseCases/Sql_UseCase/usersearch_usecase.dart';
import 'package:nebula/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/SongsDetailsEntity/SongsEntity.dart';
import '../../../../../../configs/constants/Spaces.dart';
import '../../../../../Data/Models/MusicModels/onlinesongmodel.dart';
import '../../../../../Domain/UseCases/Sql_UseCase/addtodownloads_Usecase.dart';
import '../../../../Blocs/Musicbloc/SearchSong_bloc/search_song_bloc.dart';
import '../../../../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../../../../CustomWidgets/CustomSearchTextFormfield.dart';
import '../../../../CustomWidgets/backgroundGradient.dart';
import '../../../../CustomWidgets/shimmer.dart';
import '../../../MainHomePage/MainHomePage.dart';
import '../../HomePage.dart';
import '../../musicplayerpage/testonlineplayerscreen.dart';
import '../SongDetailsPage/SongDetailsPage.dart';

class SearchResultscreen extends StatefulWidget {
  static const String searchscreen = '/Searchpage';
  final String querydata;
  const SearchResultscreen({
    Key? key,
    required this.querydata,
  }) : super(key: key);

  @override
  State<SearchResultscreen> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultscreen> {
  final TextEditingController _searchController = TextEditingController();

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  List<Map<String, dynamic>> suggestions = [];
  List<launchdataEntity> searchsuggestions = [];

  _call1() async {
    final res = await di.di<GettopserachesUseCase>().call();
    await res.fold((l) async {}, (r) {
      setState(() {
        searchsuggestions = r;
      });
    });
  }

  _call() async {
    final res = await di.di<Usersearchusecase>().call('get', 'null');
    await res.fold((l) async {}, (r) {
      setState(() {
        suggestions = List.from(r);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _call1();
    _call();
    BlocProvider.of<SearchSongBloc>(context).add(Initiall());
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 17,
            )),
        title: Text(
          "Search",
          style: Spaces.Getstyle(23, Colors.white, FontWeight.bold),
        ),
      ),
      body: DefaultTabController(
          length: 3,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 2),
              child: Stack(
                children: [
                  const backgroundgradient(),
                  Container(
                    color: Colors.black.withOpacity(0.8),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Hero(
                                tag: "search",
                                child: CustomSearchTextFormfield(
                                  search: false,
                                  SearchController: _searchController,
                                  ontap: () {
                                    if (_searchController.text.isNotEmpty) {
                                      BlocProvider.of<SearchSongBloc>(context)
                                          .add(GetSearchSong(
                                              Querydata: _searchController.text
                                                  .trim()));
                                    }
                                  },
                                ))),
                        Expanded(
                          child: BlocBuilder<SearchSongBloc, SearchSongState>(
                            builder: (context, state) {
                              if (state is SearchSongLoading) {
                                return Column(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        child: TabBarView(children: [
                                          ListView.builder(
                                            itemCount: 20,
                                            itemBuilder: (context, index) {
                                              return const Searchsongloading();
                                            },
                                          ),
                                          ListView.builder(
                                            itemCount: 20,
                                            itemBuilder: (context, index) {
                                              return const Searchsongloading();
                                            },
                                          ),
                                          ListView.builder(
                                            itemCount: 20,
                                            itemBuilder: (context, index) {
                                              return const Searchsongloading();
                                            },
                                          ),
                                        ]),
                                      ),
                                    )
                                  ],
                                );
                              } else if (state is SearchSongLoaded) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: TabBar(
                                          dividerColor: Colors.black,
                                          indicatorColor: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          labelStyle: Spaces.Getstyle(13,
                                              Colors.black, FontWeight.bold),
                                          labelColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          unselectedLabelColor:
                                              const Color.fromARGB(
                                                  255, 94, 94, 94),
                                          indicator: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.transparent),
                                          tabs: const [
                                            Text('Songs'),
                                            Text('Albums'),
                                            Text('Playlists'),
                                          ]),
                                    ),
                                    Expanded(
                                      child: TabBarView(children: [
                                        ListView.builder(
                                          itemCount: state.Seachsong.length,
                                          itemBuilder: (context, index) {
                                            final data = state.Seachsong[index];
                                            return InkWell(
                                              onTap: () {
                                                List<Map<dynamic, dynamic>>
                                                    moreinfo = [];
                                                moreinfo.isNotEmpty
                                                    ? moreinfo.clear()
                                                    : null;
                                                for (var items
                                                    in state.Seachsong) {
                                                  moreinfo.add(items.moreinfo);
                                                }
                                                Recents(state.Seachsong, index,
                                                    context, 'null');

                                                BlocProvider.of<AudioBloc>(
                                                        context)
                                                    .add(AudioEvent.onlineaudio(
                                                        state.Seachsong[index]
                                                            .id,
                                                        index,
                                                        state.Seachsong[index]
                                                            .downloadUrl,
                                                        state.Seachsong[index]
                                                            .image,
                                                        moreinfo[index]
                                                            ['album'],
                                                        state.Seachsong[index]
                                                            .primaryArtists,
                                                        moreinfo,
                                                        const [],
                                                        state.Seachsong,
                                                        const []));
                                              },
                                              child: Songtiles(
                                                name: data.name,
                                                image: data.image,
                                                artist: data.primaryArtists,
                                                icons1: Icons.download,
                                                icons2: Icons.favorite_outline,
                                                visible1: true,
                                                visible2: false,
                                                ontap: () {},
                                                ontapqueue: () {
                                                  OnlineSongModel
                                                      onlineSongModel =
                                                      OnlineSongModel(
                                                          album:
                                                              state
                                                                      .Seachsong[
                                                                          index]
                                                                      .moreinfo[
                                                                  'music'],
                                                          id: state
                                                              .Seachsong[index]
                                                              .id,
                                                          title: state
                                                              .Seachsong[index]
                                                              .name,
                                                          imageurl: state
                                                              .Seachsong[index]
                                                              .image,
                                                          downloadurl: state
                                                              .Seachsong[index]
                                                              .downloadUrl,
                                                          artist: state
                                                              .Seachsong[index]
                                                              .primaryArtists);

                                                  BlocProvider.of<AudioBloc>(
                                                          context)
                                                      .add(AudioEvent
                                                          .addtonlinequeue(
                                                              'online',
                                                              onlineSongModel));
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        ListView.builder(
                                          itemCount: state.albums.length,
                                          itemBuilder: (context, index) {
                                            final details = state.albums[index];
                                            return InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    SongDetailsPage.SongDetials,
                                                    arguments: SongDetailsPage(
                                                        type: 'album',
                                                        imageurl: details.image,
                                                        albumurl:
                                                            details.albumurl,
                                                        name: details.name,
                                                        id: details.id));
                                              },
                                              child: Songtiles(
                                                name: details.name,
                                                image: details.image,
                                                artist: details.primaryArtists,
                                                icons1: Icons.download,
                                                icons2: Icons.favorite_outline,
                                                visible1: false,
                                                visible2: false,
                                                ontap: () async {
                                                  final data =
                                                      state.Seachsong[index];
                                                  AlbumElements albumElements =
                                                      AlbumElements(
                                                          id: data.id,
                                                          name: data.name,
                                                          year: '',
                                                          type: data.moreinfo[
                                                              'album'],
                                                          language: 'null',
                                                          Artist: data
                                                              .primaryArtists,
                                                          url: data.downloadUrl,
                                                          image: data.image);
                                                  await di
                                                      .di<addtodownloadsUsecase>()
                                                      .call(albumElements);
                                                },
                                                ontapqueue: () {},
                                              ),
                                            );
                                          },
                                        ),
                                        ListView.builder(
                                          itemCount: state.playlists.length,
                                          itemBuilder: (context, index) {
                                            final details =
                                                state.playlists[index];
                                            return InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    SongDetailsPage.SongDetials,
                                                    arguments: SongDetailsPage(
                                                        type: details.type,
                                                        imageurl: details.image,
                                                        albumurl:
                                                            details.albumurl,
                                                        name: details.title,
                                                        id: details.id));
                                              },
                                              child: Songtiles(
                                                name: details.title,
                                                image: details.image,
                                                artist: details.type,
                                                icons1: Icons.download,
                                                icons2: Icons.favorite_outline,
                                                visible1: false,
                                                visible2: false,
                                                ontap: () {},
                                                ontapqueue: () {},
                                              ),
                                            );
                                          },
                                        ),
                                      ]),
                                    ),
                                  ],
                                );
                              } else if (state is Songsuggestion) {
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: state.suggestions.length,
                                    itemBuilder: (context, index) {
                                      return Textutil(
                                          text: state.suggestions[index].name,
                                          fontsize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal);
                                    },
                                  ),
                                );
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    suggestions.isNotEmpty
                                        ? GridView.builder(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 4,
                                                    mainAxisSpacing: 5,
                                                    crossAxisSpacing: 15,
                                                    crossAxisCount: 2),
                                            itemCount: suggestions.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              SearchSongBloc>(
                                                          context)
                                                      .add(GetSearchSong(
                                                          Querydata:
                                                              suggestions[index]
                                                                  ['search']));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                                height: 40,
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await di.di<Usersearchusecase>().call(
                                                                              'remove',
                                                                              suggestions[index]['search'].toString());
                                                                          suggestions
                                                                              .removeAt(index);
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .cancel,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              25,
                                                                        ))),
                                                            Expanded(
                                                                child: Textutil(
                                                                    text: suggestions[
                                                                            index]
                                                                        [
                                                                        'search'],
                                                                    fontsize:
                                                                        10,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : const SizedBox(),
                                    const TitleText(
                                        titleTextt: 'Trending searches'),
                                    Spaces.kheight10,
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: searchsuggestions.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                if (searchsuggestions[index]
                                                        .type ==
                                                    'album') {
                                                  Navigator.pushNamed(
                                                      context,
                                                      SongDetailsPage
                                                          .SongDetials,
                                                      arguments: SongDetailsPage(
                                                          type:
                                                              searchsuggestions[
                                                                      index]
                                                                  .type,
                                                          imageurl:
                                                              searchsuggestions[
                                                                      index]
                                                                  .image,
                                                          albumurl:
                                                              searchsuggestions[
                                                                      index]
                                                                  .albumurl,
                                                          name:
                                                              searchsuggestions[
                                                                      index]
                                                                  .title,
                                                          id: searchsuggestions[
                                                                  index]
                                                              .id));
                                                } else if (searchsuggestions[
                                                            index]
                                                        .type ==
                                                    'playlist') {
                                                  Navigator.pushNamed(
                                                      context,
                                                      SongDetailsPage
                                                          .SongDetials,
                                                      arguments: SongDetailsPage(
                                                          type:
                                                              searchsuggestions[
                                                                      index]
                                                                  .type,
                                                          imageurl:
                                                              searchsuggestions[
                                                                      index]
                                                                  .image,
                                                          albumurl:
                                                              searchsuggestions[
                                                                      index]
                                                                  .albumurl,
                                                          name:
                                                              searchsuggestions[
                                                                      index]
                                                                  .title,
                                                          id: searchsuggestions[
                                                                  index]
                                                              .id));
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        height: 55,
                                                        width: 60,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0)),
                                                        child: CachedNetworkImage(
                                                            imageUrl:
                                                                searchsuggestions[
                                                                        index]
                                                                    .image)),
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
                                                                  searchsuggestions[
                                                                          index]
                                                                      .title,
                                                              fontsize: 15,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                          Textutil(
                                                              text: searchsuggestions[
                                                                      index]
                                                                  .suntitle,
                                                              fontsize: 9,
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ));
                                        },
                                      ),
                                    )
                                  ],
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomMusicBar())
                ],
              ),
            ),
          )),
    );
  }
}
