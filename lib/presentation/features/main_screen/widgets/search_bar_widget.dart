// import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
// import 'package:houzeo_app/presentation/features/search_contact/screen/search_contact_screen.dart';
// import 'package:houzeo_app/utils/constants/colors.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class SearchBarWidget extends StatelessWidget implements PreferredSizeWidget {
//   const SearchBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: OpenContainer(
//         transitionDuration: const Duration(milliseconds: 500),
//         closedElevation: 0.5,
//         closedShape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         closedBuilder: (BuildContext context, VoidCallback openContainer) {
//           return GestureDetector(
//             onTap: openContainer,
//             child: Container(
//               height: kToolbarHeight - 6,
//               width: Adaptive.w(100),
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: const Row(children: [
//                 Icon(Icons.search),
//                 SizedBox(width: 12),
//                 Text(
//                   'Search Contact',
//                   style: TextStyle(color: subTextColor),
//                 )
//               ]),
//             ),
//           );
//         },
//         openBuilder: (BuildContext context, VoidCallback _) {
//           return const SearchContactScreen();
//         },
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:houzeo_app/presentation/features/search_contact/screen/search_contact_screen.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      title: OpenContainer(
        transitionDuration: const Duration(milliseconds: 600),
        transitionType: ContainerTransitionType.fadeThrough,
        closedElevation: 0,
        closedColor: Colors.transparent,
        middleColor: Colors.white,
        openColor: Colors.white,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return GestureDetector(
            onTap: openContainer,
            child: Container(
              height: kToolbarHeight - 8,
              width: Adaptive.w(90),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: searchbarColor,
                // borderRadius: BorderRadius.circular(10),
                // border: Border.all(
                //   // color: baseColor,
                //   width: 0.5,
                // ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.black.withOpacity(0.7)),
                  const SizedBox(width: 12),
                  Text(
                    'Search contacts, numbers...',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        openBuilder: (BuildContext context, VoidCallback _) {
          return const SearchContactScreen();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 4);
}
