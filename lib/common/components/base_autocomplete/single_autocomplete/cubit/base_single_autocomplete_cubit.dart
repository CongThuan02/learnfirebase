import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../validation/validtor_status.dart';
import '../model/base_single_autocomplete_item.dart';
import '../widgets/base_filterable_list.dart';

part 'base_single_autocomplete_state.dart';

class BaseSingleAutocompleteCubit<T> extends Cubit<BaseSingleAutocompleteState<T>> {
  late TextEditingController controllerInternal;
  late BuildContext _context;
  final LayerLink layerLink = LayerLink();
  late final Widget Function(T data)? _suggestionBuilder;
  late final Widget? _progressIndicatorBuilder;
  late final Function(String)? _onChanged;
  late final Function(String)? _onSubmitted;
  late final List<BaseSingleAutocompleteItem<T>> Function(List<BaseSingleAutocompleteItem<T>>, String)? _optionsBuilder;
  late final Future<List<BaseSingleAutocompleteItem<T>>> Function(String)? _asyncSuggestions;
  late final Duration _debounceDuration;

  late final double _elevation;
  late final double _maxListHeight;
  late final TextStyle _suggestionTextStyle;
  late final Color? _suggestionBackgroundColor;
  late final Widget Function(T)? _itemWidget;
  late final Function(T?)? _onSelected;
  /////
  bool _hasOpenedOverlay = false;
  OverlayEntry? _overlayEntry;
  List<BaseSingleAutocompleteItem<T>> _suggestions = [];
  Timer? _debounce;
  String _previousAsyncSearchText = '';
  late FocusNode focusNodeInternal;

  BaseSingleAutocompleteCubit(
    List<BaseSingleAutocompleteItem<T>>? items,
    BaseSingleAutocompleteItem<T>? itemSelected,
  ) : super(
          BaseSingleAutocompleteInitial<T>(
            items: items,
            itemSlected: itemSelected,
            statusValid: ValidatorStatus.notChecked,
            loading: false,
            focus: false,
          ),
        );
  void init({
    required TextEditingController controller,
    required BuildContext context,
    required Widget Function(T data)? suggestionBuilder,
    required final Widget? progressIndicatorBuilder,
    required Function(String)? onChanged,
    required Function(String)? onSubmitted,
    required List<BaseSingleAutocompleteItem<T>> Function(List<BaseSingleAutocompleteItem<T>>, String)? optionsBuilder,
    required Future<List<BaseSingleAutocompleteItem<T>>> Function(String)? asyncSuggestions,
    required FocusNode focusNode,
    Duration? debounceDuration,
    double? elevation,
    double? maxListHeight,
    TextStyle? suggestionTextStyle,
    Color? suggestionBackgroundColor,
    Widget Function(T)? itemWidget,
    Function(T?)? onSelected,
  }) {
    controllerInternal = controller;
    _context = context;
    _suggestionBuilder = suggestionBuilder;
    _progressIndicatorBuilder = progressIndicatorBuilder;
    _onChanged = onChanged;
    _onSubmitted = onSubmitted;
    _optionsBuilder = optionsBuilder;
    _asyncSuggestions = asyncSuggestions;
    _debounceDuration = debounceDuration ?? const Duration(milliseconds: 400);
    focusNodeInternal = focusNode;
    _elevation = elevation ?? 5;
    _maxListHeight = maxListHeight ?? 150;
    _suggestionTextStyle = suggestionTextStyle ?? const TextStyle();
    _suggestionBackgroundColor = suggestionBackgroundColor;
    _itemWidget = itemWidget;
    _onSelected = onSelected;

    controllerInternal.addListener(() => updateSuggestions(controllerInternal.text));
    focusNodeInternal.addListener(() {
      if (focusNodeInternal.hasFocus) {
        openOverlay();
      } else {
        closeOverlay();
      }
    });
  }

