import 'package:flutter/material.dart';
import 'package:clima_link/config/config.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final List<T> options;
  final DropdownMenuItem<T> Function(T value) itemBuilder;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  final BoxDecoration? decoration;
  final Icon? icon;
  final double iconSize;
  final Color? iconDisabledColor;
  final FocusNode? focusNode;
  final String? errorMessage;
  final String? helperText;
  final String? label;
  final Widget? prefixIcon;

  final String hint;
  final String hintDisable;

  final dynamic value;

  const CustomDropdownFormField({
    super.key,
    required this.options,
    required this.itemBuilder,
    this.onChanged,
    this.validator,
    this.decoration,
    this.icon,
    this.focusNode,
    this.iconDisabledColor,
    this.iconSize = 25,
    this.errorMessage,
    this.helperText,
    this.prefixIcon,
    this.label,
    this.hint = 'select_an_option',
    this.hintDisable = 'select_an_option_disabled',
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: DropdownButtonFormField<T>(
        value: value,
        items: options.map((value) => itemBuilder(value)).toList(),
        decoration: InputDecoration(
          labelText: label,
          errorText: errorMessage != '' ? errorMessage : null,
          helperText: helperText,
          prefixIcon: prefixIcon,
          hintMaxLines: 1,
          errorMaxLines: 2,
          helperMaxLines: 2,
        ),
        menuMaxHeight: context.hp(35),
        icon: icon,
        iconSize: iconSize,
        iconDisabledColor: iconDisabledColor,
        iconEnabledColor: ColorTheme.primaryColor,
        focusNode: focusNode,
        isExpanded: false,
        onChanged: onChanged,
        validator: validator,
        dropdownColor: Theme.of(context).brightness == Brightness.light
            ? ColorTheme.navigationBackgroundColorLight
            : ColorTheme.backgroundColorDark,
        style: context.textTheme.bodyMedium,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
