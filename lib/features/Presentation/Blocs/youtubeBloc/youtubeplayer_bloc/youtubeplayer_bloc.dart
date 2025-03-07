import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:norse/configs/notifier/notifiers.dart';
import 'package:norse/injection_container.dart' as di;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../../../configs/constants/Spaces.dart';
import '../../../../Domain/UseCases/yt_usecase/getvideoinfo_usecase.dart';
import '../../../pages/Youtube/youtubeplayer/testytplayerscreen.dart';

part 'youtubeplayer_event.dart';
part 'youtubeplayer_state.dart';
part 'youtubeplayer_bloc.freezed.dart';

class YoutubeplayerBloc extends Bloc<YoutubeplayerEvent, YoutubeplayerState> {
  YoutubeplayerBloc() : super(const _Initial()) {

    on<_Started>((event, emit) => emit(const YoutubeplayerState.initial()));
    on<_SwitchEvent>((event, emit) {
      controller.pauseVideo();
      emit(const YoutubeplayerState.switchstate());
    });
    on<_YtPlayerEvent>((event, emit) async {

      emit(YoutubeplayerState.youtubeplayerstate({},event.index, event.vidoes, true, false,)); 

       bool islatevarint = Spaces.isLateVarInitialized();

     if (islatevarint) {

       controller.loadVideoById(videoId: event.vidoes[event.index].id.toString());

       Map<String, dynamic> infomap =
        await di.di<Getvideoinfousecase>().call(event.vidoes[event.index].id.toString());
    
       state.mapOrNull(youtubeplayerstate: (value) => emit(value.copyWith(info: infomap,isloading: false)),);
       Notifiers.loadingnotifer.value = false;

     } else {
        controller = YoutubePlayerController(
            params: const YoutubePlayerParams(
              
            showFullscreenButton: false,
            enableJavaScript: false,
            playsInline: true,
        ));

        controller.loadVideoById(videoId: event.vidoes[event.index].id.toString());

      Map<String, dynamic> infomap =
        await di.di<Getvideoinfousecase>().call(event.vidoes[event.index].id.toString());

       emit(YoutubeplayerState.youtubeplayerstate(infomap,event.index, event.vidoes, false, false)); 
       
     }
    });
  }
}
