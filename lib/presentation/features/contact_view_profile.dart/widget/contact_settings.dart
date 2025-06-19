import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/provider/view_contact_profile_provider.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/widget/contact_setting_option_widget.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:houzeo_app/widgets/loading_dialouge.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContactSettingsWidget extends StatelessWidget {
  final ContactModel contact;
  const ContactSettingsWidget({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBoxHeight20,
            Divider(thickness: 0.6, color: Colors.grey.shade400),
            sizedBoxHeight15,
            Text(
              'Contact Settings',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              separatorBuilder: (_, __) => sizedBoxHeight10,
              itemBuilder: (context, index) {
                return ContactSettingsOptionWidget(
                  icon: Icons.settings_outlined,
                  title: 'Contact Setting ${index + 1}',
                  onPressed: () {},
                );
              },
            ),
            sizedBoxHeight20,
            ContactSettingsOptionWidget(
              icon: Icons.delete_outline_outlined,
              title: 'Delete Contact',
              color: Colors.red,
              onPressed: () {
                deleteAccountDialogue(context);
              },
            ),
            sizedBoxHeight30,
            Divider(thickness: 0.6, color: Colors.grey.shade400),
            sizedBoxHeight15,
            const Center(
              child: Text(
                'Houzeo',
                style: TextStyle(color: subTextColor),
              ),
            ),
            sizedBoxHeight20,
          ],
        ),
      ),
    );
  }

  void deleteAccountDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            'Are you sure you want to delete this contact?',
            style: TextStyle(fontSize: 16.5.sp),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No')),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      showLoadingDialogue(context);
                      await Provider.of<ViewContactProfileScreenController>(
                        context,
                        listen: false,
                      ).deleteContact(context, contact);
                    },
                    child: const Text('Yes')),
              ],
            )
          ],
        );
      },
    );
  }
}
