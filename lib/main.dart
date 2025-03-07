import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/configs/routers/Routes.dart';
import 'package:norse/features/Domain/UseCases/Platform_UseCase/initializenotification_usecase.dart';
import 'package:norse/features/Presentation/Blocs/Connectivity_bloc/connnectivity_bloc.dart';
import 'package:norse/features/Presentation/Blocs/Musicbloc/searchlibrary_bloc/searchlibrary_bloc.dart';
import 'package:norse/features/Presentation/Blocs/spotify/spotifyalbumorplaylist/spotifyplaylistsoralbum_bloc.dart';
import 'package:norse/features/Presentation/Blocs/spotify/spotifyapi_bloc/spotifyapi_bloc.dart';
import 'package:norse/features/Presentation/Blocs/youtubeBloc/downloadvideo_bloc/download_video_bloc.dart';
import 'package:norse/features/Presentation/Blocs/youtubeBloc/managevideo_bloc/manage_video_download_bloc.dart';
import 'package:norse/features/Presentation/Blocs/youtubeBloc/ytchannel_bloc/youtubechannel_bloc.dart';
import 'package:norse/features/Presentation/pages/MainHomePage/MainHomePage.dart';
import 'package:norse/firebase_options.dart';
import 'package:norse/injection_container.dart';
import 'features/Presentation/Blocs/Musicbloc/Albumsongs/albums_songs_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Download_Bloc/download_song_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Library/album/libraryalbum/libraryalbum_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Library/album/libraryalbumlike/libraryalbumlike_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Library/playlist/libraryplaylist/libraryplaylist_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Library/playlist/libraryplaylistlike/libraryplaylistlike_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Library/song/library_bloc/library_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Library/song/songlike_bloc/songlike_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/LocalData/localdata_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/LocalSongs_bloc/localsong_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Lyrics_bloc/lyrics_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/SearchSong_bloc/search_song_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Suggestion/suggestion_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/TagEditor_bloc/tageditor_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/Trending_Song_bloc/trending_song_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/User_bloc/user_bloc_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/backupandrestorebloc/bloc/backup_and_restore_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/favorite_bloc/favoriteplaylist_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/favsong_bloc/favsongs_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/playerui_bloc/playerui_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/playlist_Bloc/playlist_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/playlistsongs_bloc/playlistsongs_bloc.dart';
import 'features/Presentation/Blocs/Musicbloc/recents_bloc/recents_bloc.dart';
import 'features/Presentation/Blocs/youtubeBloc/searchyt_bloc/searchyt_bloc_bloc.dart';
import 'features/Presentation/Blocs/youtubeBloc/videoinfo_bloc/videoinfo_bloc.dart';
import 'features/Presentation/Blocs/youtubeBloc/youtubeplayer_bloc/youtubeplayer_bloc.dart';
import 'features/Presentation/Blocs/youtubeBloc/yt_bloc/yt_bloc.dart';
import 'features/Presentation/Blocs/youtubeBloc/ytdownload_bloc/ytdownload_bloc.dart';
import 'features/Presentation/Blocs/youtubeBloc/ytrelatedvideos_bloc/ytrelatedvideos_bloc.dart';
import 'features/Presentation/Blocs/youtubeBloc/ytsearch_bloc/ytsearch_bloc.dart';
import 'features/Presentation/pages/saavn/Intialpage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MetadataGod.initialize();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const Main());
}



