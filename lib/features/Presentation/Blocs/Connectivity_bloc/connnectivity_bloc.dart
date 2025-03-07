import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connnectivity_event.dart';
part 'connnectivity_state.dart';
part 'connnectivity_bloc.freezed.dart';

class ConnnectivityBloc extends Bloc<ConnnectivityEvent, ConnnectivityState> {
  ConnnectivityBloc() : super(const _Initial()) {
    StreamSubscription<List<ConnectivityResult>>? connectionStream;

    on<_StartService>((event, emit) async {
      await connectionStream?.cancel();

      connectionStream = Connectivity().onConnectivityChanged.listen(null);

      connectionStream!.onData((List<ConnectivityResult> data) async {
        if (data.isNotEmpty) {
          add(ConnnectivityEvent.getConnectionstatus(data));
        }
      });
    });

    on<_Connectivity>((event, emit) async {
      if (event.data.contains(ConnectivityResult.none)) {
        emit(const ConnnectivityState.networkstate(false));
      } else {
        emit(const ConnnectivityState.networkstate(true));
      }
    });
  }
}
