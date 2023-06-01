part of 'base_input_date_cubit.dart';

abstract class BaseInputDateState extends Equatable {
  final ValidatorStatus statusValid;
  const BaseInputDateState(this.statusValid);

  @override
  List<Object> get props => [statusValid];
}

class BaseInputDateInitial extends BaseInputDateState {
  const BaseInputDateInitial(super.statusValid);
}

class BaseInputDateUpdate extends BaseInputDateState {
  const BaseInputDateUpdate(super.statusValid);
}
