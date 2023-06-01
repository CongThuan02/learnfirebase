import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_color.dart';
import '../../../validation/check_validor.dart';
import '../../../validation/form_validation_manager.dart';
import '../../../validation/validtor_status.dart';
import '../../decoration/decoration_input.dart';
import 'cubit/base_input_cubit.dart';

class BaseInputText extends StatefulWidget {
  final String? valueDefault;
  final bool readOnly;
  final String title;
  final String name;
  final String? rules;
  final String? hintText;
  final TextEditingController? controller;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final Color successColor;
  final Color borderFocus;
  final TextInputType inputType;
  final bool obscureText;
  final Function? validator;
  final Function onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool focus;
  final String id;
  final FormValidationManager? formValidationManager;
  const BaseInputText({
    Key? key,
    this.readOnly = false,
    this.baseColor = AppColor.grey,
    this.borderColor = AppColor.borderGrey,
    this.errorColor = AppColor.error,
    this.successColor = AppColor.success,
    this.borderFocus = AppColor.focus,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.focus = false,
    this.valueDefault,
    this.rules,
    this.hintText,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.formValidationManager,
    required this.name,
    required this.title,
    required this.onChanged,
    required this.id,
  }) : super(key: key);

  @override
  State<BaseInputText> createState() => _BaseInputTextState();
}

class _BaseInputTextState extends State<BaseInputText> {
  late String? Function(String?) validator;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    if (widget.rules != null && widget.rules != "") {
      validator = checkValidation(widget.name, widget.rules!);
    } else if (widget.validator != null) {
      validator = (text) {
        return widget.validator!(text);
      };
    } else {
      validator = (text) {
        return null;
      };
    }
    if (widget.controller != null) {
      widget.controller!.text = widget.valueDefault ?? "";
      controller = widget.controller!;
    } else {
      controller = TextEditingController(text: widget.valueDefault ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BaseInputCubit(),
      child: BlocBuilder<BaseInputCubit, BaseInputState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Focus(
              onFocusChange: (focus) {
                context.read<BaseInputCubit>().changeFocus(focus);
              },
              child: TextFormField(
                obscureText: widget.obscureText,
                readOnly: widget.readOnly,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(
                  color: widget.readOnly ? AppColor.grey : null,
                ),
                validator: (text) {
                  String? res;
                  if (widget.formValidationManager != null) {
                    res = widget.formValidationManager?.wrapValidatorAsString(widget.id, validator, text);
                  } else {
                    res = validator(text);
                  }
                  if (res != null && res != "") {
                    context.read<BaseInputCubit>().updateState(ValidatorStatus.error);
                  } else {
                    context.read<BaseInputCubit>().updateState(ValidatorStatus.passed);
                  }
                  return res;
                },
                focusNode: widget.formValidationManager != null ? widget.formValidationManager!.getFocusNodeForField(widget.id) : null,
                keyboardType: widget.inputType,
                controller: controller,
                decoration: decorationInput(
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon ??
                      (() {
                        if (state.focus) {
                          return InkWell(
                            child: Icon(
                              Icons.clear,
                              color: (() {
                                switch (state.statusValid) {
                                  case ValidatorStatus.error:
                                    return widget.errorColor;
                                  case ValidatorStatus.passed:
                                    return widget.successColor;
                                  default:
                                    return widget.borderColor;
                                }
                              }()),
                            ),
                            onTap: () {
                              controller.text = "";
                            },
                          );
                        } else {
                          switch (state.statusValid) {
                            case ValidatorStatus.error:
                              return Icon(Icons.error, color: widget.errorColor);
                            case ValidatorStatus.passed:
                              return Icon(Icons.check, color: widget.successColor);
                            default:
                              return Icon(Icons.info, color: widget.borderColor);
                          }
                        }
                      }()),
                  hintText: widget.hintText,
                  filled: true,
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
                  lable: widget.title,
                  required: widget.rules != null && widget.rules!.isNotEmpty,
                ),
                autofocus: widget.focus,
                onChanged: (text) => widget.onChanged(text),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
