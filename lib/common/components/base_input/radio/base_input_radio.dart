import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constant/app_color.dart';
import '../../../validation/form_validation_manager.dart';
import '../../decoration/decoration_input.dart';
import 'cubit/base_input_radio_cubit.dart';
import 'model/base_input_radio_item.dart';

class BaseInputRadio<T> extends StatefulWidget {
  final FormValidationManager? formValidationManager;
  final bool required;
  final String name;
  final String? rules;
  final String? subTitle;
  final String title;
  final bool groupValue;
  final MouseCursor? mouseCursor;
  final bool toggleable = false;
  final Color? activeColor;
  final Color? hoverColor;
  final double? splashRadius;
  final bool? autofocus;
  final String id;
  final List<BaseInputRadioItem<T>> listRadio;
  final T? initValue;
  final Function(T?)? onSelected;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final Color successColor;
  final Color borderFocus;
  final Widget? prefixIcon;
  final bool readOnly;

  const BaseInputRadio({
    Key? key,
    required this.title,
    required this.groupValue,
    required this.id,
    required this.name,
    required this.listRadio,
    this.baseColor = AppColor.grey,
    this.borderColor = AppColor.borderGrey,
    this.errorColor = AppColor.error,
    this.successColor = AppColor.success,
    this.borderFocus = AppColor.focus,
    this.required = false,
    this.readOnly = false,
    this.mouseCursor,
    this.activeColor,
    this.hoverColor,
    this.splashRadius,
    this.autofocus,
    this.rules,
    this.subTitle,
    this.formValidationManager,
    this.onSelected,
    this.prefixIcon,
    this.initValue,
  }) : super(key: key);

  @override
  State<BaseInputRadio<T>> createState() => _BaseInputRadioState<T>();
}

class _BaseInputRadioState<T> extends State<BaseInputRadio<T>> {
  late String? Function(String?) validator;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BaseInputRadioCubit<T>(widget.initValue),
      child: BlocBuilder<BaseInputRadioCubit<T>, BaseInputRadioState<T>>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: FormField<bool>(
                initialValue: widget.initValue != null,
                builder: (FormFieldState<bool> field) {
                  return InputDecorator(
                    decoration: decorationInput(
                      prefixIcon: widget.prefixIcon,
                      borderColor: widget.borderColor,
                      borderFocus: widget.borderFocus,
                      enabledBorderColor: (() {
                        if (field.hasError == true) {
                          return widget.errorColor;
                        } else if (state.itemSelected != null && widget.required == true) {
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
                        } else if (state.itemSelected != null && widget.required == true) {
                          return Icon(Icons.check, color: widget.successColor);
                        }
                        return Icon(Icons.info, color: widget.borderColor);
                      }()),
                      lable: widget.title,
                      required: widget.required,
                      errorText: field.hasError ? field.errorText : null,
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < widget.listRadio.length; i++) ...[
                          RadioListTile(
                            value: widget.listRadio[i].value,
                            title: Text(widget.listRadio[i].label),
                            groupValue: state.itemSelected,
                            onChanged: (newValue) {
                              if (widget.readOnly == false) {
                                context.read<BaseInputRadioCubit<T>>().changeCheckedItem(newValue);
                                field.didChange(true);
                                if (widget.onSelected != null) {
                                  widget.onSelected!(newValue);
                                }
                              }
                            },
                          ),
                        ],
                      ],
                    ),
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
        },
      ),
    );
  }
}
