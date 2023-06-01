import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/base_input_checkbox_item.dart';
part 'base_input_checkbox_state.dart';

class BaseInputCheckboxCubit<T> extends Cubit<BaseInputCheckboxState<T>> {
  BaseInputCheckboxCubit(itemsChecked)
      : super(
          BaseInputCheckboxInitial<T>(itemsChecked: itemsChecked),
        );
  void changeCheckedItem(List<BaseInputCheckboxItem<T>> items) {
    emit(BaseInputCheckboxUpdate<T>(itemsChecked: items));
  }
}
