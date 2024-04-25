import 'package:flutter/material.dart';

class NeuContainer extends StatefulWidget {
  /// A customizable neubrutalist-style Container Template, allowing
  /// user to experiment freely without any restriction in functionality.
  ///
  /// This button is built using Flutter's `Material` widget, and is designed to
  /// follow the Neubrutalism UI style guidelines.
  ///
  /// *[Constants]

  ///   - const neuBlack = Colors.black;
  ///   - const neuDefault1 = Colors.teal;
  ///   - const neuShadow = Color(0xFF080808);
  ///
  ///   - const neuBorder = 3.0;
  ///   - const neuShadowBlurRadius = 0.0;
  ///
  ///   - const neuOffset = Offset(4, 4);
  ///   - const neuBlurStyle = BlurStyle.solid;

  const NeuContainer({
    super.key,
    this.offset = const Offset(3, 3),
    this.color,
    this.shadowColor,
    this.borderColor,
    this.height,
    this.width,
    this.borderWidth = 1,
    this.shadowBlurRadius = 0,
    this.shadowBlurStyle = BlurStyle.solid,
    this.child,
    this.borderRadius,
  });

  /// - offset (optional): An Offset that defines the position of the shadow of the container.
  ///
  /// By default, it is set to neuOffset.

  final Offset offset;

  /// - color (optional): A Color that defines the background color of the container.
  ///
  /// By default, it is set to neuDefault1.

  final Color? color;

  /// - shadowColor (optional): A Color that defines the color of the shadow of the container.
  ///
  /// By default, it is set to neuShadow.

  final Color? shadowColor;

  /// - borderColor (optional): A Color that defines the color of the border of the container.
  ///
  /// By default, it is set to neuBlack.

  final Color? borderColor;

  /// - height (optional): A double that defines the height of the container.
  ///
  /// By default, it is set to null.

  final double? height;

  /// - width (optional): A double that defines the width of the container.
  ///
  /// By default, it is set to null.

  final double? width;

  /// - borderWidth (optional): A double that defines the width of the border of the container.
  ///
  /// By default, it is set to neuBorder.

  final double borderWidth;

  /// - shadowBlurRadius (optional): A double that defines the blur radius of the shadow of the container.
  ///
  /// By default, it is set to neuShadowBlurRadius.

  final double shadowBlurRadius;

  /// - shadowBlurStyle (optional): A BlurStyle that defines the style of the blur of the shadow of the container.
  ///
  /// By default, it is set to neuBlurStyle.

  final BlurStyle shadowBlurStyle;

  /// - child (optional): A widget that is displayed inside the container.
  ///
  /// By default, it is set to null.

  final Widget? child;

  /// - borderRadius (optional): A BorderRadiusGeometry that defines the radius of the corners of the container.
  ///
  /// By default, it is set to null.

  final BorderRadiusGeometry? borderRadius;

  @override
  State<NeuContainer> createState() => NeuContainerState();
}

class NeuContainerState extends State<NeuContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: Border.all(
          color: widget.borderColor ?? Theme.of(context).shadowColor,
          width: widget.borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? Theme.of(context).shadowColor,
            blurRadius: widget.shadowBlurRadius,
            offset: widget.offset,
            blurStyle: widget.shadowBlurStyle,
          ),
        ],
        color: widget.color ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.child,
    );
  }
}
