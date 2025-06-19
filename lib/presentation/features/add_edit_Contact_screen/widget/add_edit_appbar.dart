import 'package:flutter/material.dart';
import 'package:houzeo_app/utils/constants/enums.dart';
import 'package:houzeo_app/widgets/icon_button.dart';

class AddOrEditContactScreenAppBarWidget extends StatelessWidget {
  final AddOrEdit enums;
  const AddOrEditContactScreenAppBarWidget({super.key, required this.enums});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: HouzeoIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          isAppBarBackButton: true,
          icon: Icons.arrow_back),
      titleSpacing: 5,
      title: Text('${enums == AddOrEdit.add ? 'Add' : 'Edit'} Contact'),
    );
  }
}
