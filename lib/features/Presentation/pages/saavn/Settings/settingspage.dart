import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:norse/configs/constants/Spaces.dart';
import 'package:norse/configs/notifier/notifiers.dart';
import 'package:norse/features/Presentation/Blocs/Musicbloc/playerui_bloc/playerui_bloc.dart';
import '../Aboutpage/aboutpage.dart';
import '../subscreens/backupandrestore/backupandrestore.dart';

class Settingpage extends StatefulWidget {
  static const String settingpage = './settingpage';
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  String? dropDownValue = 'UI 1';

  String? dropDownAudiovalue = '96kbps.low';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PlayeruiBloc>(context)
        .add(const PlayeruiEvent.getplayerui());
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              )),
          title: const Textutil(
              text: 'Settings',
              fontsize: 23,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Spaces.kheight20,
                    BlocBuilder<PlayeruiBloc, PlayeruiState>(
                      builder: (context, state) {
                        return state.maybeWhen(playerui: (ui) {
                          String? val = ui['uitype'];
                          return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                CupertinoIcons.music_note_2,
                                color: Colors.white,
                                size: 20,
                              ),
                              title: const Textutil(
                                  text: 'Audio Quality',
                                  fontsize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              trailing: DropdownButton<String>(
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(20),
                                dropdownColor: Colors.black,
                                value: val,
                                onChanged: (value) {
                                  setState(() => val = value);
                                  Notifiers.qualityNotifier.value =
                                      value!.split('.')[0];
                                  BlocProvider.of<PlayeruiBloc>(context)
                                      .add(PlayeruiEvent.updateui(value));
                                  BlocProvider.of<PlayeruiBloc>(context)
                                      .add(const PlayeruiEvent.getplayerui());
                                },
                                items: [
                                  "96kbps.low",
                                  "160kbps.medium",
                                  "360kbps.high"
                                ]
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                                value: value,
                                                child: Textutil(
                                                    text: value,
                                                    fontsize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)))
                                    .toList(),
                              ));
                        }, orElse: () {
                          return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                CupertinoIcons.music_note_2,
                                color: Colors.white,
                                size: 20,
                              ),
                              title: const Textutil(
                                  text: 'Audio Quality',
                                  fontsize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              trailing: DropdownButton<String>(
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(20),
                                dropdownColor: Colors.black,
                                value: dropDownAudiovalue,
                                onChanged: (value) {
                                  setState(() => dropDownAudiovalue = value);
                                  Notifiers.qualityNotifier.value =
                                      value!.split('.')[0];
                                  BlocProvider.of<PlayeruiBloc>(context)
                                      .add(PlayeruiEvent.updateui(value));
                                  BlocProvider.of<PlayeruiBloc>(context)
                                      .add(const PlayeruiEvent.getplayerui());
                                },
                                items: [
                                  "96kbps.low",
                                  "160kbps.medium",
                                  "360kbps.high"
                                ]
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                                value: value,
                                                child: Textutil(
                                                    text: value,
                                                    fontsize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)))
                                    .toList(),
                              ));
                        });
                      },
                    ),
                    SettignsTile(
                      title: 'Backup & Restore',
                      subtitle: "Backup data",
                      iconData: Icons.restore,
                      ontap: () => Navigator.pushNamed(
                          context, Backupandrestore.backupandrestore),
                    ),
                    SettignsTile(
                      title: 'About',
                      subtitle: "NorSe",
                      iconData: Icons.info_outline_rounded,
                      ontap: () =>
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>const Aboutpage())),
                    ),
                    Spaces.kheight10,
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class SettignsTile extends StatelessWidget {
  const SettignsTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.ontap,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final IconData iconData;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: ontap,
      leading: Icon(
        iconData,
        color: Colors.white,
        size: 20,
      ),
      title: Textutil(
          text: title,
          fontsize: 15,
          color: Colors.white,
          fontWeight: FontWeight.normal),
    );
  }
}