  void openOverlay() {
    if (_overlayEntry == null) {
      RenderBox renderBox = _context.findRenderObject() as RenderBox;
      var size = renderBox.size;
      var offset = renderBox.localToGlobal(Offset.zero);

      _overlayEntry ??= OverlayEntry(
        builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5.0,
          width: size.width,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: BaseFilterableList<T>(
              loading: state.loading,
              suggestionBuilder: _suggestionBuilder,
              progressIndicatorBuilder: _progressIndicatorBuilder,
              items: _suggestions,
              elevation: _elevation,
              maxListHeight: _maxListHeight,
              suggestionTextStyle: _suggestionTextStyle,
              suggestionBackgroundColor: _suggestionBackgroundColor,
              itemWidget: _itemWidget,
              onItemTapped: (value) {
                emit(
                  BaseSingleAutocompleteChangeSelect<T>(
                    itemSlected: value,
                    items: state.items,
                    loading: state.loading,
                    statusValid: state.statusValid,
                    focus: state.focus,
                  ),
                );
                controllerInternal.value = TextEditingValue(text: value.label, selection: TextSelection.collapsed(offset: value.label.length));
                _onChanged?.call(value.label);
                _onSubmitted?.call(value.label);
                _onSelected?.call(state.itemSlected?.value);
                closeOverlay();
                focusNodeInternal.unfocus();
              },
            ),
          ),
        ),
      );
    }
    if (!_hasOpenedOverlay) {
      Overlay.of(_context).insert(_overlayEntry!);
      _hasOpenedOverlay = true;
    }
  }

  void closeOverlay() {
    if (_hasOpenedOverlay) {
      _overlayEntry!.remove();
      _previousAsyncSearchText = '';
      _hasOpenedOverlay = false;
    }
  }

  Future<void> updateSuggestions(String input) async {
    rebuildOverlay();
    if (state.items != null) {
      _suggestions = _optionsBuilder != null
          ? _optionsBuilder!(state.items!, input)
          : state.items!.where((element) {
              return element.label.toLowerCase().contains(input.toLowerCase());
            }).toList();
      rebuildOverlay();
    } else if (_asyncSuggestions != null) {
      emit(BaseSingleAutocompleteLoading<T>(
        items: state.items,
        itemSlected: state.itemSlected,
        statusValid: state.statusValid,
        loading: true,
        focus: state.focus,
      ));
      if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
      _debounce = Timer(_debounceDuration, () async {
        if (_previousAsyncSearchText != input || _previousAsyncSearchText.isEmpty || input.isEmpty) {
          _suggestions = await _asyncSuggestions!(input);
          emit(BaseSingleAutocompleteLoading<T>(
            items: state.items,
            itemSlected: state.itemSlected,
            statusValid: state.statusValid,
            loading: false,
            focus: state.focus,
          ));
          _previousAsyncSearchText = input;
          rebuildOverlay();
        }
      });
    }
  }

  void rebuildOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  //////

  void changeFocus(bool focus) {
    if (!focus) {
      focusNodeInternal.unfocus();
    }
    emit(BaseSingleAutocompleteChangeFocus<T>(
      focus: focus,
      items: state.items,
      itemSlected: state.itemSlected,
      statusValid: state.statusValid,
      loading: state.loading,
    ));
  }

  void changeStatus(ValidatorStatus status) {
    emit(
      BaseSingleAutocompleteChangeStatus<T>(
        focus: state.focus,
        items: state.items,
        itemSlected: state.itemSlected,
        statusValid: status,
        loading: state.loading,
      ),
    );
  }

  @override
  Future<void> close() async {
    if (_overlayEntry != null) _overlayEntry!.dispose();
    controllerInternal.removeListener(() => updateSuggestions(controllerInternal.text));
    controllerInternal.dispose();
    if (_debounce != null) _debounce?.cancel();
    focusNodeInternal.removeListener(() {
      if (focusNodeInternal.hasFocus) {
        openOverlay();
      } else {
        closeOverlay();
      }
    });
    focusNodeInternal.dispose();
    return super.close();
  }
}
