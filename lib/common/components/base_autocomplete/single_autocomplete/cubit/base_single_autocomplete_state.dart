part of 'base_single_autocomplete_cubit.dart';

abstract class BaseSingleAutocompleteState<T> extends Equatable {
  final List<BaseSingleAutocompleteItem<T>>? items;
  final BaseSingleAutocompleteItem<T>? itemSlected;
  final ValidatorStatus statusValid;
  final bool loading;
  final bool focus;
  const BaseSingleAutocompleteState(
    this.items,
    this.itemSlected,
    this.statusValid,
    this.loading,
    this.focus,
  );

  @override
  List<Object?> get props => [
        statusValid,
        items,
        itemSlected,
        loading,
        focus,
      ];
}

class BaseSingleAutocompleteInitial<T> extends BaseSingleAutocompleteState<T> {
  const BaseSingleAutocompleteInitial({
    required List<BaseSingleAutocompleteItem<T>>? items,
    required BaseSingleAutocompleteItem<T>? itemSlected,
    required ValidatorStatus statusValid,
    required bool loading,
    required bool focus,
  }) : super(
          items,
          itemSlected,
          statusValid,
          loading,
          focus,
        );

  BaseSingleAutocompleteInitial<T> copyWith({
    List<BaseSingleAutocompleteItem<T>>? items,
    BaseSingleAutocompleteItem<T>? itemSlected,
    ValidatorStatus? statusValid,
    bool? loading,
    bool? focus,
  }) {
    return BaseSingleAutocompleteInitial<T>(
      items: items ?? this.items,
      itemSlected: itemSlected ?? this.itemSlected,
      statusValid: statusValid ?? this.statusValid,
      loading: loading ?? this.loading,
      focus: focus ?? this.focus,
    );
  }
}

class BaseSingleAutocompleteLoading<T> extends BaseSingleAutocompleteState<T> {
  const BaseSingleAutocompleteLoading({
    required List<BaseSingleAutocompleteItem<T>>? items,
    required BaseSingleAutocompleteItem<T>? itemSlected,
    required ValidatorStatus statusValid,
    required bool loading,
    required bool focus,
  }) : super(
          items,
          itemSlected,
          statusValid,
          loading,
          focus,
        );

  BaseSingleAutocompleteLoading<T> copyWith({
    List<BaseSingleAutocompleteItem<T>>? items,
    BaseSingleAutocompleteItem<T>? itemSlected,
    ValidatorStatus? statusValid,
    bool? loading,
    bool? focus,
  }) {
    return BaseSingleAutocompleteLoading<T>(
      items: items ?? this.items,
      itemSlected: itemSlected ?? this.itemSlected,
      statusValid: statusValid ?? this.statusValid,
      loading: loading ?? this.loading,
      focus: focus ?? this.focus,
    );
  }
}

class BaseSingleAutocompleteChangeSelect<T> extends BaseSingleAutocompleteState<T> {
  const BaseSingleAutocompleteChangeSelect({
    required List<BaseSingleAutocompleteItem<T>>? items,
    required BaseSingleAutocompleteItem<T>? itemSlected,
    required ValidatorStatus statusValid,
    required bool loading,
    required bool focus,
  }) : super(
          items,
          itemSlected,
          statusValid,
          loading,
          focus,
        );

  BaseSingleAutocompleteChangeSelect<T> copyWith({
    List<BaseSingleAutocompleteItem<T>>? items,
    BaseSingleAutocompleteItem<T>? itemSlected,
    ValidatorStatus? statusValid,
    bool? loading,
    bool? focus,
  }) {
    return BaseSingleAutocompleteChangeSelect<T>(
      items: items ?? this.items,
      itemSlected: itemSlected ?? this.itemSlected,
      statusValid: statusValid ?? this.statusValid,
      loading: loading ?? this.loading,
      focus: focus ?? this.focus,
    );
  }
}

class BaseSingleAutocompleteChangeFocus<T> extends BaseSingleAutocompleteState<T> {
  const BaseSingleAutocompleteChangeFocus({
    required List<BaseSingleAutocompleteItem<T>>? items,
    required BaseSingleAutocompleteItem<T>? itemSlected,
    required ValidatorStatus statusValid,
    required bool loading,
    required bool focus,
  }) : super(
          items,
          itemSlected,
          statusValid,
          loading,
          focus,
        );

  BaseSingleAutocompleteChangeFocus<T> copyWith({
    List<BaseSingleAutocompleteItem<T>>? items,
    BaseSingleAutocompleteItem<T>? itemSlected,
    ValidatorStatus? statusValid,
    bool? loading,
    bool? focus,
  }) {
    return BaseSingleAutocompleteChangeFocus<T>(
      items: items ?? this.items,
      itemSlected: itemSlected ?? this.itemSlected,
      statusValid: statusValid ?? this.statusValid,
      loading: loading ?? this.loading,
      focus: focus ?? this.focus,
    );
  }
}

class BaseSingleAutocompleteChangeStatus<T> extends BaseSingleAutocompleteState<T> {
  const BaseSingleAutocompleteChangeStatus({
    required List<BaseSingleAutocompleteItem<T>>? items,
    required BaseSingleAutocompleteItem<T>? itemSlected,
    required ValidatorStatus statusValid,
    required bool loading,
    required bool focus,
  }) : super(
          items,
          itemSlected,
          statusValid,
          loading,
          focus,
        );

  BaseSingleAutocompleteChangeStatus<T> copyWith({
    List<BaseSingleAutocompleteItem<T>>? items,
    BaseSingleAutocompleteItem<T>? itemSlected,
    ValidatorStatus? statusValid,
    bool? loading,
    bool? focus,
  }) {
    return BaseSingleAutocompleteChangeStatus<T>(
      items: items ?? this.items,
      itemSlected: itemSlected ?? this.itemSlected,
      statusValid: statusValid ?? this.statusValid,
      loading: loading ?? this.loading,
      focus: focus ?? this.focus,
    );
  }
}
