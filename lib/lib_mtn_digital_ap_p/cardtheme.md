You're seeing the error:

```
The argument type 'CardTheme' can't be assigned to the parameter type 'CardThemeData?'. dartargument_type_not_assignable
```

because in the newer versions of Flutter, `ThemeData.cardTheme` **expects a `CardThemeData`**, not a `CardTheme` widget.

---

### 🔍 Problem Breakdown:

You're doing:

```dart
cardTheme: CardTheme(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: Colors.grey[200]!, width: 1),
  ),
),
```

But `ThemeData.cardTheme` expects a `CardThemeData`, **not** the `CardTheme` widget (which is an `InheritedWidget` meant to wrap widgets in the widget tree).

---

### ✅ Fix:

You should update that block to use `CardThemeData` instead of `CardTheme`:

```dart
cardTheme: CardThemeData(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: Colors.grey[200]!, width: 1),
  ),
),
```

And similarly in the dark theme:

```dart
cardTheme: CardThemeData(
  color: const Color(0xFF1E1E1E),
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: Colors.grey[800]!, width: 1),
  ),
),
```

---

### 🧠 Summary

* `CardTheme` is a widget (an `InheritedWidget`) that wraps children.
* `CardThemeData` is the actual **data model** you assign to `ThemeData.cardTheme`.
* You're passing a widget (`CardTheme`) where a data object (`CardThemeData`) is expected.

---

Make these changes and your error should disappear. Let me know if you'd like help checking for other deprecated uses.














































i get:
The argument type 'CardTheme' can't be assigned to the parameter type 'CardThemeData?'. dartargument_type_not_assignable
(new) CardTheme CardTheme({
  Key? key,
  Clip? clipBehavior,
  Color? color,
  Color? surfaceTintColor,
  Color? shadowColor,
  double? elevation,
  EdgeInsetsGeometry? margin,
  ShapeBorder? shape,
  CardThemeData? data,
  Widget? child,
})
package:flutter/src/material/card_theme.dart

Creates a theme that can be used for [ThemeData.cardTheme].

The [elevation] must be null or non-negative.




in:



            cardTheme: CardTheme(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
            ),



ffull:
// main.dart
// This is the entry point of your Flutter application.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/theme_provider.dart';
import 'screens/design1_home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The Consumer widget listens to ThemeProvider changes and rebuilds the UI
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Benevolent Ministry Scheme',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Inter',
            cardTheme: CardTheme(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFF121212),
            fontFamily: 'Inter',
            cardTheme: CardTheme(
              color: const Color(0xFF1E1E1E),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[800]!, width: 1),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: const Design1HomePage(),
        );
      },
    );
  }
}



in teh source code:

/opt/flutter/packages/flutter/lib/src/material/card_theme.dart:
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'card.dart';
/// @docImport 'material.dart';
library;

import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../lib_jubilee_ins_app/theme.dart'_app copy 2/theme.dart';

/// Defines default property values for descendant [Card] widgets.
///
/// Descendant widgets obtain the current [CardTheme] object using
/// `CardTheme.of(context)`. Instances of [CardTheme] can be
/// customized with [CardTheme.copyWith].
///
/// Typically a [CardTheme] is specified as part of the overall [Theme]
/// with [ThemeData.cardTheme].
///
/// All [CardTheme] properties are `null` by default. When null, the [Card]
/// will use the values from [ThemeData] if they exist, otherwise it will
/// provide its own defaults.
///
/// See also:
///
///  * [ThemeData], which describes the overall theme information for the
///    application.
class CardTheme extends InheritedWidget with Diagnosticable {
  /// Creates a theme that can be used for [ThemeData.cardTheme].
  ///
  /// The [elevation] must be null or non-negative.
  const CardTheme({
    super.key,
    Clip? clipBehavior,
    Color? color,
    Color? surfaceTintColor,
    Color? shadowColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    ShapeBorder? shape,
    CardThemeData? data,
    Widget? child,
  }) : assert(
         data == null ||
             (clipBehavior ??
                     color ??
                     surfaceTintColor ??
                     shadowColor ??
                     elevation ??
                     margin ??
                     shape) ==
                 null,
       ),
       assert(elevation == null || elevation >= 0.0),
       _data = data,
       _clipBehavior = clipBehavior,
       _color = color,
       _surfaceTintColor = surfaceTintColor,
       _shadowColor = shadowColor,
       _elevation = elevation,
       _margin = margin,
       _shape = shape,
       super(child: child ?? const SizedBox());

