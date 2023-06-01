import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constant/app_color.dart';
import '../../../validation/form_validation_manager.dart';
import '../../../validation/validtor_status.dart';
import '../../decoration/decoration_input.dart';
import 'cubit/base_single_autocomplete_cubit.dart';
import 'model/base_single_autocomplete_item.dart';

class BaseSingleAutocomplete<T> extends StatefulWidget {
  final String id;
  final String name;
  final String title;
  final bool readOnly;
  final bool required;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final Color successColor;
  final Color borderFocus;
  final double height;
  final List<BaseSingleAutocompleteItem<T>> items;
  final BaseSingleAutocompleteItem<T>? itemSelected;
  final TextEditingController? textEditingController;
  final bool hideSuggestionsOnKeyboardHide;
  final List<BaseSingleAutocompleteItem<T>> Function(List<BaseSingleAutocompleteItem<T>> suggestions, String searchValue)? optionsBuilder;
  final Widget Function(T)? itemWidget;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final FormValidationManager? formValidationManager;
  final double? elevation;
  final double? maxListHeight;
  final TextStyle? suggestionTextStyle;
  final Color? suggestionBackgroundColor;

  /// The list of suggestions to be displayed
  final List<BaseSingleAutocompleteItem<T>>? suggestions;

  /// Fetches list of suggestions from a Future
  final Future<List<BaseSingleAutocompleteItem<T>>> Function(String searchValue)? asyncSuggestions;

  /// Text editing controller
  final TextEditingController? controller;

  /// Function that handles the changes to the input
  final Function(String)? onChanged;

  /// Function that handles the submission of the input
  final Function(String)? onSubmitted;

  /// Can be used to set the textfield initial value
  final String? initialValue;

  /// Can be used to set the text capitalization type
  final TextCapitalization textCapitalization;

  /// Determines if should gain focus on screen open
  final bool autofocus;

  /// Can be used to customize suggestion items
  final Widget Function(T data)? suggestionBuilder;

  /// Used to set the debounce time for async data fetch
  final Duration debounceDuration;

  /// Can be used to display custom progress idnicator
  final Widget? progressIndicatorBuilder;
  final Function? validator;
  final Function(T?)? onSelected;

  const BaseSingleAutocomplete({
    super.key,
    required this.id,
    required this.name,
    required this.title,
    required this.items,
    this.itemSelected,
    this.optionsBuilder,
    this.itemWidget,
    this.readOnly = false,
    this.initialValue,
    this.prefixIcon,
    this.height = 200.0,
    this.required = false,
    this.baseColor = AppColor.grey,
    this.borderColor = AppColor.borderGrey,
    this.errorColor = AppColor.error,
    this.successColor = AppColor.success,
    this.borderFocus = AppColor.focus,
    this.hideSuggestionsOnKeyboardHide = true,
    this.formValidationManager,
    this.textEditingController,
    this.focusNode,
    this.suggestions,
    this.asyncSuggestions,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.suggestionBuilder,
    this.progressIndicatorBuilder,
    this.debounceDuration = const Duration(milliseconds: 400),
    this.elevation,
    this.maxListHeight,
    this.suggestionTextStyle,
    this.suggestionBackgroundColor,
    this.validator,
    this.onSelected,
  });

  @override
  State<BaseSingleAutocomplete<T>> createState() => _BaseSingleAutocompleteState<T>();
}

