import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../validation/validtor_status.dart';

part 'base_input_state.dart';

class BaseInputCubit extends Cubit<BaseInputState> {
  BaseInputCubit() : super(const BaseInputInitial(ValidatorStatus.notChecked, false));

  void updateState(ValidatorStatus status) {
    emit(BaseInputUpdate(status, state.focus));
  }

  void changeFocus(bool focus) {
    emit(BaseInputUpdate(state.statusValid, focus));
  }
}
