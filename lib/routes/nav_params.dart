import 'package:houzeo_app/models/contact_model.dart';
import 'package:houzeo_app/utils/constants/enums.dart';

class AddEditNavParams {
  AddOrEdit? enums;
  ContactModel? contactModel;

  AddEditNavParams({
    required this.enums,
    this.contactModel,
  });
}
