import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme.dart';

class ColorPickerTab extends StatefulWidget {
  const ColorPickerTab({super.key});

  @override
  State<ColorPickerTab> createState() => _ColorPickerTabState();
}

class _ColorPickerTabState extends State<ColorPickerTab> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Center(child: ColorPicker(
      onColorChanged: (color) {
        themeProvider.changeSeedColor(color);
      },
    ));
  }
}
