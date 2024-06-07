import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nebula/features/Domain/UseCases/Sql_UseCase/usersearch_usecase.dart';
import '../Blocs/Musicbloc/SearchSong_bloc/search_song_bloc.dart';
import 'package:nebula/injection_container.dart' as di;
import '../pages/saavn/subscreens/SearchResultPage/SearchResultPage.dart';

class CustomSearchTextFormfield extends StatefulWidget {
  CustomSearchTextFormfield({
    Key? key,
    required this.ontap,
    required this.searchController,
    required this.search,
    required this.enableFocusNode,
  });

  final VoidCallback ontap;
  final bool search;
  final TextEditingController searchController;
  final bool enableFocusNode;

  @override
  State<CustomSearchTextFormfield> createState() =>
      _CustomSearchTextFormfieldState();
}

class _CustomSearchTextFormfieldState extends State<CustomSearchTextFormfield> {
  final node = FocusNode();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        widget.enableFocusNode ? node.requestFocus() : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 7, right: 7),
          child: TextFormField(
            focusNode: node,
            onFieldSubmitted: (value) async {
              if (widget.search) {
                BlocProvider.of<SearchSongBloc>(context)
                    .add(GetSearchSong(Querydata: value));
                Navigator.pushNamed(context, SearchResultscreen.searchscreen,
                    arguments: value);
              }
              BlocProvider.of<SearchSongBloc>(context)
                  .add(GetSearchSong(Querydata: value));
              await di.di<Usersearchusecase>().call('insert', value);
            },
            style: GoogleFonts.aBeeZee(color: Colors.black),
            controller: widget.searchController,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: widget.ontap,
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
                hintText: 'Search songs,movies,artist ..',
                hintStyle: GoogleFonts.aldrich(
                    fontSize: 14, color: Colors.black.withOpacity(0.4)),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
