import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/base_multi_autocomplete_cubit.dart';
import '../model/base_muilti_autocomplete_item.dart';

class MultiSelectDialog<T> extends StatefulWidget {
  final String? title;
  final double? height;
  final double? width;
  final Color? unselectedColor;
  final Color? checkColor;
  final Color? Function(T)? colorator;
  final Color? selectedColor;
  final TextStyle? selectedItemsTextStyle;
  final TextStyle? itemsTextStyle;
  final List<BaseMultiAutocompleteItem<T>> initialValueSelect;
  final void Function(List<T>)? onConfirm;
  final void Function(List<T>)? onCancel;

  const MultiSelectDialog({
    super.key,
    required this.initialValueSelect,
    this.height,
    this.title,
    this.width,
    this.unselectedColor,
    this.checkColor,
    this.colorator,
    this.selectedColor,
    this.selectedItemsTextStyle,
    this.itemsTextStyle,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  final List<BaseMultiAutocompleteItem<T>> _selectedValues = [];
  @override
  void initState() {
    super.initState();
    _selectedValues.addAll(widget.initialValueSelect);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseMultiAutocompleteCubit<T>, BaseMultiAutocompleteState<T>>(
      builder: (context, state) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!state.switchSearch)
                widget.title != null ? Text(widget.title!) : const Text("Select")
              else
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.selectedColor ?? Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        context.read<BaseMultiAutocompleteCubit<T>>().search(val);
                      },
                    ),
                  ),
                ),
              IconButton(
                icon: state.switchSearch ? const Icon(Icons.close) : const Icon(Icons.search),
                onPressed: () {
                  context.read<BaseMultiAutocompleteCubit<T>>().switchCheck(!state.switchSearch);
                },
              ),
            ],
          ),
          contentPadding: const EdgeInsets.only(top: 12.0),
          content: Container(
              decoration: const BoxDecoration(),
              height: widget.height,
              width: widget.width ?? MediaQuery.of(context).size.width * 0.73,
              child: ListView.builder(
                itemCount: state.itemsSearch.length,
                itemBuilder: (context, index) {
                  var item = state.itemsSearch[index];
                  return Theme(
                    data: ThemeData(
                      unselectedWidgetColor: widget.unselectedColor ?? Colors.black54,
                    ),
                    child: CheckboxListTile(
                      checkColor: widget.checkColor,
                      value: item.selected,
                      activeColor: widget.colorator != null ? widget.colorator!(item.value) ?? widget.selectedColor : widget.selectedColor,
                      title: Text(
                        item.label,
                        style: item.selected ? widget.selectedItemsTextStyle : widget.itemsTextStyle,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (checked) {
                        context.read<BaseMultiAutocompleteCubit<T>>().toggleChecked(item, checked == true);
                      },
                    ),
                  );
                },
              )),
          actions: <Widget>[
            TextButton(
              child: Text(
                "CANCEL",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {
                final List<T> listSelect = _selectedValues.where((element) => element.selected == true).map((e) => e.value).toList();
                context.read<BaseMultiAutocompleteCubit<T>>().cancelAlertDialog(_selectedValues);
                Navigator.pop(context, _selectedValues);
                if (widget.onCancel != null) {
                  widget.onCancel!(listSelect);
                }
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {
                final List<T> listSelect = state.items.where((element) => element.selected == true).map((e) => e.value).toList();
                context.read<BaseMultiAutocompleteCubit<T>>().confirmAlertDialog();
                Navigator.pop(context, listSelect);
                if (widget.onConfirm != null) {
                  widget.onConfirm!(listSelect);
                }
              },
            )
          ],
        );
      },
    );
  }
}
