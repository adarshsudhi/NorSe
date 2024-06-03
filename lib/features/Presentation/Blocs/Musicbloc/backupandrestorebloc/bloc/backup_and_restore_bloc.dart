import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Domain/UseCases/Platform_UseCase/backupdata_usecase.dart';
import 'package:nebula/features/Domain/UseCases/Platform_UseCase/restoredata_usecase.dart';
import 'package:nebula/injection_container.dart' as di;

part 'backup_and_restore_event.dart';
part 'backup_and_restore_state.dart';
part 'backup_and_restore_bloc.freezed.dart';

class BackupAndRestoreBloc extends Bloc<BackupAndRestoreEvent, BackupAndRestoreState> {
  BackupAndRestoreBloc() : super(const _Initial()) {
    on<_Backup>((event, emit) async{
       final res = await di.di<Backupdatausecase>().call();
       res.fold((l) {
        throw Exception('backup failed');
       }, (r) {
        Spaces.showtoast('Backedup');
       });
    });

    on<_Restore>((event, emit) async{
       final res = await di.di<Restoredatausecase>().call();
       res.fold((l) {
        throw Exception('restore failed');
       }, (r) {
        Spaces.showtoast('Restored Restart Required');
       });
    });
  }
}
