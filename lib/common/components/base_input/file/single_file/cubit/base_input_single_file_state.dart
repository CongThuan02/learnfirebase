part of 'base_input_single_file_cubit.dart';

abstract class BaseInputSingleFileState extends Equatable {
  final String? fileName;

  const BaseInputSingleFileState(this.fileName);

  @override
  List<Object?> get props => [fileName];
}

class BaseInputSingleFileInitial extends BaseInputSingleFileState {
  const BaseInputSingleFileInitial(super.fileName);
}

class BaseInputSingleFileUpdate extends BaseInputSingleFileState {
  const BaseInputSingleFileUpdate(super.fileName);
}

class BaseInputSingleFileDelete extends BaseInputSingleFileState {
  const BaseInputSingleFileDelete(super.fileName);
}
