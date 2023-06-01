import 'package:equatable/equatable.dart';

import '../../../../validation/validtor_status.dart';

class BaseInputTextareaState extends Equatable {
  final ValidatorStatus statusValid;
  final bool focus;

  const BaseInputTextareaState(
    this.statusValid,
    this.focus,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [statusValid, focus];
}

class BaseInputTextareaInitial extends BaseInputTextareaState {
  const BaseInputTextareaInitial(
    super.statusValid,
    super.focus,
  );
}

class BaseInputTextareaUpdate extends BaseInputTextareaState {
  const BaseInputTextareaUpdate(
    super.statusValid,
    super.focus,
  );
}

class BaseInputTextareaChangeFocus extends BaseInputTextareaState {
  const BaseInputTextareaChangeFocus(
    super.statusValid,
    super.focus,
  );
}