  final CardThemeData? _data;
  final Clip? _clipBehavior;
  final Color? _color;
  final Color? _surfaceTintColor;
  final Color? _shadowColor;
  final double? _elevation;
  final EdgeInsetsGeometry? _margin;
  final ShapeBorder? _shape;

  /// Overrides the default value for [Card.clipBehavior].
  ///
  /// This property is obsolete and will be deprecated in a future release:
  /// please use the [CardThemeData.clipBehavior] property in [data] instead.
  Clip? get clipBehavior => _data != null ? _data.clipBehavior : _clipBehavior;

  /// Overrides the default value for [Card.color].
  ///
  /// This property is obsolete and will be deprecated in a future release:
  /// please use the [CardThemeData.color] property in [data] instead.
  Color? get color => _data != null ? _data.color : _color;

  /// Overrides the default value for [Card.surfaceTintColor].
  ///
  /// This property is obsolete and will be deprecated in a future release:
  /// please use the [CardThemeData.surfaceTintColor] property in [data] instead.
  Color? get surfaceTintColor => _data != null ? _data.surfaceTintColor : _surfaceTintColor;

  /// Overrides the default value for [Card.shadowColor].
  ///
  /// This property is obsolete and will be deprecated in a future release:
  /// please use the [CardThemeData.shadowColor] property in [data] instead.
  Color? get shadowColor => _data != null ? _data.shadowColor : _shadowColor;

  /// Overrides the default value for [Card.elevation].
  ///
  /// This property is obsolete and will be deprecated in a future release:
  /// please use the [CardThemeData.elevation] property in [data] instead.
  double? get elevation => _data != null ? _data.elevation : _elevation;

  /// Overrides the default value for [Card.margin].
  ///
  /// This property is obsolete and will be deprecated in a future release:
  /// please use the [CardThemeData.margin] property in [data] instead.
  EdgeInsetsGeometry? get margin => _data != null ? _data.margin : _margin;

  /// Overrides the default value for [Card.shape].
  ///
  /// This property is obsolete and will be deprecated in a future release:
  /// please use the [CardThemeData.shape] property in [data] instead.
  ShapeBorder? get shape => _data != null ? _data.shape : _shape;

  /// The properties used for all descendant [Card] widgets.
  CardThemeData get data {
    return _data ??
        CardThemeData(
          clipBehavior: _clipBehavior,
          color: _color,
          surfaceTintColor: _surfaceTintColor,
          shadowColor: _shadowColor,
          elevation: _elevation,
          margin: _margin,
          shape: _shape,
        );
  }

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  ///
  /// This method is obsolete and will be deprecated in a future release:
  /// please use the [CardThemeData.copyWith] instead.
  CardTheme copyWith({
    Clip? clipBehavior,
    Color? color,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    ShapeBorder? shape,
  }) {
    return CardTheme(
      clipBehavior: clipBehavior ?? this.clipBehavior,
      color: color ?? this.color,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      elevation: elevation ?? this.elevation,
      margin: margin ?? this.margin,
      shape: shape ?? this.shape,
    );
  }

  /// The [ThemeData.cardTheme] property of the ambient [Theme].
  static CardThemeData of(BuildContext context) {
    final CardTheme? cardTheme = context.dependOnInheritedWidgetOfExactType<CardTheme>();
    return cardTheme?.data ?? Theme.of(context).cardTheme;
  }

  @override
  bool updateShouldNotify(CardTheme oldWidget) => data != oldWidget.data;

