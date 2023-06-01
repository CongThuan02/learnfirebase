import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/base_muilti_autocomplete_item.dart';

part 'base_multi_autocomplete_state.dart';

class BaseMultiAutocompleteCubit<T> extends Cubit<BaseMultiAutocompleteState<T>> {
  BaseMultiAutocompleteCubit({
    required List<BaseMultiAutocompleteItem<T>> items,
    required List<BaseMultiAutocompleteItem<T>> itemsSelected,
  }) : super(
          BaseMultiAutocompleteInitial<T>(
            items,
            itemsSelected,
            items,
            false,
          ),
        );

  void toggleChecked(BaseMultiAutocompleteItem<T> value, bool checked) {
    final clone = [
      ...state.items.map((e) {
        if (e == value) {
          return e.copyWith(selected: checked);
        }
        return e;
      }).toList()
    ];
    final itemsSearch = [
      ...state.itemsSearch.map((e) {
        if (e == value) {
          return e.copyWith(selected: checked);
        }
        return e;
      }).toList()
    ];
    emit(
      BaseMultiAutocompleteUpdateChecked<T>(
        items: clone,
        itemsSelected: state.itemsSelected,
        itemsSearch: itemsSearch,
        switchSearch: state.switchSearch,
      ),
    );
  }

  void cancelAlertDialog(List<BaseMultiAutocompleteItem<T>> items) {
    final List<T> listSelect = items.where((element) => element.selected == true).map((e) => e.value).toList();
    final clone = [
      ...state.items.map((e) {
        if (listSelect.contains(e.value)) {
          return e.copyWith(selected: true);
        }
        return e.copyWith(selected: false);
      })
    ];
    emit(
      BaseMultiAutocompleteCancel(
        items: clone,
        itemsSelected: items,
        itemsSearch: clone,
        switchSearch: false,
      ),
    );
  }

  void confirmAlertDialog() {
    final selectItems = state.items.where((element) => element.selected == true).toList();
    emit(
      BaseMultiAutocompleteConfirm(
        items: state.items,
        itemsSelected: selectItems,
        itemsSearch: state.items,
        switchSearch: false,
      ),
    );
  }

  void switchCheck(bool change) {
    emit(
      BaseMultiAutocompleteSwitchSearch(
        items: state.items,
        itemsSelected: state.itemsSelected,
        itemsSearch: state.items,
        switchSearch: change,
      ),
    );
  }

  void search(String value) {
    final data = [...state.items.where((element) => element.label.contains(value)).toList()];
    emit(
      BaseMultiAutocompleteSwitchSearch(
        items: state.items,
        itemsSelected: state.itemsSelected,
        itemsSearch: data,
        switchSearch: state.switchSearch,
      ),
    );
  }
}
