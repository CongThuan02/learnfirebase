import 'package:flutter/material.dart';

import '../model/base_single_autocomplete_item.dart';

class BaseFilterableList<T> extends StatelessWidget {
  final List<BaseSingleAutocompleteItem<T>> items;
  final Function(BaseSingleAutocompleteItem<T>) onItemTapped;
  final double elevation;
  final double maxListHeight;
  final TextStyle suggestionTextStyle;
  final Color? suggestionBackgroundColor;
  final bool loading;
  final Widget Function(T data)? suggestionBuilder;
  final Widget? progressIndicatorBuilder;
  final Widget Function(T)? itemWidget;

  const BaseFilterableList({
    super.key,
    required this.items,
    required this.onItemTapped,
    this.suggestionBuilder,
    this.elevation = 5,
    this.maxListHeight = 150,
    this.suggestionTextStyle = const TextStyle(),
    this.suggestionBackgroundColor,
    this.loading = false,
    this.progressIndicatorBuilder,
    this.itemWidget,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);

    final Color suggestionBackgroundColorInternal = suggestionBackgroundColor ?? scaffold?.widget.backgroundColor ?? theme.scaffoldBackgroundColor;
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      color: suggestionBackgroundColorInternal,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxListHeight, maxWidth: 80),
        child: Visibility(
          visible: items.isNotEmpty || loading,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            itemCount: loading ? 1 : items.length,
            itemBuilder: (context, index) {
              if (loading) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Visibility(
                    visible: progressIndicatorBuilder != null,
                    replacement: const CircularProgressIndicator(),
                    child: progressIndicatorBuilder!,
                  ),
                );
              }

              if (suggestionBuilder != null) {
                return InkWell(
                  child: suggestionBuilder!(items[index].value),
                  onTap: () => onItemTapped(
                    items[index],
                  ),
                );
              }

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    child: itemWidget != null
                        ? itemWidget!(items[index].value)
                        : Text(
                            items[index].label,
                            style: suggestionTextStyle,
                          ),
                  ),
                  onTap: () => onItemTapped(items[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
