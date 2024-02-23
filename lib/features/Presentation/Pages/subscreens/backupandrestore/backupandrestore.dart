import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/features/Presentation/Bloc/backupandrestorebloc/bloc/backup_and_restore_bloc.dart';

import '../../../../../configs/constants/Spaces.dart';

class Backupandrestore extends StatelessWidget {
  static const String backupandrestore = './backuprestore';
  const Backupandrestore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 20,)),
        title: const Textutil(text: 'Backup & restore', fontsize: 23, color: Colors.white, fontWeight: FontWeight.normal),
      ),
      body: Stack(
        children: [
          Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
              Colors.indigo,
              Colors.black
            ])
          ),
        ),  
                  Container(
            color: Colors.black.withOpacity(0.8),
          ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Spaces.Kheight20,
                ListTile(
                onTap: () {
                 BlocProvider.of<BackupAndRestoreBloc>(context).add(const BackupAndRestoreEvent.backup());
                 },
                 leading: const Icon(Icons.backup,color: Colors.white,size: 21,),
                 title: const Textutil(text: 'Backup Data', fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                 subtitle: Textutil(text: 'Saves the data in the Documents folder', fontsize: 9, color: Colors.white.withOpacity(0.6), fontWeight: FontWeight.normal),
                  ),
                  ListTile(
                     onTap: () {
                    BlocProvider.of<BackupAndRestoreBloc>(context).add(const BackupAndRestoreEvent.restore());
                    },
                  leading: const Icon(Icons.restore,color: Colors.white,size: 21,),
                  title: const Textutil(text: 'Restore Data', fontsize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                  subtitle: Textutil(text: 'Restore the Data from Documents folder', fontsize: 9, color: Colors.white.withOpacity(0.6), fontWeight: FontWeight.normal),
                                  )
              ],
            ),
          ),
        )
        ],
      )
    );
  }
}