import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Presentation/Bloc/Download_Bloc/download_song_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/LocalData/localdata_bloc.dart';
import 'package:nebula/injection_container.dart' as di;
import '../../../Domain/UseCases/Sql_UseCase/initializedatabase_Usecase.dart';


class Downloadpage extends StatefulWidget {
  static const String Downloadscreen = "/downloadscreen";
  const Downloadpage({super.key});

  @override
  State<Downloadpage> createState() => _DownloadpageState();
}

class _DownloadpageState extends State<Downloadpage> {

  @override
  void initState() {
    super.initState();
      di.di<initializedbusecase>().call();
     BlocProvider.of<LocaldataBloc>(context).add(const LocaldataEvent.getDownloads());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
     backgroundColor: Colors.transparent,
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       leading: IconButton(onPressed: (){
          Navigator.pop(context);
       }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
       centerTitle: true,
       title: Text("Downloads",style: Spaces.Getstyle(25, Colors.white,FontWeight.bold),),
     ),
     body: const DownlaodQueue()
    );
  }
}

class DownlaodQueue extends StatelessWidget {
  const DownlaodQueue({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                           Color.fromARGB(255, 2, 1, 19),
                           Color.fromARGB(255, 0, 0, 0)
            ])
          ),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: SafeArea(
            child: Column(
              children: [
             SizedBox(
               height: 80,
               width: double.infinity,
               child: Downloadswidget(ontap: () {
                BlocProvider.of<LocaldataBloc>(context).add(const LocaldataEvent.clearalldownloads());
               },iconData: Icons.clear_all_outlined,title: "Clear Downloads",),
             ),
             Expanded(
               child: BlocBuilder<LocaldataBloc,LocaldataState>(
                 builder: (context, state) {
                     return state.maybeWhen(orElse:() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    child: Image.asset('assets/folder.png')),
                  Text('Nothing here',style: Spaces.Getstyle(15,Colors.white,FontWeight.bold),)
                ],
              );
                     },
            querys: (isloading, fail, downloads) {
               if (downloads.isNotEmpty) {
                 return ListView.builder(
              itemCount: downloads.length,
              itemBuilder:(context, index) {
                final data = downloads[index];
                 return Tilesitems(data: data,index: index,songs: downloads,);
            },); 
               } else {
                 return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    child: Image.asset('assets/folder.png')),
                    Textutil(text: 'No files in the downloads queue', fontsize:18, color: Colors.white.withOpacity(0.3), fontWeight:FontWeight.normal)
                ],
              );
               }
            },
                     );
                     
                     })
             ),
              ],
            ),
          ),
        ),
    );

  }
}


class Tilesitems extends StatefulWidget {
  final Map<String,dynamic> data;
  final List<Map<String,dynamic>> songs;
  final int index;
  const Tilesitems({
    Key? key,
    required this.data,
    required this.songs,
    required this.index,
  }) : super(key: key);

  @override
  State<Tilesitems> createState() => _tilesitemsState();
}

class _tilesitemsState extends State<Tilesitems> {

   _downloaddata()async{
     BlocProvider.of<DownloadSongBloc>(context).add(DownloadStated(
                 itemstreamindex:widget.index,
                key:widget.data['id'],
                 url:widget. data['downloadurl'],
                 albumname: widget.data['albumname'],
                  songname:widget. data['title'],
                   artworkurl:widget. data['imageurl'],
                    artists:widget. data['artist'],context: context));
                    setState(() {});
   }


  @override
  Widget build(BuildContext context) {
    return Dismissible(
       onDismissed: (direction) {
       BlocProvider.of<LocaldataBloc>(context).add(LocaldataEvent.removefromdownloads(widget.data['id']));
       },
      background: const SizedBox(
        width: double.infinity,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete,color: Colors.red,size: 20,),
            SizedBox(width: 30,),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      key: Key(widget.data['key'].toString()), child: ListTile(
      trailing: BlocBuilder<DownloadSongBloc,DownloadSongState>(
        builder: (context, state) {
          if (state is DownloadSongStarted) {
             return state.streams.isEmpty? 
              IconButton(onPressed: (){
                   _downloaddata();
                  },icon: const Icon(Icons.download,color: Colors.white,size: 20,))
              :SizedBox(
              height: 50,
              width: 50,
              child: state.streams.any((element) => element['id'] == widget.data['id']) ? (state.streams.firstWhere((element) => element['id'] == widget.data['id'])['id']) == widget.data['id'] ?
               StreamBuilder(stream: (state.streams.firstWhere((element) => element['id'] == widget.data['id'])['stream'] as StreamController<double>).stream,
                              builder:(context, snapshot) {
               
                if (snapshot.hasData && snapshot.data != null) {
                   return snapshot.connectionState == ConnectionState.waiting ? const SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(color: Colors.white,)) :Stack(
                     alignment: Alignment.center,
                     children: [
                       CircularProgressIndicator(value: snapshot.data!/100,color: const Color.fromARGB(255, 0, 4, 255),strokeWidth: 5,),
                       Text(snapshot.data!.toStringAsFixed(0),style: Spaces.Getstyle(10,Colors.white,FontWeight.normal),)    
                     ],
                   );
                }else{
                 return IconButton(onPressed: (){
                  _downloaddata(); 
                 },icon: const Icon(Icons.download,color: Colors.white,size: 20,));
                }
                              },): IconButton(onPressed: (){
                    _downloaddata();
                  },icon: const Icon(Icons.download,color: Colors.white,size: 20,)):IconButton(onPressed: (){
                    _downloaddata();
                  },icon: const Icon(Icons.download,color: Colors.white,size: 20,))
             );
          }else{
            return IconButton(onPressed: (){
              _downloaddata();
            },icon: const Icon(Icons.download,color: Colors.white,size: 20,));
          }
        },
      ),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: CachedNetworkImageProvider(widget. data['imageurl']),
      ),
      title: Text(widget.data['title'],style:Spaces.Getstyle(15,Colors.white,FontWeight.bold),overflow: TextOverflow.ellipsis,),
      subtitle: Text(widget.data['artist'],style:Spaces.Getstyle(12,Colors.white.withOpacity(0.5),FontWeight.normal),overflow: TextOverflow.ellipsis,),
     ));
  }
}

class Downloadswidget extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  final IconData iconData;
  const Downloadswidget({
    Key? key,
    required this.ontap,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(onPressed: ontap, icon:  Icon(iconData,color: Colors.white,), label: Text(title,style: Spaces.Getstyle(10,Colors.white,FontWeight.normal),));
  }
}
