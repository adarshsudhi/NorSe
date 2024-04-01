import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nebula/features/Domain/UseCases/Sql_UseCase/usersearch_usecase.dart';
import '../Bloc/SearchSong_bloc/search_song_bloc.dart';
import '../Pages/subscreens/SearchResultPage/SearchResultPage.dart';
import 'package:nebula/injection_container.dart' as di;

class CustomSearchTextFormfield extends StatefulWidget {
   CustomSearchTextFormfield({
    Key? key,
    required this.ontap,
    required this.SearchController, required this.search,
  });

  final VoidCallback ontap;
  final bool search;
  final TextEditingController SearchController;

  @override
  State<CustomSearchTextFormfield> createState() => _CustomSearchTextFormfieldState();
}

class _CustomSearchTextFormfieldState extends State<CustomSearchTextFormfield> {
  @override
  Widget build(BuildContext context) {
    return Material(
   color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
           borderRadius: BorderRadius.circular(10),
         ),
           child: Padding(
          padding:  const EdgeInsets.only(left: 7, right: 7),
        child: TextFormField(
           //  onChanged: (value)
          //   {
          //      BlocProvider.of<SearchSongBloc>(context).add(Suggestions(query: value));
         //       setState(() {});
          //   },
             onFieldSubmitted: (value) async{
             if (widget.search) {
             BlocProvider.of<SearchSongBloc>(context).add(GetSearchSong(Querydata: value));
             Navigator.pushNamed(context,SearchResultscreen.Searchscreen,arguments: value);
            }
            BlocProvider.of<SearchSongBloc>(context).add(GetSearchSong(Querydata: value));
            await di.di<Usersearchusecase>().call('insert', value);
          }, 
          style: GoogleFonts.aBeeZee(color: Colors.black),
           controller: widget.SearchController,
                         decoration: InputDecoration(   
                            
                           prefixIcon: IconButton(onPressed: widget.ontap, icon: const Icon(Icons.search,color: Colors.black,)),
         hintText: 'Search songs,movies,artist ..',
         hintStyle: GoogleFonts.aldrich(fontSize: 14,color: Colors.black.withOpacity(0.4)),
            border: InputBorder.none),
                       ),
                   ),
                    ),
    );
  }
}
