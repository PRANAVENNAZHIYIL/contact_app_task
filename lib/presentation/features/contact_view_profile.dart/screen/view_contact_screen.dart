import 'package:flutter/material.dart';
import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/provider/view_contact_profile_provider.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/widget/connected_apps_widget.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/widget/contact_info_widget.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/widget/contact_option_header.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/widget/contact_settings.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/widget/profile_name_and_image_widget.dart';
import 'package:houzeo_app/presentation/features/contact_view_profile.dart/widget/view_profile_app_bar.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class ViewContactProfileScreen extends StatefulWidget {
  const ViewContactProfileScreen({
    super.key,
  });

  @override
  State<ViewContactProfileScreen> createState() =>
      _ViewContactProfileScreenState();
}

class _ViewContactProfileScreenState extends State<ViewContactProfileScreen> {
  ContactModel? contact;

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     final provider = Provider.of<ViewContactProfileScreenController>(context,
  //         listen: false);
  //     provider.inittiatePage(context);
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewContactProfileScreenController>(
        builder: (context, provider, child) {
      return provider.profiledata != null
          ? Scaffold(
              body: CustomScrollView(
                slivers: [
                  ViewProfileScreenAppBarWidget(
                      contact: provider.profiledata!.contact!),
                  ProfileNameAndImageWidget(
                      contactModel: provider.profiledata!.contact!),
                  ContactProfileScreenButtonsHeader(
                      contactNumber:
                          provider.profiledata!.contact!.phoneNumber),
                  ContactInfoWidget(
                      contactNumber:
                          provider.profiledata!.contact!.phoneNumber),
                  const ConnectedAppsWidget(),
                  ContactSettingsWidget(contact: provider.profiledata!.contact!)
                ],
              ),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
    });
  }
}
