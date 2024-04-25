// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '_button.dart';

class NeuIconButton extends NeuButton {
  /// A customizable neubrutalist-style icon button.
  ///
  /// The button has an icon, customizable background color, border color,
  /// and drop shadow. The button's shape can also be customized with a rounded
  /// border radius. The button's behavior is specified with an `onPressed`
  /// callback function.
  ///
  /// This button is built using Flutter's `Material` widget, and is designed to
  /// follow the Neubrutalism UI style guidelines.
  ///
  /// *[Constants]

  ///   - const neuBlack = Colors.black; /   - const neuDefault1 = Colors.teal;
  ///   - const neuShadow = Color(0xFF080808);
  ///
  ///   - const neuBorder = 3.0;
  ///   - const neuShadowBlurRadius = 0.0;
  ///
  ///   - const neuOffset = Offset(4, 4);
  ///   - const neuBlurStyle = BlurStyle.solid;

  const NeuIconButton({
    super.key,
    enableAnimation = true,
    required this.icon,
    super.animationDuration,
    super.borderColor,
    super.borderRadius,
    super.borderWidth = 1,
    super.buttonColor,
    super.buttonHeight,
    super.buttonWidth = 100,
    super.offset = const Offset(3, 3),
    super.onPressed,
    super.shadowBlurRadius = 0,
    super.shadowColor,
  }) : super(
          child: icon,
          enableAnimation: enableAnimation,
        );

  /// - icon (required) : A Icon Widget to help you add icons.
  ///
  final Icon icon;
}
