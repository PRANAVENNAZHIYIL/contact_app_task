import 'package:flutter/material.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/provider/add_edit_contact_provider.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/widget/add_edit_appbar.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/widget/add_edit_circle_avathar_widget.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/widget/contact_fields.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/widget/photo_change_remove.dart';
import 'package:houzeo_app/presentation/features/add_edit_Contact_screen/widget/submit_button_widget.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/paddings.dart';
import 'package:houzeo_app/utils/constants/sized_boxes.dart';
import 'package:provider/provider.dart';

class AddOrEditContactScreen extends StatefulWidget {
  const AddOrEditContactScreen({
    super.key,
  });

  @override
  State<AddOrEditContactScreen> createState() => _AddOrEditContactScreenState();
}

class _AddOrEditContactScreenState extends State<AddOrEditContactScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AddEditProvider>(builder: (context, provider, child) {
      return provider.pageIs != null && provider.pageContext != null
          ? Scaffold(
              body: CustomScrollView(
                slivers: [
                  AddOrEditContactScreenAppBarWidget(
                      enums: provider.pageIs!.enums!),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: extraPadding,
                          child: Column(
                            children: [
                              sizedBoxHeight20,
                              AddOrEditProfileScreenCircleAvatarWidget(
                                controller: provider,
                                contact: provider.pageIs!.contactModel,
                              ),
                              sizedBoxHeight05,
                              PhotoChangeAndRemoveButton(
                                controller: provider,
                                enums: provider.pageIs!.enums!,
                                image:
                                    provider.pageIs!.contactModel?.profilePic,
                              ),
                              sizedBoxHeight20,
                              FieldsWidget(
                                  size: size,
                                  type: "First Name",
                                  stream: provider.valFirstname,
                                  onChanged: provider.changeUserFirstName,
                                  textEditingController:
                                      provider.firstNameController,
                                  requiredField: true),
                              FieldsWidget(
                                  size: size,
                                  type: "Last Name",
                                  stream: provider.valLasttname,
                                  onChanged: provider.changeUserLastName,
                                  textEditingController:
                                      provider.lastNameController,
                                  requiredField: false),
                              FieldsWidget(
                                  size: size,
                                  type: "company",
                                  stream: provider.valCompany,
                                  onChanged: provider.changeUserCompany,
                                  textEditingController:
                                      provider.companyNameController,
                                  requiredField: false),
                              FieldsWidget(
                                  size: size,
                                  type: "Mobile Number",
                                  stream: provider.valMobileNumber,
                                  onChanged: provider.changeUserMobileNumber,
                                  textEditingController:
                                      provider.phoneController,
                                  requiredField: true),
                              FieldsWidget(
                                  size: size,
                                  type: "Email",
                                  stream: provider.valEmail,
                                  onChanged: provider.changeUserEMail,
                                  textEditingController:
                                      provider.emailController,
                                  requiredField: false),
                              SubmitButtonWidget(
                                stream: provider.getSubmitButton,
                                enums: provider.pageIs!.enums!,
                                provider: provider,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
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

  @override
  void dispose() {
    super.dispose();
  }
}
