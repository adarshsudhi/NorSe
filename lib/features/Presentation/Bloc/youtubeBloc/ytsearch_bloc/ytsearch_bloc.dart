import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/features/Domain/UseCases/yt_usecase/getytplaylist_usecase.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:nebula/injection_container.dart' as di;

part 'ytsearch_event.dart';
part 'ytsearch_state.dart';
part 'ytsearch_bloc.freezed.dart';


class YtsearchBloc extends Bloc<YtsearchEvent, YtsearchState> {
  YtsearchBloc() : super( const _Initial()) {


    on<_Freestate>((event, emit)async{
      emit(const YtsearchState.loader());




     
      dynamic playlist1 = await di.di<Getplaylistusecase>().call('PLHuHXHyLu7BEnMJNeVvkXpxapvDSp5UdI', 'playlist');
      dynamic playlist0 = await di.di<Getplaylistusecase>().call('PLvOzZx-CNB835HVZYHCWDd_BCYlOGGf0c', 'playlist');
      dynamic playlist2 = await di.di<Getplaylistusecase>().call('PLHuHXHyLu7BHdV9kfWgHYPxwj57C_hSWw', 'playlist');



      emit(YtsearchState.fres(playlist0,playlist1,playlist2,false,false));

    });
  }
}

