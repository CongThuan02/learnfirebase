import 'package:equatable/equatable.dart';

class BaseMultiAutocompleteItem<T> extends Equatable {
  final T value;
  final String label;
  final bool selected;

  const BaseMultiAutocompleteItem({
    required this.value,
    required this.label,
    this.selected = false,
  });

  @override
  List<Object?> get props => [value, label, selected];

  BaseMultiAutocompleteItem<T> copyWith({
    T? value,
    String? label,
    bool? selected,
  }) {
    return BaseMultiAutocompleteItem<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      selected: selected ?? this.selected,
    );
  }
}
