part of 'base_input_cubit.dart';

abstract class BaseInputState extends Equatable {
  final ValidatorStatus statusValid;
  final bool focus;
  const BaseInputState(
    this.statusValid,
    this.focus,
  );

  @override
  List<Object> get props => [
        statusValid,
        focus,
      ];
}

class BaseInputInitial extends BaseInputState {
  const BaseInputInitial(
    super.statusValid,
    super.focus,
  );
}

class BaseInputUpdate extends BaseInputState {
  const BaseInputUpdate(
    super.statusValid,
    super.focus,
  );
}

class BaseInputChangeFocus extends BaseInputState {
  const BaseInputChangeFocus(
    super.statusValid,
    super.focus,
  );
}
