// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norse/features/Presentation/Blocs/Musicbloc/LocalSongs_bloc/localsong_bloc.dart';
import 'package:norse/features/Presentation/Blocs/Musicbloc/TagEditor_bloc/tageditor_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/features/Presentation/CustomWidgets/bgblur.dart';

class EditAudioTagsPage extends StatefulWidget {
  static const String editaudiotagspage = './editAuditagspage';
  const EditAudioTagsPage({
    Key? key,
    required this.audio,
  }) : super(key: key);
  final SongModel audio;

  @override
  State<EditAudioTagsPage> createState() => _EditAudioTagsPageState();
}

class _EditAudioTagsPageState extends State<EditAudioTagsPage> {
  final TextEditingController _titlecontroller = TextEditingController();

  final TextEditingController _artistcontroller = TextEditingController();

  final TextEditingController _albumcontroller = TextEditingController();

  final TextEditingController _ganrecontroller = TextEditingController();

  @override
  void initState() {
    _titlecontroller.text = widget.audio.title;
    _artistcontroller.text = widget.audio.artist ?? 'unkown';
    _albumcontroller.text = widget.audio.album ?? 'unkown';
    _ganrecontroller.text = widget.audio.genre ?? 'unkown';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _albumcontroller.dispose();
    _titlecontroller.dispose();
    _artistcontroller.dispose();
    _ganrecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Textutil(
            text: 'Edit Tags',
            fontsize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500),
        actions: [
          BlocBuilder<TageditorBloc, TageditorState>(
            builder: (context, state) {
              return state.maybeWhen(
                  loaded: () => UpdateDetails(
                      titlecontroller: _titlecontroller,
                      artistcontroller: _artistcontroller,
                      ganrecontroller: _ganrecontroller,
                      albumcontroller: _albumcontroller,
                      widget: widget),
                  loading: () {
                    return const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Laoding(),
                    );
                  },
                  orElse: () {
                    return UpdateDetails(
                        titlecontroller: _titlecontroller,
                        artistcontroller: _artistcontroller,
                        ganrecontroller: _ganrecontroller,
                        albumcontroller: _albumcontroller,
                        widget: widget);
                  });
            },
          ),
        ],
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            const BGblur(),
            widget.audio.displayNameWOExt.contains('yt')
                ? Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 100,
                      width: size.width,
                      child: const Column(
                        children: [
                          Textutil(
                              text: ' sorry for the inconvenience,',
                              fontsize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                          Textutil(
                              text:
                                  ' but youtube audio editing is currently not available.',
                              fontsize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                          Textutil(
                              text:
                                  " This feature will be coming soon. Thank you for your patience",
                              fontsize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spaces.kheight20,
                        QueryArtworkWidget(
                          keepOldArtwork: true,
                          id: widget.audio.id,
                          type: ArtworkType.AUDIO,
                          artworkFit: BoxFit.fitHeight,
                          artworkHeight: size.height / 3.5,
                          artworkWidth: size.width,
                          artworkBorder: BorderRadius.circular(10),
                          size: 1000,
                        ),
                        Spaces.kheight20,
                        Container(
                          height: 50,
                          width: 160,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Textutil(
                                  text: 'Change Cover',
                                  fontsize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Spaces.kheight20,
                        CustomTagEditorTextFormField(
                          size: size,
                          title: 'Title',
                          controller: _titlecontroller,
                        ),
                        Spaces.kheight20,
                        CustomTagEditorTextFormField(
                            size: size,
                            title: 'Album',
                            controller: _albumcontroller),
                        Spaces.kheight20,
                        CustomTagEditorTextFormField(
                            size: size,
                            title: 'Artist',
                            controller: _artistcontroller),
                        Spaces.kheight20,
                        CustomTagEditorTextFormField(
                            size: size,
                            title: 'Ganre',
                            controller: _ganrecontroller),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class UpdateDetails extends StatelessWidget {
  const UpdateDetails({
    super.key,
    required TextEditingController titlecontroller,
    required TextEditingController artistcontroller,
    required TextEditingController ganrecontroller,
    required TextEditingController albumcontroller,
    required this.widget,
  })  : _titlecontroller = titlecontroller,
        _artistcontroller = artistcontroller,
        _ganrecontroller = ganrecontroller,
        _albumcontroller = albumcontroller;

  final TextEditingController _titlecontroller;
  final TextEditingController _artistcontroller;
  final TextEditingController _ganrecontroller;
  final TextEditingController _albumcontroller;
  final EditAudioTagsPage widget;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          BlocProvider.of<TageditorBloc>(context).add(
              TageditorEvent.upatenewtagval(
                  _titlecontroller.text,
                  _artistcontroller.text,
                  _ganrecontroller.text,
                  _albumcontroller.text,
                  widget.audio.data));
          BlocProvider.of<LocalsongBloc>(context)
              .add(const LocalsongEvent.getallsongs());
        },
        child: const Textutil(
            text: 'Save',
            fontsize: 20,
            color: Colors.orange,
            fontWeight: FontWeight.w600));
  }
}

class Laoding extends StatelessWidget {
  const Laoding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}

class CustomTagEditorTextFormField extends StatelessWidget {
  const CustomTagEditorTextFormField({
    Key? key,
    required this.size,
    required this.title,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Spaces.Getstyle(14, Colors.white, FontWeight.normal),
      controller: controller,
      cursorColor: Colors.white,
      autocorrect: true,
      decoration: InputDecoration(
        helperText: title,
        hintFadeDuration: const Duration(seconds: 1),
        hintStyle: Spaces.Getstyle(
            14, Colors.white.withOpacity(0.6), FontWeight.normal),
        hintText: title,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 3)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
