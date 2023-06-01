part of 'base_multi_autocomplete_cubit.dart';

abstract class BaseMultiAutocompleteState<T> extends Equatable {
  final List<BaseMultiAutocompleteItem<T>> items;
  final List<BaseMultiAutocompleteItem<T>> itemsSelected;
  final List<BaseMultiAutocompleteItem<T>> itemsSearch;
  final bool switchSearch;
  const BaseMultiAutocompleteState(
    this.items,
    this.itemsSelected,
    this.itemsSearch,
    this.switchSearch,
  );

  @override
  List<Object?> get props => [
        items,
        itemsSelected,
        itemsSearch,
        switchSearch,
      ];
}

class BaseMultiAutocompleteInitial<T> extends BaseMultiAutocompleteState<T> {
  const BaseMultiAutocompleteInitial(
    super.items,
    super.itemsSelected,
    super.itemsSearch,
    super.switchSearch,
  );
}

class BaseMultiAutocompleteUpdateChecked<T> extends BaseMultiAutocompleteState<T> {
  const BaseMultiAutocompleteUpdateChecked({
    required List<BaseMultiAutocompleteItem<T>> items,
    required List<BaseMultiAutocompleteItem<T>> itemsSelected,
    required List<BaseMultiAutocompleteItem<T>> itemsSearch,
    required bool switchSearch,
  }) : super(
          items,
          itemsSelected,
          itemsSearch,
          switchSearch,
        );
}

class BaseMultiAutocompleteCancel<T> extends BaseMultiAutocompleteState<T> {
  const BaseMultiAutocompleteCancel({
    required List<BaseMultiAutocompleteItem<T>> items,
    required List<BaseMultiAutocompleteItem<T>> itemsSelected,
    required List<BaseMultiAutocompleteItem<T>> itemsSearch,
    required bool switchSearch,
  }) : super(
          items,
          itemsSelected,
          itemsSearch,
          switchSearch,
        );
}

class BaseMultiAutocompleteConfirm<T> extends BaseMultiAutocompleteState<T> {
  const BaseMultiAutocompleteConfirm({
    required List<BaseMultiAutocompleteItem<T>> items,
    required List<BaseMultiAutocompleteItem<T>> itemsSelected,
    required List<BaseMultiAutocompleteItem<T>> itemsSearch,
    required bool switchSearch,
  }) : super(
          items,
          itemsSelected,
          itemsSearch,
          switchSearch,
        );
}

class BaseMultiAutocompleteSearch<T> extends BaseMultiAutocompleteState<T> {
  const BaseMultiAutocompleteSearch({
    required List<BaseMultiAutocompleteItem<T>> items,
    required List<BaseMultiAutocompleteItem<T>> itemsSelected,
    required List<BaseMultiAutocompleteItem<T>> itemsSearch,
    required bool switchSearch,
  }) : super(
          items,
          itemsSelected,
          itemsSearch,
          switchSearch,
        );
}

class BaseMultiAutocompleteSwitchSearch<T> extends BaseMultiAutocompleteState<T> {
  const BaseMultiAutocompleteSwitchSearch({
    required List<BaseMultiAutocompleteItem<T>> items,
    required List<BaseMultiAutocompleteItem<T>> itemsSelected,
    required List<BaseMultiAutocompleteItem<T>> itemsSearch,
    required bool switchSearch,
  }) : super(
          items,
          itemsSelected,
          itemsSearch,
          switchSearch,
        );
}
