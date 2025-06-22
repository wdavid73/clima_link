import 'package:flutter/material.dart';
import 'package:clima_link/config/theme/theme.dart';

import 'text_theme.dart';

final _baseBorderSideInput = BorderSide(
  color: Colors.transparent,
  width: 0.0,
);
final _baseOutlineInputBorder = OutlineInputBorder(
  borderSide: _baseBorderSideInput,
  borderRadius: BorderRadius.circular(24),
);

/// Base InputDecorationTheme. Used as a starting point for customizing the input decoration styles in light.
InputDecorationTheme getBaseInputDecorationTheme(
        {double? fontSizeFactor = 1}) =>
    InputDecorationTheme(
      isDense: true,
      hintStyle: fontSizeFactor != null
          ? baseTextTheme.bodyMedium?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.bodyMedium,
      labelStyle: fontSizeFactor != null
          ? baseTextTheme.labelLarge?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.labelLarge,
      floatingLabelStyle: fontSizeFactor != null
          ? baseTextTheme.labelLarge?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.labelLarge,
      helperStyle: fontSizeFactor != null
          ? baseTextTheme.bodySmall?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.bodySmall,
      errorStyle: fontSizeFactor != null
          ? baseTextTheme.bodySmall
              ?.apply(fontSizeFactor: fontSizeFactor)
              .copyWith(color: ColorTheme.error)
          : baseTextTheme.bodySmall?.copyWith(color: ColorTheme.error),
      counterStyle: fontSizeFactor != null
          ? baseTextTheme.bodySmall?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.bodySmall,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      suffixIconColor: ColorTheme.secondaryColor,
      prefixIconColor: ColorTheme.secondaryColor,
      enabledBorder: _baseOutlineInputBorder,
      filled: true,
      fillColor: ColorTheme.navigationBackgroundColorLight,
      disabledBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.disable,
        ),
      ),
      focusedBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.backgroundLight,
        ),
      ),
      errorBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.error,
        ),
      ),
      focusedErrorBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.error,
        ),
      ),
    );

/// Base InputDecorationDarkTheme. Used as a starting point for customizing the input decoration styles in dark themes.
InputDecorationTheme getBaseInputDecorationDarkTheme(
        {double? fontSizeFactor = 1}) =>
    getBaseInputDecorationTheme(fontSizeFactor: fontSizeFactor).copyWith(
      hintStyle: fontSizeFactor != null
          ? baseTextThemeDark.bodyMedium?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.bodyMedium,
      labelStyle: fontSizeFactor != null
          ? baseTextThemeDark.labelLarge?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.labelLarge,
      floatingLabelStyle: fontSizeFactor != null
          ? baseTextThemeDark.labelLarge?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.labelLarge,
      helperStyle: fontSizeFactor != null
          ? baseTextThemeDark.bodySmall?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.bodySmall,
      counterStyle: fontSizeFactor != null
          ? baseTextThemeDark.bodySmall?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.bodySmall,
      suffixIconColor: ColorTheme.lightPrimaryColor,
      prefixIconColor: ColorTheme.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      filled: true,
      fillColor: ColorTheme.backgroundColorDark,
      enabledBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.iconsColor,
          width: 1.5,
        ),
      ),
      focusedBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.iconsColor,
          width: 1.5,
        ),
      ),
      errorStyle: fontSizeFactor != null
          ? baseTextThemeDark.bodySmall
              ?.apply(fontSizeFactor: fontSizeFactor)
              .copyWith(color: ColorTheme.error)
          : baseTextThemeDark.bodySmall?.copyWith(color: ColorTheme.error),
    );
