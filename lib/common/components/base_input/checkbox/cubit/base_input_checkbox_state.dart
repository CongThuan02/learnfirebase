part of 'base_input_checkbox_cubit.dart';

abstract class BaseInputCheckboxState<T> extends Equatable {
  final List<BaseInputCheckboxItem<T>> itemsChecked;
  const BaseInputCheckboxState(this.itemsChecked);

  @override
  List<Object?> get props => [
        itemsChecked,
      ];
}

class BaseInputCheckboxInitial<T> extends BaseInputCheckboxState<T> {
  const BaseInputCheckboxInitial({
    itemsChecked,
  }) : super(
          itemsChecked,
        );
}

class BaseInputCheckboxUpdate<T> extends BaseInputCheckboxState<T> {
  const BaseInputCheckboxUpdate({
    itemsChecked,
  }) : super(
          itemsChecked,
        );
}
