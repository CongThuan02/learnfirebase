import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_input_multi_file_state.dart';

class BaseInputMultiFileCubit extends Cubit<BaseInputMultiFileState> {
  BaseInputMultiFileCubit(List<String> fileNames) : super(BaseInputMultiFileInitial(fileNames));
  void updateFileName(List<String> fileNames) {
    emit(BaseInputMultiFileUpdate(fileNames));
  }

  void deleteFileName() {
    emit(const BaseInputMultiFileDelete([]));
  }
}
