import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudriverpod/constants/firebase_constants.dart';
import 'package:crudriverpod/core/providers/firebase_providers.dart';
import 'package:crudriverpod/models/userdata_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final HomeScreenRepositoryProvider = Provider<HomeScreenRepository>((ref) {
  return HomeScreenRepository(firestore: ref.watch(firestoreProvider));
});

class HomeScreenRepository {
  final FirebaseFirestore _firestore;
  HomeScreenRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<UserData>> getUserList() {
    return _user.where('delete', isEqualTo: false).snapshots().map((event) =>
        event.docs
            .map((e) => UserData.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<UserData>> getDeleteduserList() {
    return _user.where('delete', isEqualTo: true).snapshots().map((event) =>
        event.docs
            .map((e) => UserData.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<UserData>> getUndeleteduserList() {
    return _user.where('delete', isEqualTo: false).snapshots().map((event) =>
        event.docs
            .map((e) => UserData.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }

//Create user repository


  createUser(
      {required UserData,
      required WidgetRef ref,
      required DocumentReference reference}) async {
    try {
      return right(reference.set(UserData.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(e.toString());
    }
   }


  CollectionReference get _user =>
      _firestore.collection(FirebaseConstants.users);
}
