import 'package:flutter/material.dart';
import 'package:houzeo_app/models/bottom_nav_model.dart';
import 'package:houzeo_app/presentation/features/main_screen/provider/main_screen_provider.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BottomNavigationBarItemWidget extends StatefulWidget {
  final BottomNavigationBarItemModel item;
  const BottomNavigationBarItemWidget({super.key, required this.item});

  @override
  State<BottomNavigationBarItemWidget> createState() =>
      _BottomNavigationBarItemWidgetState();
}

class _BottomNavigationBarItemWidgetState
    extends State<BottomNavigationBarItemWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _selectedOptionAnimation;
  @override
  void initState() {
    _animationController =
        AnimationController(duration: Durations.medium1, vsync: this);
    _selectedOptionAnimation = Tween(begin: 0.0, end: Adaptive.w(22)).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Consumer<MainScreenController>(builder: (context, value, child) {
        if (value.currentScreenIndex == widget.item.screenIndex) {
          _animationController.forward();
        } else {
          if (_animationController.isCompleted) {
            _animationController.reverse();
          }
        }
        return InkWell(
          onTap: () {
            value.changeCurrentScreenIndex(widget.item.screenIndex);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Adaptive.h(1.8)),
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    Icon(
                        value.currentScreenIndex == widget.item.screenIndex
                            ? widget.item.selectedIcon
                            : widget.item.icon,
                        size: 21.5.sp,
                        color:
                            value.currentScreenIndex == widget.item.screenIndex
                                ? textColor
                                : subTextColor),
                    const SizedBox(height: 3),
                    Text(widget.item.title,
                        style: TextStyle(
                            fontSize: 14.5.sp,
                            color: value.currentScreenIndex ==
                                    widget.item.screenIndex
                                ? textColor
                                : subTextColor,
                            fontWeight: value.currentScreenIndex ==
                                    widget.item.screenIndex
                                ? FontWeight.w600
                                : FontWeight.w500))
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        height: 4.5,
                        width: _selectedOptionAnimation.value,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100)),
                            color: primaryColor),
                      );
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