class _BaseSingleAutocompleteState<T> extends State<BaseSingleAutocomplete<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => BaseSingleAutocompleteCubit<T>(
          widget.items,
          widget.itemSelected,
        )..init(
            controller: widget.controller ?? TextEditingController(text: widget.itemSelected?.label ?? widget.initialValue ?? ''),
            context: context,
            asyncSuggestions: widget.asyncSuggestions,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            optionsBuilder: widget.optionsBuilder,
            progressIndicatorBuilder: widget.progressIndicatorBuilder,
            suggestionBuilder: widget.suggestionBuilder,
            focusNode: widget.formValidationManager != null
                ? widget.formValidationManager!.getFocusNodeForField(widget.id)
                : widget.focusNode ?? FocusNode(),
            elevation: widget.elevation,
            maxListHeight: widget.maxListHeight,
            suggestionTextStyle: widget.suggestionTextStyle,
            suggestionBackgroundColor: widget.suggestionBackgroundColor,
            itemWidget: widget.itemWidget,
            onSelected: widget.onSelected,
          ),
        child: BlocBuilder<BaseSingleAutocompleteCubit<T>, BaseSingleAutocompleteState<T>>(
          builder: (context, state) {
            return CompositedTransformTarget(
              link: context.watch<BaseSingleAutocompleteCubit<T>>().layerLink,
              child: Focus(
                onFocusChange: (focus) {
                  context.read<BaseSingleAutocompleteCubit<T>>().changeFocus(focus);
                },
                child: TextFormField(
                  controller: context.watch<BaseSingleAutocompleteCubit<T>>().controllerInternal,
                  autofocus: widget.autofocus,
                  focusNode: widget.formValidationManager != null
                      ? widget.formValidationManager!.getFocusNodeForField(widget.id)
                      : widget.focusNode ?? FocusNode(),
                  textCapitalization: widget.textCapitalization,
                  cursorColor: Colors.blue,
                  onChanged: (value) => widget.onChanged?.call(value),
                  onFieldSubmitted: (value) {
                    widget.onSubmitted?.call(value);
                    context.read<BaseSingleAutocompleteCubit<T>>().closeOverlay();
                    context.read<BaseSingleAutocompleteCubit<T>>().changeFocus(false);
                  },
                  onEditingComplete: () => context.read<BaseSingleAutocompleteCubit<T>>().closeOverlay(),
                  readOnly: widget.readOnly,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: decorationInput(
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.readOnly
                        ? const Icon(Icons.arrow_drop_down, color: AppColor.disable)
                        : (() {
                            if (state.focus) {
                              return InkWell(
                                child: const Icon(
                                  Icons.clear,
                                  color: AppColor.disable,
                                ),
                                onTap: () {
                                  context.read<BaseSingleAutocompleteCubit<T>>().controllerInternal.text = "";
                                },
                              );
                            } else {
                              return Icon(
                                Icons.arrow_drop_down_sharp,
                                color: (() {
                                  switch (state.statusValid) {
                                    case ValidatorStatus.passed:
                                      return widget.successColor;
                                    default:
                                      return widget.borderColor;
                                  }
                                }()),
                              );
                            }
                          }()),
                    borderFocus: widget.borderFocus,
                    readOnly: widget.readOnly,
                    enabledBorderColor: (() {
                      switch (state.statusValid) {
                        case ValidatorStatus.passed:
                          return widget.successColor;
                        default:
                          return widget.borderColor;
                      }
                    }()),
                    borderColor: (() {
                      switch (state.statusValid) {
                        case ValidatorStatus.passed:
                          return widget.successColor;
                        default:
                          return widget.borderColor;
                      }
                    }()),
                    errorColor: widget.errorColor,
                    filled: true,
                    lable: widget.title,
                    required: widget.required,
                  ),
                  validator: (value) {
                    if (widget.required) {
                      var res = widget.formValidationManager?.wrapValidatorAsString(widget.id, (value) {
                        if (widget.validator != null) {
                          widget.validator!(value);
                        } else {
                          if (state.itemSlected == null || state.itemSlected!.label != value) {
                            return "${widget.name} chưa lựa chọn phù hơp";
                          }
                        }
                        return null;
                      }, value);
                      if (res != null && res != "") {
                        context.read<BaseSingleAutocompleteCubit<T>>().changeStatus(ValidatorStatus.error);
                      } else {
                        context.read<BaseSingleAutocompleteCubit<T>>().changeStatus(ValidatorStatus.passed);
                      }
                      return res;
                    }
                    return null;
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
