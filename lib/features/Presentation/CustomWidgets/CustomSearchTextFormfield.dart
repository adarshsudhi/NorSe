// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nebula/features/Presentation/Pages/subscreens/SearchResultPage/SearchResultPage.dart';
import '../Bloc/SearchSong_bloc/search_song_bloc.dart';




class CustomSearchTextFormfield extends StatelessWidget {
  const CustomSearchTextFormfield({
    Key? key,
    required this.ontap,
    required this.SearchController, required this.search,
  });

  final VoidCallback ontap;
  final bool search;
  final TextEditingController SearchController;

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
          onFieldSubmitted: (value) {
            if (search) {
             BlocProvider.of<SearchSongBloc>(context).add(GetSearchSong(Querydata: value));
             Navigator.pushNamed(context,SearchResultscreen.Searchscreen,arguments: value);
            }
            BlocProvider.of<SearchSongBloc>(context).add(GetSearchSong(Querydata: value));
          },
          style: GoogleFonts.aBeeZee(color: Colors.black),
           controller: SearchController,
                         decoration: InputDecoration(   
                            
                           prefixIcon: IconButton(onPressed: ontap, icon: const Icon(Icons.search,color: Colors.black,)),
         hintText: 'Search songs,movies,artist ..',
         hintStyle: GoogleFonts.aldrich(fontSize: 14,color: Colors.black.withOpacity(0.4)),
            border: InputBorder.none),
                       ),
                   ),
                    ),
    );
  }
}
