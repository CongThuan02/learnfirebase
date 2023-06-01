part of 'base_input_multi_file_cubit.dart';

abstract class BaseInputMultiFileState extends Equatable {
  final List<String> fileNames;

  const BaseInputMultiFileState(this.fileNames);

  @override
  List<Object?> get props => [fileNames];
}

class BaseInputMultiFileInitial extends BaseInputMultiFileState {
  const BaseInputMultiFileInitial(super.fileNames);
}

class BaseInputMultiFileUpdate extends BaseInputMultiFileState {
  const BaseInputMultiFileUpdate(super.fileNames);
}

class BaseInputMultiFileDelete extends BaseInputMultiFileState {
  const BaseInputMultiFileDelete(super.fileNames);
}
