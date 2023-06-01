import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../validation/validtor_status.dart';

part 'base_input_date_state.dart';

class BaseInputDateCubit extends Cubit<BaseInputDateState> {
  BaseInputDateCubit() : super(const BaseInputDateInitial(ValidatorStatus.notChecked));
  void updateState(ValidatorStatus status) {
    emit(BaseInputDateUpdate(status));
  }
}
