
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_controller_state.dart';

class LoadingControllerCubit extends Cubit<LoadingControllerState> {
  LoadingControllerCubit() : super(LoadingControllerInitial());
}
