// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dart_des/dart_des.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' ;
import 'package:http/http.dart' as http;
import 'package:jiosaavn/jiosaavn.dart';
import 'package:norse/features/Data/Models/MusicModels/LauchDataModel/LaunchDataModel.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../../configs/APIEndpoints/API.dart';
import '../../../../../configs/Error/Errors.dart';
import '../../../../../configs/notifier/notifiers.dart';
import '../../../../Domain/Entity/MusicEntity/AlbumDetailsEntity/AlbumDetailEntity.dart';
import '../../../../Domain/Entity/MusicEntity/LaunchDataEntity/LaunchDataEntity.dart';
import '../../../../Domain/Entity/MusicEntity/PlaylistEntity/PlaylistEntity.dart';
import '../../../../Domain/Entity/MusicEntity/SearchSongEntity/SearchEntity.dart';
import '../../../../Domain/Entity/MusicEntity/TopChartsEntity/topchartentity.dart';
import '../../../Models/MusicModels/AlbumsModel/AlbumModel.dart';
import '../../../Models/MusicModels/SearchModel/SearchModel.dart';
import '../../../Models/MusicModels/topchartsmodels/topchartsmodel.dart';
import '../../LocalDataSource/SqlQuerys/Sqllocaldatasource.dart';
import 'APIremotedatasource.dart';

class APIremotedatasourceimp implements APIremoteDatasource {
  final Sqldatasourcerepository sqldatasourcerepository;
  final YoutubeExplode yt;
  final JioSaavnClient jioSaavnClient;
  const APIremotedatasourceimp({
    required this.sqldatasourcerepository,
    required this.yt,
    required this.jioSaavnClient,
  });
  @override
  Future<List<AlbumSongEntity>> getAlbumSongs(String albumurl) async {
    try {
      List<AlbumSongEntity> albumsongslist = [];
      Uri url = Uri.parse("${ApiEndpoints.GetAlbumSongs}$albumurl");
      http.Response response = await http.get(url);
      final res =
          response.body.replaceAll('&quot;', '').replaceAll('&#039;', '');
      if (response.statusCode == 200) {
        final res1 = jsonDecode(res);
        for (Map<String, dynamic> element in res1['data']['songs']) {
          AlbumSongEntity albumSongEntity = AlbumSongModels.fromMap(
              element,
              element['downloadUrl'][Notifiers.qualityNotifier.value == '96kbps'
                  ? 2
                  : Notifiers.qualityNotifier.value == '160kbps'
                      ? 3
                      : 4]['link']);
          albumsongslist.add(albumSongEntity);
        }
      }
      return albumsongslist;
    } catch (e) {
      throw Exception('Album Songs Failed');
    }
  }

