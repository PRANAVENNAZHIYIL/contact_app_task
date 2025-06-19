import 'package:flutter/material.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/widget/profile_screen_options.dart';
import 'package:houzeo_app/presentation/features/dial_pad/provider/dial_pad_provider.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContactProfileScreenButtonsHeader extends StatelessWidget {
  final String contactNumber;
  const ContactProfileScreenButtonsHeader({
    super.key,
    required this.contactNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: CustomHeaderDelegate(
          child: Container(
            color: backgroundColor,
            child: Padding(
              padding: EdgeInsets.only(
                  left: Adaptive.w(5), right: Adaptive.w(5), top: 10),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  ProfileScreenOptionWidget(
                    title: 'Call',
                    icon: Icons.phone_outlined,
                    onPressed: () {
                      Provider.of<DialPadScreenController>(context,
                              listen: false)
                          .makeCall(context, contactNumber);
                    },
                  ),
                  ProfileScreenOptionWidget(
                      title: 'Text',
                      icon: Icons.message_outlined,
                      onPressed: () {}),
                  ProfileScreenOptionWidget(
                      title: 'Set up',
                      icon: Icons.videocam_outlined,
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ));
  }
}

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  CustomHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 100;
  @override
  double get minExtent => 100;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
