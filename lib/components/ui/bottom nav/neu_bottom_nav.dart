import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../containers/neu_container.dart';

class NeuBottomNav extends StatefulWidget {
  final List<IconData> icons;
  final Function onIconTap;
  final bool isFloating;
  final double? floatingHeight;
  final double? floatingWidth;
  final double? stackedHeight;
  final double? stackedWidth;
  final Color? isSelectedColor;
  final bool autoHideOnScroll; // New parameter for auto hide
  final ScrollController scrollController;
  final int? autoHideDuration;

  const NeuBottomNav({
    super.key,
    required this.icons,
    required this.onIconTap,
    this.isFloating = true,
    //this.autoHide = false,
    this.floatingHeight,
    this.floatingWidth,
    this.stackedHeight,
    this.stackedWidth,
    this.isSelectedColor,
    required this.autoHideOnScroll,
    required this.scrollController,
    this.autoHideDuration = 300, // Default value is true
  });

  @override
  State<NeuBottomNav> createState() => _NeuBottomNavState();
}

class _NeuBottomNavState extends State<NeuBottomNav> {
  int _currentIndex = 0;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    if (widget.autoHideOnScroll) {
      widget.scrollController.addListener(_handleScroll);
    }
  }

  @override
  void dispose() {
    if (widget.autoHideOnScroll) {
      widget.scrollController.dispose();
    }
    super.dispose();
  }

  void _handleScroll() {
    // Calculate the scroll direction
    bool scrollDown = widget.scrollController.position.userScrollDirection ==
        ScrollDirection.forward;
    if (scrollDown != _isVisible) {
      setState(() {
        _isVisible = scrollDown;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomNavWidget = Wrap(
      children: [
        Padding(
          padding: widget.isFloating
              ? const EdgeInsets.only(left: 20, right: 20, bottom: 10)
              : EdgeInsets.zero,
          child: NeuContainer(
            height: 60,
            borderColor: Theme.of(context).shadowColor,
            color: Theme.of(context).scaffoldBackgroundColor,
            shadowColor: Theme.of(context).shadowColor,
            offset: const Offset(3, 3),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < widget.icons.length; i++)
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = i;
                          });
                          widget.onIconTap(i);
                        },
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: _currentIndex == i
                                  ? widget.isSelectedColor ??
                                      Theme.of(context).primaryColorLight
                                  : Colors.transparent),
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: 100,
                          height: 50,
                          child: Icon(
                            widget.icons[i],
                            size: 30,
                            color: Theme.of(context).listTileTheme.textColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    if (widget.autoHideOnScroll) {
      setState(() {
        bottomNavWidget = AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: widget.autoHideDuration!),
          child: bottomNavWidget,
        );
      });
      // Wrap the widget with AnimatedOpacity based on autoHideOnScroll parameter
    }

    return bottomNavWidget;
  }
}

//TODO:Add BottomNavItem Class for the bottom nav items
//TODO: Navigation Mechanism like BottomNavBar
