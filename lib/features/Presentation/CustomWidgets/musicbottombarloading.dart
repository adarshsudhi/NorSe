import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../configs/constants/Spaces.dart';
import '../Blocs/Musicbloc/audio_bloc/audio_bloc.dart';
import '../pages/MainHomePage/MainHomePage.dart';

class MusicBottomBarloading extends StatelessWidget {
  const MusicBottomBarloading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: Spaces.musicgradient()
            ),
            child: Center(
              child: ListTile(
                leading: const CircularProgressIndicator(
                  color: Colors.white,
                ),
                title: const Loadingcustomgradient(),
                subtitle: const Loadingcustomgradient(),
                trailing: SizedBox(
                  width: 150,
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                           BlocProvider.of<AudioBloc>(context).add(const AudioEvent.SeekPreviousAudio());
                        }, icon: const Icon(CupertinoIcons.backward_end_fill,color: Colors.white,size: 15,)),
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white
                          ),
                          child:  const Icon(CupertinoIcons.play_arrow,color: Colors.black,size: 19,),
                        ),
                        IconButton(onPressed: (){
                        }, icon: const Icon(CupertinoIcons.forward_end_fill,color: Colors.white,size: 15,))
                      ],
                    ),
                ),
              ),
            ),
          );
  }
}