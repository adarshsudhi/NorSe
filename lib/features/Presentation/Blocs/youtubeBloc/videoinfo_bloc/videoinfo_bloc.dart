import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/features/Domain/UseCases/yt_usecase/getvideoinfo_usecase.dart';
import 'package:nebula/injection_container.dart' as di;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../../configs/Error/Errors.dart';

part 'videoinfo_event.dart';
part 'videoinfo_state.dart';
part 'videoinfo_bloc.freezed.dart';

class VideoinfoBloc extends Bloc<VideoinfoEvent, VideoinfoState> {
  VideoinfoBloc() : super(const _Initial()) {
    on<_Getinfo>((event, emit)async{
        state.mapOrNull(info: (value) => emit(value.copyWith(isloading: true)),);
        Either<Failures, Video> res = await di.di<Getvideoinfousecase>().call(event.id);
        await res.fold((l) async{
          log('failed');
        }, (r) async=> emit(VideoinfoState.info(false,r)));
    });
  }
}
