import 'package:equatable/equatable.dart';

class BaseInputCheckboxItem<T> extends Equatable {
  final T value;
  final String label;
  final bool selected;

  const BaseInputCheckboxItem({
    required this.value,
    required this.label,
    this.selected = false,
  });

  @override
  List<Object?> get props => [value, label, selected];

  BaseInputCheckboxItem<T> copyWith({
    T? value,
    String? label,
    bool? selected,
  }) {
    return BaseInputCheckboxItem<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      selected: selected ?? this.selected,
    );
  }
}
