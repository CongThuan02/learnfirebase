import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constant/app_color.dart';
import '../../../../validation/form_validation_manager.dart';
import '../../../decoration/decoration_input.dart';
import 'cubit/base_input_multi_file_cubit.dart';

class BaseInputMultiFile extends StatefulWidget {
  final void Function(List<File>?)? onConfirm;
  final bool autoMultifile;
  final String id;
  final bool required;
  final String name;
  final String lable;
  final List<String> listTypeFile;
  final FormValidationManager? formValidationManager;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final Color successColor;
  final Color borderFocus;
  final bool readOnly;

  const BaseInputMultiFile({
    super.key,
    this.onConfirm,
    this.autoMultifile = false,
    required this.lable,
    this.formValidationManager,
    required this.listTypeFile,
    required this.id,
    required this.required,
    required this.name,
    this.baseColor = AppColor.grey,
    this.borderColor = AppColor.borderGrey,
    this.errorColor = AppColor.error,
    this.successColor = AppColor.success,
    this.borderFocus = AppColor.focus,
    this.readOnly = false,
  });

  @override
  State<BaseInputMultiFile> createState() => _BaseInputMultiFileState();
}

class _BaseInputMultiFileState extends State<BaseInputMultiFile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BaseInputMultiFileCubit([]),
      child: BlocBuilder<BaseInputMultiFileCubit, BaseInputMultiFileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: FormField<bool>(
              builder: (FormFieldState<bool> field) {
                return InkWell(
                  child: InputDecorator(
                    decoration: decorationInput(
                      borderColor: widget.borderColor,
                      borderFocus: widget.borderFocus,
                      enabledBorderColor: (() {
                        if (field.hasError == true) {
                          return widget.errorColor;
                        } else if (state.fileNames.isNotEmpty && widget.required == true) {
                          return widget.successColor;
                        }
                        return widget.borderColor;
                      }()),
                      errorColor: widget.errorColor,
                      filled: true,
                      errorText: field.hasError ? field.errorText : null,
                      lable: widget.lable,
                      readOnly: widget.readOnly,
                      required: widget.required,
                      suffixIcon: (() {
                        if (state.fileNames.isEmpty) {
                          return Icon(
                            Icons.upload_file,
                            color: (() {
                              if (field.hasError == true && widget.required == true) {
                                return widget.errorColor;
                              }
                              return widget.baseColor;
                            }()),
                          );
                        } else {
                          return InkWell(
                            child: Icon(
                              Icons.clear,
                              color: (() {
                                if (field.hasError == false && widget.required == true) {
                                  return widget.successColor;
                                }
                                return widget.baseColor;
                              }()),
                            ),
                            onTap: () async {
                              context.read<BaseInputMultiFileCubit>().deleteFileName();
                              if (widget.onConfirm != null) {
                                widget.onConfirm!([]);
                                field.didChange(false);
                              }
                            },
                          );
                        }
                      }()),
                    ),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 24.0,
                      children: [
                        if (state.fileNames.isEmpty)
                          const Text("")
                        else
                          ...state.fileNames.map(
                            (e) => Chip(
                              label: Text(e),
                            ),
                          ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: widget.listTypeFile,
                      allowMultiple: true,
                    );
                    if (!mounted) return;
                    if (result != null) {
                      List<File> files = result.paths.map((path) => File(path!)).toList();
                      List<String> fileNames = result.files.map((e) => e.name).toList();
                      context.read<BaseInputMultiFileCubit>().updateFileName(fileNames);
                      if (widget.onConfirm != null) {
                        widget.onConfirm!(files);
                        field.didChange(true);
                      }
                    }
                  },
                );
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (widget.required) {
                  var res = widget.formValidationManager?.wrapValidatorAsString(widget.id, (value) {
                    return (value == false || value == null) ? "${widget.name} không được bỏ trống" : null;
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
}
