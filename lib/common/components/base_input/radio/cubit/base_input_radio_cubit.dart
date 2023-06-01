import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_input_radio_state.dart';

class BaseInputRadioCubit<T> extends Cubit<BaseInputRadioState<T>> {
  BaseInputRadioCubit(T? itemSelected)
      : super(
          BaseInputRadioInitial<T>(itemSelected: itemSelected),
        );

  void changeCheckedItem(T? itemSelected) {
    emit(BaseInputRadioUpdate(itemSelected: itemSelected));
  }
}
