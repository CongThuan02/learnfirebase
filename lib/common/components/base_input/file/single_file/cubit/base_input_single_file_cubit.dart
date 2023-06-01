import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_input_single_file_state.dart';

class BaseInputSingleFileCubit extends Cubit<BaseInputSingleFileState> {
  BaseInputSingleFileCubit(String? fileName) : super(BaseInputSingleFileInitial(fileName));
  void updateFileName(String? fileName) {
    emit(BaseInputSingleFileUpdate(fileName));
  }

  void deleteFileName(String? fileName) {
    emit(BaseInputSingleFileDelete(fileName = null));
  }
}
