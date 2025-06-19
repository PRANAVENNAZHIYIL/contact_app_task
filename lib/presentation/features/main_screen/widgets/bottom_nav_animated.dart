import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:houzeo_app/presentation/features/main_screen/provider/main_screen_provider.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/widgets/curver_bottom_nav.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomCurvedNavigationBar extends StatelessWidget {
  final MainScreenController mainModel;
  final BuildContext pageContext;

  const CustomCurvedNavigationBar({
    super.key,
    required this.mainModel,
    required this.pageContext,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      animationDuration: const Duration(milliseconds: 600),
      color: baseColor,
      onTap: (index) => mainModel.changeCurrentScreenIndex(index),
      index: mainModel.getSlideindex,
      items: List.generate(
        mainModel.bottomNavBar().length,
        (index) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              index == mainModel.getSlideindex
                  ? mainModel
                      .bottomNavBar(pageContext: context)[index]
                      .iconPath!
                  : mainModel.bottomNavBar1[index].iconPath!,
              height: index == mainModel.getSlideindex
                  ? Adaptive.w(8)
                  : Adaptive.w(6),
              color: index == mainModel.getSlideindex
                  ? Colors.black
                  : Colors.black.withOpacity(0.7),
              fit: BoxFit.fill,
            ),
            if (index != mainModel.getSlideindex)
              Padding(
                padding: EdgeInsets.only(top: Adaptive.h(0.5)),
                child: Container(
                  alignment: Alignment.center,
                  width: Adaptive.w(18),
                  height: AppBar().preferredSize.height * 0.4,
                  child: FittedBox(
                    child: Text(
                      mainModel
                          .bottomNavBar(pageContext: context)[index]
                          .title!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Adaptive.sp(13),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
