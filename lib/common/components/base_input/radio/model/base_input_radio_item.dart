import 'package:equatable/equatable.dart';

class BaseInputRadioItem<T> extends Equatable {
  final T value;
  final String label;

  const BaseInputRadioItem({
    required this.value,
    required this.label,
  });

  @override
  List<Object?> get props => [value, label];

  BaseInputRadioItem<T> copyWith({
    T? value,
    String? label,
  }) {
    return BaseInputRadioItem<T>(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }
}
