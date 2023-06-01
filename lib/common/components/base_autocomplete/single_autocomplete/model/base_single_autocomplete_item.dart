import 'package:equatable/equatable.dart';

class BaseSingleAutocompleteItem<T> extends Equatable {
  final T value;
  final String label;

  const BaseSingleAutocompleteItem({
    required this.value,
    required this.label,
  });

  @override
  List<Object?> get props => [value, label];

  BaseSingleAutocompleteItem<T> copyWith({
    T? value,
    String? label,
  }) {
    return BaseSingleAutocompleteItem<T>(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }
}
