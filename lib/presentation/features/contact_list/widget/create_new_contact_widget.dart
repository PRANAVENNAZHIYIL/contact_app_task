import 'package:flutter/material.dart';
import 'package:houzeo_app/routes/nav_params.dart';
import 'package:houzeo_app/utils/constants/colors.dart';
import 'package:houzeo_app/utils/constants/enums.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateNewContactButton extends StatelessWidget {
  const CreateNewContactButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/AddEditScreen",
              arguments: AddEditNavParams(enums: AddOrEdit.add),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: createnew.withOpacity(0.15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF7ED348),
                ),
                child: Icon(
                  Icons.add,
                  size: 18.sp,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Create new contact',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
