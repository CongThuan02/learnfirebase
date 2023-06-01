import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_color.dart';
import '../../../validation/form_validation_manager.dart';
import '../../decoration/decoration_input.dart';
import 'cubit/base_multi_autocomplete_cubit.dart';
import 'model/base_muilti_autocomplete_item.dart';
import 'widgets/multi_autocomplete_dialog.dart';

class BaseMuiltiAutocomplete<T> extends StatefulWidget {
  final String id;
  final bool required;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final Color successColor;
  final Color borderFocus;
  final bool readOnly;
  final Widget? prefixIcon;
  final String title;
  final String name;
  final List<BaseMultiAutocompleteItem<T>> items;
  final List<BaseMultiAutocompleteItem<T>> itemsSelected;
  final void Function(List<T>)? onConfirm;
  final void Function(List<T>)? onCancel;
  final FormValidationManager? formValidationManager;
  const BaseMuiltiAutocomplete({
    super.key,
    required this.id,
    required this.title,
    required this.name,
    required this.items,
    required this.itemsSelected,
    this.required = false,
    this.baseColor = AppColor.grey,
    this.borderColor = AppColor.borderGrey,
    this.errorColor = AppColor.error,
    this.successColor = AppColor.success,
    this.borderFocus = AppColor.focus,
    this.readOnly = false,
    this.prefixIcon,
    this.onConfirm,
    this.onCancel,
    this.formValidationManager,
  });

  @override
  State<BaseMuiltiAutocomplete<T>> createState() => _BaseMuiltiAutocompleteState<T>();
}

class _BaseMuiltiAutocompleteState<T> extends State<BaseMuiltiAutocomplete<T>> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BaseMultiAutocompleteCubit<T>(
        items: widget.items,
        itemsSelected: widget.itemsSelected,
      ),
      child: BlocBuilder<BaseMultiAutocompleteCubit<T>, BaseMultiAutocompleteState<T>>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormField<int>(
              builder: (FormFieldState<int> field) {
                return InkWell(
                  onTap: () async {
                    widget.readOnly == false ? await _showDialog(context, state, field) : null;
                  },
                  child: InputDecorator(
                    decoration: decorationInput(
                      prefixIcon: widget.prefixIcon,
                      borderColor: widget.borderColor,
                      borderFocus: widget.borderFocus,
                      enabledBorderColor: (() {
                        if (field.hasError == true) {
                          return widget.errorColor;
                        } else if (state.itemsSelected.isNotEmpty && widget.required == true) {
                          return widget.successColor;
                        }
                        return widget.borderColor;
                      }()),
                      errorColor: widget.errorColor,
                      filled: true,
                      readOnly: widget.readOnly,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: (() {
                          if (field.hasError == true) {
                            return widget.errorColor;
                          } else if (state.itemsSelected.isNotEmpty && widget.required == true) {
                            return widget.successColor;
                          }
                          return widget.baseColor;
                        }()),
                      ),
                      lable: widget.title,
                      required: widget.required,
                      errorText: field.hasError ? field.errorText : null,
                    ),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 24.0,
                      children: [
                        if (state.itemsSelected.isEmpty)
                          const Text("")
                        else
                          ...state.itemsSelected.map(
                            (e) => Chip(
                              label: Text(e.label),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (widget.required) {
                  var res = widget.formValidationManager?.wrapValidatorAsString(widget.id, (value) {
                    return (value == null || value == 0) ? "${widget.name} không được bỏ trống" : null;
                  }, value);
                  return res;
                }
                return null;
              },
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, BaseMultiAutocompleteState<T> state, FormFieldState<int> field) async {
    return showDialog(
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return BlocProvider<BaseMultiAutocompleteCubit<T>>.value(
          value: context.read<BaseMultiAutocompleteCubit<T>>(),
          child: MultiSelectDialog<T>(
            initialValueSelect: state.itemsSelected,
            onConfirm: (value) {
              field.didChange(value.length);
              if (widget.onConfirm != null) {
                widget.onConfirm!(value);
              }
            },
            onCancel: (value) {
              field.didChange(value.length);
              if (widget.onCancel != null) {
                widget.onCancel!(value);
              }
            },
          ),
        );
      },
      context: context,
    );
  }
}
