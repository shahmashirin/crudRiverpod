import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/userdata_model.dart';
import '../repository/edit_user_repository.dart';

final editUserRepositoryProvider = Provider<EdituserRepository>((ref) {
  return EdituserRepository();
});

final editUserControllerProvider = Provider<EditUserController>((ref) {
  return EditUserController(ref.watch(editUserRepositoryProvider));
});

class EditUserController {
  final EdituserRepository _userRepository;

  EditUserController(this._userRepository);

  updateUser(
      {required UserData userData,
      required String name,
      required int age,
      required String phone}) async {
    userData = userData.copyWith(phone: phone, age: age, name: name);
    await _userRepository.updateUser(userData);
  }
}
