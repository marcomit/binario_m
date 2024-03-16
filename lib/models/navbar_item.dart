import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavbarItem {
  final GButton tab;
  final Widget page;
  NavbarItem(this.tab, this.page);
}