  @override
  Future<List<SearchEntity>> SearchSong(String Querydata) async {
    List<SearchEntity> results = [];
    final String encoded = jsonEncode(ApiEndpoints().url);
    final uurl =
        encoded.replaceAll('Querydata', Querydata).replaceAll('6', '20');
    final decoded = jsonDecode(uurl);
    Uri uri = Uri.https(ApiEndpoints.jiosaavnSearchBase, '/api.php', decoded);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      for (var items in res['results']) {
        if (items['type'] == 'song') {
          List<Map<String, dynamic>> links =
              await decrypt(items['more_info']['encrypted_media_url']);
          SearchEntity searchEntity = SearchEntity(
              moreinfo: items['more_info'],
              id: items['id'],
              name: items['title']
                  .toString()
                  .replaceAll('&quot;', '')
                  .replaceAll('&amp;', ''),
              year: items['id'],
              image: items['image'].toString().replaceAll('150x150', '500x500'),
              primaryArtists:
                  (items['more_info']['artistMap']['primary_artists'] as List)
                          .isEmpty
                      ? items['more_info']['music']
                      : items['more_info']['artistMap']['primary_artists'][0]
                          ['name'],
              downloadUrl: links[Notifiers.qualityNotifier.value == '96kbps'
                      ? 2
                      : Notifiers.qualityNotifier.value == '160kbps'
                          ? 3
                          : 4]['link']
                  .toString());
          results.add(searchEntity);
        }
      }
      return results;
    }
    throw Exception("Fetch error");
  }

  @override
  Future<SearchEntity> GetSong(String Songurl) async {
    Uri url = Uri.parse("${ApiEndpoints.GetSong}$Songurl");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      if (res['data'] != null && res['data'].isNotEmpty) {
        Map<String, dynamic> data = res['data'][0];
        SearchEntity searchEntity = SearchModel.fromJson(data);
        return searchEntity;
      } else {
        throw Exception('Data is empty');
      }
    } else {
      throw Exception('Failure');
    }
  }

  @override
  Future<List<AlbumSongEntity>> GetSearchedAlbums(String Query) async {
    List<AlbumSongEntity> list = [];
    try {
      final String encoded = jsonEncode(ApiEndpoints().url);
      final uurl = encoded.replaceAll('Querydata', Query);
      final finalporc =
          uurl.replaceAll('search.getResults', 'search.getAlbumResults');
      Map<String, dynamic> decoded = jsonDecode(finalporc);
      Uri uri = Uri.https(ApiEndpoints.jiosaavnSearchBase, '/api.php', decoded);
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> element in data['results']) {
          AlbumSongEntity entity = AlbumSongModels(
              id: element['id'],
              name: element['title'],
              year: element['year'],
              primaryArtists: element['subtitle'],
              image: element['image'],
              songs: 'null',
              albumurl: element['perma_url']);
          list.add(entity);
        }
        return list;
      }
      throw Exception('Data is empty');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> DownloadSong(String DownloadUrl,
      ProgressCallback progressCallback, String Songpath) async {
    try {
      final dio = Dio();
      await dio.download(DownloadUrl, Songpath,
          onReceiveProgress: progressCallback);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> DownloadArtwork(String DownloadUrl,
      ProgressCallback progressCallback, String artworkpath) async {
    try {
      final dio = Dio();
      await dio.download(DownloadUrl, artworkpath,
          onReceiveProgress: progressCallback);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<launchdataEntity>> trendingnow(String type) async {
    List<launchdataEntity> launchdata = [];

    try {
      String encoded = jsonEncode(ApiEndpoints().url);

      String uurl =
          encoded.replaceAll('search.getResults', 'webapi.getLaunchData');

      Map<String, dynamic> decoded = jsonDecode(uurl);

      Uri uri = Uri.https(ApiEndpoints.jiosaavnSearchBase, '/api.php', decoded);

      http.Response response =
          await http.get(uri, headers: {'cookie': 'L=$type', 'Accept': '*/*'});

      await sqldatasourcerepository.storeresponse(response.body, type);

      if (response.statusCode == 200) {
        final ress =
            response.body.replaceAll('&quot;', '').replaceAll('&#039;', '');
        Map<String, dynamic> res = jsonDecode(ress);
        for (var items in res['new_trending']) {
          if (items['type'] == 'album' || items['type'] == 'playlist') {
            launchdataEntity entity = launchdataModel.fromJson(items);
            launchdata.add(entity);
          }
        }
        return launchdata;
      } else {
        throw Exception('trending song failed');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<playlistEntity>>> getplaylistdetails(
      String id) async {
    List<playlistEntity> playlistsongs = [];
    try {
      Map<String, dynamic> response = await jioSaavnClient.songs.request(
          call: ApiEndpoints.endpoints.playlists.id,
          queryParameters: {'listid': id});

      String cleanres = jsonEncode(response);

      Map<String, dynamic> res = jsonDecode(
          cleanres.replaceAll('&quot;', '').replaceAll('&#039;', ''));

      if (res.isNotEmpty) {
        for (var songs in res['songs']) {
          List<Map<String, dynamic>> links =
              await decrypt(songs['encrypted_media_url']);
          Map moreinfo = {
            'more_info': {'music': songs["album"]}
          };
          playlistEntity entity = playlistEntity(
              name: songs['song'],
              id: songs['id'],
              images:
                  songs['image'].toString().replaceAll('150x150', '500x500'),
              downloadUrl: links[Notifiers.qualityNotifier.value == '96kbps'
                      ? 2
                      : Notifiers.qualityNotifier.value == '160kbps'
                          ? 3
                          : 4]['link']
                  .toString(),
              primaryArtists: songs["primary_artists"],
              more_info: moreinfo);
          playlistsongs.add(entity);
        }
        return right(playlistsongs);
      } else {
        throw Exception('playlist details failed');
      }
    } catch (e) {
      return left(const Failures.serverfailure());
    }
  }

  @override
  Future<List<launchdataEntity>> getsearchPlaylists(String query) async {
    List<launchdataEntity> playlists = [];
    try {
      String encoded = jsonEncode(ApiEndpoints().url);
      String uurl =
          encoded.replaceAll('search.getResults', 'search.getPlaylistResults');
      String finalproc = uurl.replaceAll('Querydata', query);
      Map<String, dynamic> decoded = jsonDecode(finalproc);
      Uri uri = Uri.https(ApiEndpoints.jiosaavnSearchBase, '/api.php', decoded);
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var res in data['results']) {
          launchdataEntity res1 = launchdataModel.fromJson(res);
          playlists.add(res1);
        }
        return playlists;
      } else {
        throw Exception('playlist fetch failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Either<Failures, List<launchdataEntity>>> topsearches() async {
    List<launchdataEntity> res = [];
    try {
      String encoded = jsonEncode(ApiEndpoints().url);
      String uurl =
          encoded.replaceAll('search.getResults', 'content.getTopSearches');
      String finalproc = uurl.replaceAll('q', '');
      Map<String, dynamic> decoded = jsonDecode(finalproc);
      Uri uri = Uri.https(ApiEndpoints.jiosaavnSearchBase, '/api.php', decoded);
      final http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var items in data) {
          if (items['type'] == 'album' || items['type'] == 'playlist') {
            launchdataEntity launchdata = launchdataModel.fromJson(items);
            res.add(launchdata);
          }
        }
      }
      if (res.isNotEmpty) {
        return right(res);
      } else {
        return left(const Failures.serverfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<topchartsEntity>>> topcharts() async {
    List<topchartsEntity> res = [];
    try {
      String encoded = jsonEncode(ApiEndpoints().url);
      String uurl =
          encoded.replaceAll('search.getResults', 'webapi.getLaunchData');
      String finalproc = uurl.replaceAll('q', '');
      Map<String, dynamic> decoded = jsonDecode(finalproc);
      Uri uri = Uri.https(ApiEndpoints.jiosaavnSearchBase, '/api.php', decoded);
      http.Response response = await http.get(uri);
      await sqldatasourcerepository.storeresponse(response.body, 'topcharts');
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);
        for (var i in map['charts']) {
          topchartsEntity charts = TopchartsModel.fromJson(i);
          res.add(charts);
        }
        return right(res);
      } else {
        return left(const Failures.serverfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<launchdataEntity>>> newlyreleased() async {
    List<launchdataEntity> list = [];
    try {
      String encoded = jsonEncode(ApiEndpoints().url);
      String uurl =
          encoded.replaceAll('search.getResults', 'webapi.getLaunchData');
      String finalproc = uurl.replaceAll('q', '');
      Map<String, dynamic> decoded = jsonDecode(finalproc);
      Uri uri = Uri.https(ApiEndpoints.jiosaavnSearchBase, '/api.php', decoded);
      http.Response response = await http.get(uri);
      await sqldatasourcerepository.storeresponse(
          response.body, 'newlyreleased');
      if (response.statusCode == 200) {
        final res = response.body.replaceAll('&quot;', '');
        final data = jsonDecode(res);
        for (var items in data['top_playlists']) {
          final songs = launchdataModel.fromJson(items);
          list.add(songs);
        }
        if (list.isNotEmpty) {
          return right(list);
        } else {
          return left(const Failures.serverfailure());
        }
      } else {
        throw Exception('newlydata failed');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<launchdataEntity>>> gettopalbums() async {
    List<launchdataEntity> list = [];
    try {
      String encoded = jsonEncode(ApiEndpoints().url);
      String uurl =
          encoded.replaceAll('search.getResults', 'webapi.getLaunchData');
      String finalproc = uurl.replaceAll('q', '');
      Map<String, dynamic> decoded = jsonDecode(finalproc);
      Uri uri = Uri.https(ApiEndpoints.jiosaavnSearchBase, '/api.php', decoded);
      http.Response response = await http.get(uri);
      await sqldatasourcerepository.storeresponse(response.body, 'topalbums');
      if (response.statusCode == 200) {
        final res =
            response.body.replaceAll('&quot;', '').replaceAll('&#039;', '');
        final data = jsonDecode(res);
        for (var items in data['promo:vx:data:116']) {
          final songs = launchdataModel.fromJson(items);
          list.add(songs);
        }
        if (list.isNotEmpty) {
          return right(list);
        } else {
          return left(const Failures.serverfailure());
        }
      } else {
        throw Exception('top albumfailed failed');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> decrypt(String encriptedmediaurl) async {
    try {
      String data = '38346591';
      Uint8List encryptedBytes = base64.decode(encriptedmediaurl);
      List<int> keyBytes = utf8.encode(data);
      final decripted = DES(
              key: keyBytes,
              mode: DESMode.ECB,
              paddingType: DESPaddingType.PKCS7)
          .decrypt(encryptedBytes);
      List<Map<String, String>> links = ApiEndpoints().qualities.map((quality) {
        final updatedLink =
            utf8.decode(decripted).replaceAll('_96', quality['id']!);
        return {'quality': quality['bitrate']!, 'link': updatedLink};
      }).toList();
      return links;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getvideoinfo(String id) async {
    try {
      final channelinfo = await yt.channels.getByVideo(id);
      final info = await yt.videos.get(id);

      String disklikeurl = "${(ApiEndpoints.ytdislike)}$id";

      Uri url = Uri.parse(disklikeurl);

      final response = await http.get(url);

      Map<String, dynamic> body = jsonDecode(response.body);

      Map<String, dynamic> allinfo = {
        'channel': channelinfo,
        'video': info,
        'dislike': body['dislikes']
      };
      if (info.title != '') {
        return allinfo;
      } else {
        throw Exception('infoFailed');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<AudioOnlyStreamInfo>>> getstream(String id) async {
    try {
       List<AudioOnlyStreamInfo> audioStream = [];

       StreamManifest streamManifest = await yt.videos.streams.getManifest(id);

       UnmodifiableListView<AudioOnlyStreamInfo> audioonly =  streamManifest.audioOnly;

       List<AudioOnlyStreamInfo> audioOnlyStreamInfo = List.from(audioonly);

       Iterable<AudioOnlyStreamInfo> res = audioOnlyStreamInfo.where((e)=>e.codec.subtype == "mp4");

       for (var element in res) {
         audioStream.add(element);
       }

       return right(audioStream);
    } catch (e) {
      return left(const Failures.serverfailure());
    }
  }

  @override
  Future<Either<Failures, Map<String, dynamic>>> getlyrices(String id) async {
    try {
      Map<String, dynamic> lyr = await jioSaavnClient.songs.request(
          call: ApiEndpoints.endpoints.lyrics,
          queryParameters: {'lyrics_id': id});
      if (lyr['status'] != 'failure') {
        return right(lyr);
      }
      return left(const Failures.serverfailure());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, VideoSearchList>> getsearchvideo(String query) async {
    try {
      VideoSearchList list = await yt.search.search(query);
      if (list.isNotEmpty) {
        return right(list);
      }
      return left(const Failures.serverfailure());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<dynamic> getplaylist(String id, String mode) async {
    try {
      if (mode == 'playlist') {
        List<Video> playlist = await yt.playlists.getVideos(id).toList();
        return playlist;
      } else {
        throw Exception('not a mode');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<VideoOnlyStreamInfo>>> getManifest(
      String url) async {

  try { 
    List<VideoOnlyStreamInfo> filtered = [];
         StreamManifest streamManifest = await  yt.videos.streams.getManifest(url);
         UnmodifiableListView<VideoOnlyStreamInfo> unmodifiedlist = streamManifest.videoOnly;
         List<VideoOnlyStreamInfo> videoOnlyStreamInfo = List.from(unmodifiedlist);
         for (var vid in videoOnlyStreamInfo) {
           if (vid.videoCodec.contains("avc1")) {
             filtered.add(vid);
           }
         }
         return right(filtered);
        } catch (e) {
          throw Exception(e.toString());
        }
  }
  
              

  

  @override
  Future<Either<Failures, RelatedVideosList>> getrelatedvideos(
      String videoid) async {
    try {
      Video video = await yt.videos.get(videoid);
      RelatedVideosList? videos = await yt.videos.getRelatedVideos(video);
      if (videos != null && videos.isNotEmpty) {
        return right(videos);
      } else {
        return left(const Failures.serverfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, ChannelUploadsList>> getchanneluploads(
      dynamic channelid) async {
    try {
      ChannelUploadsList uploadsList = await yt.channels.getUploadsFromPage(
          channelid,
          videoSorting: VideoSorting.newest,
          videoType: VideoType.normal);
      if (uploadsList.isEmpty) {
        return left(const Failures.serverfailure());
      } else {
        return right(uploadsList);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<String>> getsearchsuggestion(String query) async {
    List<String> suggestions = [];
    suggestions.clear();
    final String encoded = jsonEncode(ApiEndpoints().url);
    final uurl = encoded.replaceAll('Querydata', query).replaceAll('6', '20');
    final decoded = jsonDecode(uurl);
    Uri uri = Uri.https(ApiEndpoints.jiosaavnSearchBase, '/api.php', decoded);
    final response = await http.get(uri);
    final res = jsonDecode(response.body);
    for (var item in res['results'].where((item) => item['type'] == 'song')) {
      suggestions.add(item['title']);
    }
    return suggestions;
  }
}
