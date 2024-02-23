class ApiEndpoints{
   static const String baseurl =  'https://server-steel-eight.vercel.app';
  
   static const String GetTrendinglanguages = '$baseurl/modules?language=';
   static const String GetAlbumSongs = '$baseurl/albums?link=';
   static const String SearchEndpoint = '$baseurl/search/songs?query=';
   static const String GetNewRelease = 'https://www.jiosaavn.com/api.php?';
   static const String Getlyrics = '$baseurl/lyrics?id=';
   static const String GetSong = "$baseurl/songs?link=";
   static const String jiosaavnSearchBase = "www.jiosaavn.com";
   static const String jiosaavnpara = '/api.php?_format=json&_marker=0&api_version=4&ctx=web6dot0&';
   static const String playlistbase = '$baseurl/playlists?id=';
   
  final String jiosaavnSearchSong = '&n=10&__call=search.getResults';
  final String GetTopSeraches = 'content.getTopSearches';
  
  Map<String,dynamic> url = {
    '_format': 'json',
    '_marker': '0',
    'api_version': '4',
    'ctx': 'web6dot0',
    'p': '1',
    'q': 'Querydata',
    'n': '50',
    '__call': 'search.getResults',
   };

     final qualities = [
    {'id': '_12', 'bitrate': '12kbps'},
    {'id': '_48', 'bitrate': '48kbps'},
    {'id': '_96', 'bitrate': '96kbps'},
    {'id': '_160', 'bitrate': '160kbps'},
    {'id': '_320', 'bitrate': '320kbps'},
  ];
}