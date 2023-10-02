import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../models/auth_model.dart';
import '../Repository/Auth_Repository.dart';

final userprovider = StateProvider<UserModel?>((ref) => null);
final authControllerProvider = StateNotifierProvider((ref) => AuthController(
  authRepositery: ref.watch(authRepositoryProvider),
  ref: ref,
));

//Change notifier provider
class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepositery;
  final Ref _ref;
  AuthController({required AuthRepository authRepositery, required Ref ref})
      : _authRepositery = authRepositery,
        _ref = ref,
        super(false);

  void signInWithGoogle(BuildContext context) async {
    state = true;

    final user = await _authRepositery.signInWithGoogle();
    state = false;
  }
}
