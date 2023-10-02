

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants/auth_firebase_constants.dart';
import '../../../constants/auth_image_constants.dart';

import '../../../models/auth_model.dart';



final fireStoreProvider = Provider((ref) => FirebaseFirestore.instance);
final authProvider = Provider((ref) => FirebaseAuth.instance);
final storageProvider = Provider((ref) => FirebaseStorage.instance);
final googleSignInProvider = Provider((ref) => GoogleSignIn());

final authRepositoryProvider = Provider((ref) => AuthRepository(
  firestore: ref.read(fireStoreProvider),
  auth: ref.read(authProvider),
  googleSignIn: ref.read(googleSignInProvider),
));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get users =>
      _firestore.collection(FirebaseConstants1.userCollections);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      UserModel? userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? 'No name',
          profilepic: userCredential.user!.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          karma: 0,
          awards: [],
        );
        await users.doc(userCredential.user!.uid).set(userModel.toMap());
      }
    } catch (e) {
      print(e);
    }
  }
}
