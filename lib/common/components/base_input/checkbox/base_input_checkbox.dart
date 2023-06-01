import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_color.dart';
import '../../../validation/form_validation_manager.dart';
import '../../decoration/decoration_input.dart';
import 'cubit/base_input_checkbox_cubit.dart';
import 'model/base_input_checkbox_item.dart';

class BaseInputCheckbox<T> extends StatefulWidget {
  final FormValidationManager? formValidationManager;
  final String name;
  final String title;
  final dynamic value;
  final Color activeColor;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final Color successColor;
  final bool required;
  final Color borderFocus;
  final String id;
  final List<BaseInputCheckboxItem<T>> itemsChecked;
  final bool groupValue;
  final int? valuuDefault;
  final Widget? prefixIcon;
  final String? hintText;
  final bool readOnly;
  final Function? validator;
  final String? lable;
  final void Function(List<T>)? onChanged;
  const BaseInputCheckbox({
    Key? key,
    this.activeColor = AppColor.focus,
    this.baseColor = AppColor.grey,
    this.borderColor = AppColor.borderGrey,
    this.errorColor = AppColor.error,
    this.successColor = AppColor.success,
    this.borderFocus = AppColor.focus,
    required this.id,
    this.required = false,
    required this.name,
    required this.title,
    required this.value,
    required this.itemsChecked,
    this.valuuDefault,
    this.formValidationManager,
    required this.groupValue,
    this.prefixIcon,
    this.hintText,
    this.readOnly = false,
    this.validator,
    this.lable,
    this.onChanged,
  }) : super(key: key);
  @override
  State<BaseInputCheckbox<T>> createState() => _BaseInputCheckboxState<T>();
}

class _BaseInputCheckboxState<T> extends State<BaseInputCheckbox<T>> {
  late String? Function(String?) validator;
  bool value = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BaseInputCheckboxCubit<T>(widget.itemsChecked),
      child: BlocBuilder<BaseInputCheckboxCubit<T>, BaseInputCheckboxState<T>>(builder: (context, state) {
        var checkNotEmpty = state.itemsChecked.where((element) => element.selected == true).toList().isNotEmpty;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: FormField<bool?>(
              initialValue: checkNotEmpty,
              builder: (FormFieldState<bool?> field) {
                return InputDecorator(
                  decoration: decorationInput(
                    prefixIcon: widget.prefixIcon,
                    borderColor: widget.borderColor,
                    borderFocus: widget.borderFocus,
                    enabledBorderColor: (() {
                      if (field.hasError == true) {
                        return widget.errorColor;
                      } else if (checkNotEmpty && widget.required == true) {
                        return widget.successColor;
                      }
                      return widget.borderColor;
                    }()),
                    errorColor: widget.errorColor,
                    filled: true,
                    readOnly: widget.readOnly,
                    suffixIcon: (() {
                      if (field.hasError == true) {
                        return Icon(Icons.error, color: widget.errorColor);
                      } else if (checkNotEmpty && widget.required == true) {
                        return Icon(Icons.check, color: widget.successColor);
                      }
                      return Icon(Icons.info, color: widget.borderColor);
                    }()),
                    lable: widget.title,
                    required: widget.required,
                    errorText: field.hasError ? field.errorText : null,
                  ),
                  child: Column(children: [
                    for (int i = 0; i < state.itemsChecked.length; i++) ...[
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: state.itemsChecked[i].selected,
                        title: Text(state.itemsChecked[i].label),
                        onChanged: (bool? value) {
                          if (widget.readOnly == false) {
                            List<BaseInputCheckboxItem<T>> items = [...state.itemsChecked];
                            items[i] = items[i].copyWith(selected: value);
                            context.read<BaseInputCheckboxCubit<T>>().changeCheckedItem(items);
                            var checks = items.where((element) => element.selected).map((e) => e.value).toList();
                            if (widget.onChanged != null) {
                              widget.onChanged!(checks);
                            }
                            field.didChange(checks.isNotEmpty);
                          }
                        },
                      )
                    ]
                  ]),
                );
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (widget.required) {
                  var res = widget.formValidationManager?.wrapValidatorAsString(widget.id, (values) {
                    return (value == null || value == false) ? "${widget.name} Không được bỏ trống " : null;
                  }, value);
                  return res;
                }
                return null;
              }),
        );
      }),
    );
  }
}
