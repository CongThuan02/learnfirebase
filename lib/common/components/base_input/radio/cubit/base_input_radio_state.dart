part of 'base_input_radio_cubit.dart';

abstract class BaseInputRadioState<T> extends Equatable {
  final T? itemSelected;
  const BaseInputRadioState(this.itemSelected);

  @override
  List<Object?> get props => [
        itemSelected,
      ];
}

class BaseInputRadioInitial<T> extends BaseInputRadioState<T> {
  const BaseInputRadioInitial({
    T? itemSelected,
  }) : super(
          itemSelected,
        );
}

class BaseInputRadioUpdate<T> extends BaseInputRadioState<T> {
  const BaseInputRadioUpdate({
    T? itemSelected,
  }) : super(
          itemSelected,
        );
}
