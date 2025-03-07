// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/spotify.dart' as spto;
import 'package:spotify/src/models/_models.dart' as spo;
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/features/Presentation/Blocs/spotify/spotifyapi_bloc/spotifyapi_bloc.dart';
import 'package:norse/features/Presentation/pages/spotify/songdetailspage/spotifyalbumtracks.dart';
import 'package:norse/features/Presentation/pages/spotify/songdetailspage/spotifyplaylistracks.dart';
import '../songdetailspage/spotifyartisttracks.dart';

class SpotifyHomePage extends StatefulWidget {
  const SpotifyHomePage({super.key});

  @override
  State<SpotifyHomePage> createState() => _SpotifyHomePageState();
}

class _SpotifyHomePageState extends State<SpotifyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<SpotifyapiBloc,SpotifyapiState>(builder:(context, state) {
        return state.maybeWhen(
          loading:()=>Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                color: Colors.black
              ),
              child: const Center(
                child:  SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(color: Colors.white,),
                ))),
          userSaved: ( userdetails, userplaylists, userartists, useralbums, recentlyplayed, savedalbums,api,user) {
           var images = (userdetails['images'] as List<spo.Image>);
           log(userdetails.toString());
            return Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                color: Colors.black
              ),
              child: Center(
                child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: images.isNotEmpty ? Image.network(images[0].url!) : Center(child: Textutil(text: userdetails['name'].toString().characters.first.toUpperCase(), fontsize: 30, color: Colors.white, fontWeight:FontWeight.bold))
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width/3,
                                          child: Textutil(text: userdetails['name'], fontsize: 20, color: Colors.white,
                                           fontWeight: FontWeight.bold),
                                        ),
                                       
                                      ],
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                         
                                          Image.asset(
                                            scale: 5,
                                              "assets/spotify.png",
                                             color:  const Color.fromARGB(255, 24, 162, 49),
                                           ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: size.width,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      const Textutil(text: "New Releases", fontsize: 20, color: Colors.white, fontWeight:FontWeight.bold),
                                     SizedBox(
                                        height: size.height / 4.5,
                                        child: NewReleases(newreleases: useralbums,spotifyApi: api,user: user,)),
                                      const Textutil(text: "Artist (top 10 tracks)", fontsize: 20, color: Colors.white, fontWeight:FontWeight.bold),
                                      SizedBox(
                                        height: size.height / 4.5,
                                        child: Artists(newreleases: userartists,user: user,spotifyApi: api,)),
                                          
                                      const Textutil(text: "Playlists", fontsize: 20, color: Colors.white, fontWeight:FontWeight.bold),
                                      SizedBox(
                                        height: size.height / 4.5,
                                        child: UserPlaylists(newreleases: userplaylists,spotifyApi: api,user: user,)),
                                      const Textutil(text: "Saved Albums", fontsize: 20, color: Colors.white, fontWeight:FontWeight.bold),
                                
                                     SizedBox(
                                        height: size.height / 4.5,
                                        child: NewReleases(newreleases: savedalbums,spotifyApi: api,user: user,))
                                    ],
                                  ),
                                ),
                              ),
                              Spaces.kheight20,
                              Spaces.kheight20,
                              Spaces.kheight20,
                            ],
                          ),
              ),
            );
          },
          orElse: ()=>Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => BlocProvider.of<SpotifyapiBloc>(context).add(SpotifyapiEvent.connectapi(context)),
            child: Container(
              height: 50,
              width: size.width/1.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 24, 162, 49)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Textutil(text: "Connect ", fontsize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  Image.asset(
                    scale: 7,
                    "assets/spotify.png",
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ));
      },),
    );
  }
}

class UserPlaylists extends StatelessWidget {
  List<spto.PlaylistSimple> newreleases;
  spto.SpotifyApi spotifyApi;
  spo.User user;
  UserPlaylists({
    Key? key,
    required this.newreleases,
    required this.spotifyApi,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: newreleases.length,
      itemBuilder:(context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (_)=>SpotifyPlaylistTracks(albumid: newreleases[index].id!,spotifyApi: spotifyApi,user: user,album: newreleases,)));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
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
                          imageUrl: newreleases[index].images![0].url!,
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
                            text: newreleases[index].name!,
                            fontsize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
        ),
      );
    },);
  }
}

class Artists extends StatelessWidget {
  List<spto.Artist> newreleases;
  spto.SpotifyApi spotifyApi;
  spo.User user;
  Artists({
    Key? key,
    required this.newreleases,
    required this.spotifyApi,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: newreleases.length,
      itemBuilder:(context, index) {
      return GestureDetector(
        onTap: () {
           Navigator.push(context,MaterialPageRoute(builder: (_)=>SpotifyArtistTracks(albumid: newreleases[index].id!,spotifyApi: spotifyApi,user: user,album: newreleases,index: index,)));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
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
                          imageUrl: newreleases[index].images![0].url!,
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
                            text: newreleases[index].name!,
                            fontsize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
        ),
      );
    },);
  }
}


class NewReleases extends StatelessWidget {
  List<spo.AlbumSimple> newreleases;
  spto.SpotifyApi spotifyApi;
  spo.User user;
  NewReleases({
    Key? key,
    required this.newreleases,
    required this.spotifyApi,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: newreleases.length,
      itemBuilder:(context, index) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: (){
             Navigator.push(context,MaterialPageRoute(builder: (_)=>SpotifyAlbumTracks(albumid: newreleases[index].id!,spotifyApi: spotifyApi,user: user,album: [newreleases[index]],)));
           // BlocProvider.of<SpotifyplaylistsoralbumBloc>(context).add(SpotifyplaylistsoralbumEvent.getalbumtracks(spotifyApi, user, newreleases[index].id!));
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
                          imageUrl: newreleases[index].images![0].url!,
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
                            text: newreleases[index].name!,
                            fontsize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
        ),
      );
    },);
  }
}
