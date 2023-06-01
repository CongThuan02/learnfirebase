import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../validation/validtor_status.dart';
import 'base_input_textarea_state.dart';

class BaseInputTextareaCubit extends Cubit<BaseInputTextareaState> {
  BaseInputTextareaCubit() : super(const BaseInputTextareaState(ValidatorStatus.notChecked, false));
  void updateState(ValidatorStatus status) {
    emit(BaseInputTextareaUpdate(status, state.focus));
  }

  void changeFocus(bool focus) {
    emit(BaseInputTextareaUpdate(state.statusValid, focus));
  }
}