class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    di<InitializeNotificationusecase>().call();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FirebaseAnalyticsObserver getAnalyticsObserver() =>
          FirebaseAnalyticsObserver(analytics: analytics);
     getAnalyticsObserver();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<ConnnectivityBloc>()),
        BlocProvider(create: (context) => di<AlbumsSongsBloc>()),
        BlocProvider(create: (context) => di<TrendingSongBloc>()),
        BlocProvider(create: (context) => di<SearchSongBloc>()),
        BlocProvider(create: (context) => di<DownloadSongBloc>()),
        BlocProvider(create: (context) => di<LocaldataBloc>()),
        BlocProvider(create: (context) => di<LocalsongBloc>()),
        BlocProvider(create: (context) => di<PlaylistBloc>()),
        BlocProvider(create: (context) => di<FavsongsBloc>()),
        BlocProvider(create: (context) => di<FavoriteplaylistBloc>()),
        BlocProvider(create: (context) => di<PlaylistsongsBloc>()),
        BlocProvider(create: (context) => di<LibraryBloc>()),
        BlocProvider(create: (context) => di<SonglikeBloc>()),
        BlocProvider(create: (context) => di<LibraryalbumBloc>()),
        BlocProvider(create: (context) => di<LibraryalbumlikeBloc>()),
        BlocProvider(create: (context) => di<LibraryplaylistBloc>()),
        BlocProvider(create: (context) => di<LibraryplaylistlikeBloc>()),
        BlocProvider(create: (context) => di<YtBloc>()),
        BlocProvider(create: (context) => di<YtdownloadBloc>()),
        BlocProvider(create: (context) => di<UserBlocBloc>()),
        BlocProvider(create: (context) => di<RecentsBloc>()),
        BlocProvider(create: (context) => di<LyricsBloc>()),
        BlocProvider(create: (context) => di<AudioBloc>()),
        BlocProvider(create: (context) => di<YtsearchBloc>()),
        BlocProvider(create: (context) => di<BackupAndRestoreBloc>()),
        BlocProvider(create: (context) => di<VideoinfoBloc>()),
        BlocProvider(create: (context) => di<SearchytBlocBloc>()),
        BlocProvider(create: (context) => di<YoutubeplayerBloc>()),
        BlocProvider(create: (context) => di<SuggestionBloc>()),
        BlocProvider(create: (context) => di<YoutubechannelBloc>()),
        BlocProvider(create: (context) => di<YtrelatedvideosBloc>()),
        BlocProvider(create: (context) => di<TageditorBloc>()),
        BlocProvider(create: (context) => di<PlayeruiBloc>()),
        BlocProvider(create: (context) => di<SearchlibraryBloc>()),
        BlocProvider(create: (context) => di<ManageVideoDownloadBloc>()),
        BlocProvider(create: (context) => di<DownloadVideoBloc>(),),
        BlocProvider(create: (context)=> di<SpotifyapiBloc>()),
        BlocProvider(create: (context)=> di<SpotifyplaylistsoralbumBloc>())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'norse',
          theme: ThemeData(
            textTheme: TextTheme(
              bodyMedium: Spaces.Getstyle(19, Colors.black, FontWeight.normal),
              titleMedium: Spaces.Getstyle(30, Colors.black, FontWeight.bold),
              bodyLarge: GoogleFonts.aBeeZee(
                  color: const Color.fromARGB(255, 197, 89, 89),
                  fontSize: 15,
                  decoration: TextDecoration.none),
              bodySmall: GoogleFonts.aBeeZee(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  decoration: TextDecoration.none),
            ),
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 104, 58, 183)),
            useMaterial3: true,
          ),
          onGenerateRoute: (settings) => onGenerate(settings),
          home: const Determine()),
    );
  }
}

class Determine extends StatefulWidget {
  const Determine({super.key});

  @override
  State<Determine> createState() => _DetermineState();
}

class _DetermineState extends State<Determine> {
  @override
  void initState() {
    BlocProvider.of<ConnnectivityBloc>(context)
        .add(const ConnnectivityEvent.startSevice());
    BlocProvider.of<UserBlocBloc>(context)
        .add(const UserBlocEvent.getuserdetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBlocBloc, UserBlocState>(
      builder: (context, state) {
        return state.maybeWhen(
            initial: () => const Initial(),
            userdetails: (user) => const MainHomePage(),
            orElse: () => const Center(
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ))));
      },
    );
  }
}
