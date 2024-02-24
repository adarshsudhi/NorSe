import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/configs/Error/Errors.dart';
import 'package:nebula/features/Domain/UseCases/yt_usecase/getsearchvideo_usecase.dart';
import 'package:nebula/features/Domain/UseCases/yt_usecase/getytplaylist_usecase.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:nebula/injection_container.dart' as di;


part 'ytsearch_event.dart';
part 'ytsearch_state.dart';
part 'ytsearch_bloc.freezed.dart';


class YtsearchBloc extends Bloc<YtsearchEvent, YtsearchState> {
  YtsearchBloc() : super( const _Initial()) {
    on<_Getsearch>((event, emit) async{
       emit(const YtsearchState.loader());
       dartz.Either<Failures,VideoSearchList> videos = await di.di<Getsearchvideousecase>().call(event.query);
       videos.fold((l) {
        throw Exception('youtube search failed');
       }, (r) {
         emit(YtsearchState.searchedvideo(r,false,false));
       });
    });
    on<_Freestate>((event, emit)async{
      dartz.Either<Failures,dynamic> playlist0 = await di.di<Getplaylistusecase>()
      .call('https://www.youtube.com/watch?v=gvyUuxdRdR4&list=PLHuHXHyLu7BEnMJNeVvkXpxapvDSp5UdI', 'playlist');
      dartz.Either<Failures,dynamic> playlist1 = await di.di<Getplaylistusecase>()
      .call('https://www.youtube.com/watch?v=VAdGW7QDJiU&list=PLO7-VO1D0_6NmK47v6tpOcxurcxdW-hZa&pp=iAQB','playlist');
      if (await state.maybeWhen(
        fres: (videos, videos1, isloading, isfailed) {
          if (videos.isEmpty) {
            return false;
          } else {
            return true;
          }
        },
        orElse: ()=>true)) 
        {
        emit(const YtsearchState.loader());
        await playlist1.fold((l)async{
        throw Exception('playllist fetch failed');
      }, (r) async {
         if (r is List<Video>) {
            await playlist0.fold((l) async{
               throw Exception('playlistfailed0');
            }, (t) {
              if (t is List<Video>) {
                 emit(YtsearchState.fres(r,t,false, false));
              }
            });
         }
      });
        }

    });
  }
}

