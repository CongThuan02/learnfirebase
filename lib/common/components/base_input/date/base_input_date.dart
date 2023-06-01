import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constant/app_color.dart';
import '../../../functions/dateformat.dart';
import '../../../validation/check_validor.dart';
import '../../../validation/form_validation_manager.dart';
import '../../../validation/validtor_status.dart';
import '../../decoration/decoration_input.dart';
import 'cubit/base_input_date_cubit.dart';

class BaseInputDate extends StatefulWidget {
  final TextEditingController? controller;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final FormValidationManager? formValidationManager;
  final Locale? locale;
  final String? rules;
  final DateTime? lastDate;
  final Function? validator;
  final Widget? prefixIcon;
  final String? hintText;
  final String name;
  final String title;
  final String id;
  final bool focus;
  final List<DateTime> listDateDisable;
  final List<int> listDayDisable;
  final Function(DateTime?) onChanged;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final Color successColor;
  final Color borderFocus;
  final bool readOnly;
  const BaseInputDate({
    Key? key,
    this.readOnly = false,
    this.baseColor = AppColor.grey,
    this.borderColor = AppColor.borderGrey,
    this.errorColor = AppColor.error,
    this.successColor = AppColor.success,
    this.borderFocus = AppColor.focus,
    this.rules,
    this.lastDate,
    this.startTime,
    this.endTime,
    this.listDayDisable = const [],
    this.controller,
    this.locale = const Locale("vi"),
    this.formValidationManager,
    this.validator,
    this.firstDate,
    this.focus = false,
    this.prefixIcon,
    this.hintText,
    required this.id,
    required this.name,
    required this.initialDate,
    required this.listDateDisable,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  State<BaseInputDate> createState() => _BaseInputDateState();
}

class _BaseInputDateState extends State<BaseInputDate> {
  late String? Function(String?) validator;
  TextEditingController dateInputController = TextEditingController();
  DateTime time = DateTime.now();
  String _value = "";
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
      String rules = "date";
      if (widget.firstDate != null) {
        rules += "|after_or_equal_date:${DateFormat('yyyy-MM-dd').format(widget.firstDate!)}";
      }
      if (widget.lastDate != null) {
        rules += "|before_or_equal_date:${DateFormat('yyyy-MM-dd').format(widget.lastDate!)}";
      }
      for (var dateDisable in widget.listDateDisable) {
        rules += "|not_equal_date:${DateFormat('yyyy-MM-dd').format(dateDisable)}";
      }
      for (var dayDisable in widget.listDayDisable) {
        rules += "|not_equal_day:$dayDisable";
      }
      validator = checkValidation(widget.name, rules);
    }
    if (widget.controller != null) {
      widget.controller!.text = DateFormat('dd/MM/yyyy').format(
        widget.initialDate ?? DateTime.now(),
      );
      dateInputController = widget.controller!;
    } else {
      dateInputController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(
          widget.initialDate ?? DateTime.now(),
        ),
      );
    }
    _value = dateInputController.text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BaseInputDateCubit(),
      child: BlocBuilder<BaseInputDateCubit, BaseInputDateState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  dateInputController.text = _value;
                }
              },
              child: TextFormField(
                focusNode: widget.formValidationManager != null ? widget.formValidationManager!.getFocusNodeForField(widget.id) : null,
                onChanged: (value) {
                  var checkDate = tryParseDateTime("dd/MM/yyyy", value, widget.firstDate, widget.lastDate);
                  if (checkDate != null) {
                    _value = DateFormat('dd/MM/yyyy').format(checkDate);
                    widget.onChanged(checkDate);
                  }
                },
                readOnly: widget.readOnly,
                autofocus: widget.focus,
                controller: dateInputController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: decorationInput(
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: InkWell(
                      child: Icon(
                        Icons.date_range,
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
                      onTap: () async {
                        dateInputController.text = _value;
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          locale: widget.locale,
                          initialDatePickerMode: DatePickerMode.day,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: DateFormat("dd/MM/yyyy").parse(_value),
                          firstDate: widget.firstDate ?? DateTime(1, 1, 1),
                          selectableDayPredicate: (DateTime val) {
                            if (widget.firstDate != null) {
                              if (compareDate(val, widget.firstDate!) == -1) {
                                return false;
                              }
                            }
                            if (widget.endTime != null) {
                              if (compareDate(val, widget.endTime!) == 1) {
                                return false;
                              }
                            }
                            for (var x in widget.listDateDisable) {
                              if (compareDate(x, val) == 0 && compareDate(x, DateTime.now()) != 0) {
                                return false;
                              }
                            }
                            for (var x in widget.listDayDisable) {
                              if (val.day == x && x != DateTime.now().day) {
                                return false;
                              }
                            }
                            return true;
                          },
                          lastDate: widget.lastDate ?? DateTime.parse("99999-12-31 23:59:59.999"),
                        );

                        if (pickedDate != null) {
                          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                          dateInputController.text = formattedDate;
                          _value = formattedDate;
                        } else {}
                      },
                    ),
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
                    required: widget.rules != null && widget.rules!.isNotEmpty),
                validator: (text) {
                  String? res;
                  if (widget.formValidationManager != null) {
                    res = widget.formValidationManager?.wrapValidatorAsString(widget.id, validator, (text ?? "").split("/").reversed.join('-'));
                  } else {
                    res = validator((text ?? "").split("/").reversed.join('-'));
                  }
                  if (res != null && res != "") {
                    context.read<BaseInputDateCubit>().updateState(ValidatorStatus.error);
                  } else {
                    context.read<BaseInputDateCubit>().updateState(ValidatorStatus.passed);
                  }
                  return res;
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    dateInputController.dispose();
    super.dispose();
  }
}
