// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/injection_container.dart' as di;
import '../../../../../configs/Error/Errors.dart';
import '../../../../Domain/UseCases/Sql_UseCase/Getallrecents.dart';
import '../../../../Domain/UseCases/Sql_UseCase/clearallrecents_usecase.dart';

part 'recents_bloc.freezed.dart';
part 'recents_event.dart';
part 'recents_state.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
    final getallrecentUseCase getallrecent;
   RecentsBloc(
    this.getallrecent,
  ) : super(const _Initial()) {
      on<_Getallrecents>((event, emit) async{
       Either<Failures,List<Map<String,dynamic>>> res = await getallrecent.call();
       res.fold((l) {
        log('Recents Error');
       } , (r) {
        emit(RecentsState.recents(r));
       });
    });

    on<_Clearrecent>((event, emit) async{
       Either<Failures,bool> res = await di.di<Clearallrecentsusecase>().call();
       res.fold((l) {
        log('failed remove');
       }, (r) {
        log('Removed');
        emit(const RecentsState.recents([]));
       });
    });
  }
}
