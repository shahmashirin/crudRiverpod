
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/userdata_model.dart';


class EdituserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUser(UserData editUserData) async {
    try {
      await _firestore.collection('list').doc(editUserData.uid).update(
        editUserData.toJson(),
      );
    } catch (error) {
      throw error.toString();
    }
  }
}