  /// Linearly interpolate between two Card themes.
  ///
  /// {@macro dart.ui.shadow.lerp}
  ///
  /// This method is obsolete and will be deprecated in a future release:
  /// please use the [CardThemeData.lerp] instead.
  static CardTheme lerp(CardTheme? a, CardTheme? b, double t) {
    if (identical(a, b) && a != null) {
      return a;
    }
    return CardTheme(
      clipBehavior: t < 0.5 ? a?.clipBehavior : b?.clipBehavior,
      color: Color.lerp(a?.color, b?.color, t),
      shadowColor: Color.lerp(a?.shadowColor, b?.shadowColor, t),
      surfaceTintColor: Color.lerp(a?.surfaceTintColor, b?.surfaceTintColor, t),
      elevation: lerpDouble(a?.elevation, b?.elevation, t),
      margin: EdgeInsetsGeometry.lerp(a?.margin, b?.margin, t),
      shape: ShapeBorder.lerp(a?.shape, b?.shape, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Clip>('clipBehavior', clipBehavior, defaultValue: null));
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(ColorProperty('shadowColor', shadowColor, defaultValue: null));
    properties.add(ColorProperty('surfaceTintColor', surfaceTintColor, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('elevation', elevation, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
  }
}

/// Defines default property values for descendant [Card] widgets.
///
/// Descendant widgets obtain the current [CardThemeData] object using
/// `CardTheme.of(context)`. Instances of [CardThemeData] can be
/// customized with [CardThemeData.copyWith].
///
/// Typically a [CardThemeData] is specified as part of the overall [Theme]
/// with [ThemeData.cardTheme].
///
/// All [CardThemeData] properties are `null` by default. When null, the [Card]
/// will use the values from [ThemeData] if they exist, otherwise it will
/// provide its own defaults. See the individual [Card] properties for details.
///
/// See also:
///
///  * [ThemeData], which describes the overall theme information for the
///    application.
@immutable
class CardThemeData with Diagnosticable {
  /// Creates a theme that can be used for [ThemeData.cardTheme].
  ///
  /// The [elevation] must be null or non-negative.
  const CardThemeData({
    this.clipBehavior,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.margin,
    this.shape,
  }) : assert(elevation == null || elevation >= 0.0);

  /// Overrides the default value for [Card.clipBehavior].
  final Clip? clipBehavior;

  /// Overrides the default value for [Card.color].
  final Color? color;

  /// Overrides the default value for [Card.shadowColor].
  final Color? shadowColor;

  /// Overrides the default value for [Card.surfaceTintColor].
  final Color? surfaceTintColor;

  /// Overrides the default value for [Card.elevation].
  final double? elevation;

  /// Overrides the default value for [Card.margin].
  final EdgeInsetsGeometry? margin;

  /// Overrides the default value for [Card.shape].
  final ShapeBorder? shape;

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  CardThemeData copyWith({
    Clip? clipBehavior,
    Color? color,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    ShapeBorder? shape,
  }) {
    return CardThemeData(
      clipBehavior: clipBehavior ?? this.clipBehavior,
      color: color ?? this.color,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      elevation: elevation ?? this.elevation,
      margin: margin ?? this.margin,
      shape: shape ?? this.shape,
    );
  }

  /// Linearly interpolate between two Card themes.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static CardThemeData lerp(CardThemeData? a, CardThemeData? b, double t) {
    if (identical(a, b) && a != null) {
      return a;
    }
    return CardThemeData(
      clipBehavior: t < 0.5 ? a?.clipBehavior : b?.clipBehavior,
      color: Color.lerp(a?.color, b?.color, t),
      shadowColor: Color.lerp(a?.shadowColor, b?.shadowColor, t),
      surfaceTintColor: Color.lerp(a?.surfaceTintColor, b?.surfaceTintColor, t),
      elevation: lerpDouble(a?.elevation, b?.elevation, t),
      margin: EdgeInsetsGeometry.lerp(a?.margin, b?.margin, t),
      shape: ShapeBorder.lerp(a?.shape, b?.shape, t),
    );
  }

  @override
  int get hashCode =>
      Object.hash(clipBehavior, color, shadowColor, surfaceTintColor, elevation, margin, shape);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CardThemeData &&
        other.clipBehavior == clipBehavior &&
        other.color == color &&
        other.shadowColor == shadowColor &&
        other.surfaceTintColor == surfaceTintColor &&
        other.elevation == elevation &&
        other.margin == margin &&
        other.shape == shape;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Clip>('clipBehavior', clipBehavior, defaultValue: null));
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(ColorProperty('shadowColor', shadowColor, defaultValue: null));
    properties.add(ColorProperty('surfaceTintColor', surfaceTintColor, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('elevation', elevation, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
  }
}