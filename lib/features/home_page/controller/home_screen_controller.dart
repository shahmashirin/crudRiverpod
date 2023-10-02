import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudriverpod/models/userdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils.dart';
import '../repository/home_screen_repository.dart';

final homeScreenControllerProvider =
    NotifierProvider<HomeScreenController, bool>(() {
  return HomeScreenController();
});

final getHomeScreenProvider =
    StreamProvider.autoDispose.family<List<UserData>, String>((ref, search) {
  return ref.watch(homeScreenControllerProvider.notifier).getUserList();
});

final getDeteteduserProvider =
    StreamProvider.autoDispose.family<List<UserData>, String>((ref, search) {
  return ref.watch(homeScreenControllerProvider.notifier).getDeleteduserList();
});
final getUndeteteduserProvider =
    StreamProvider.autoDispose.family<List<UserData>, String>((ref, search) {
  return ref
      .watch(homeScreenControllerProvider.notifier)
      .getUndeleteduserList();
});

class HomeScreenController extends Notifier<bool> {
  HomeScreenController();

  @override
  bool build() {
    return false;
  }

  void createuser({
    required UserData userData,
    required BuildContext context,
    required WidgetRef ref,
    required DocumentReference reference,
  }) async {
    state = true;
    var addRepository = ref.watch(HomeScreenRepositoryProvider);
    final res = await addRepository.createUser(
        UserData: userData, ref: ref, reference: reference);
    state = false;
    res.fold(
        (l) => showUploadErrorMessage(
            showLoading: true, context, l.message, Colors.red), (r) {
      showSuccessToast(context,"User added Successfully");
    });
  }

  Stream<List<UserData>> getUserList() {
    var homescreenRepository = ref.watch(HomeScreenRepositoryProvider);
    return homescreenRepository.getUserList();
  }

  Stream<List<UserData>> getDeleteduserList() {
    var homescreenRepository = ref.watch(HomeScreenRepositoryProvider);
    return homescreenRepository.getDeleteduserList();
  }

  Stream<List<UserData>> getUndeleteduserList() {
    var homescreenRepository = ref.watch(HomeScreenRepositoryProvider);
    return homescreenRepository.getUndeleteduserList();
  }
}
