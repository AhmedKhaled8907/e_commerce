import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel => userModel;

  Future<UserModel?> getUserData() async {
    final fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    final uid = user?.uid;
    if (user == null) {
      return null;
    }
    try {
      final userDoc = await fireStore.collection('users').doc(uid).get();
      final userDocDisc = userDoc.data();
      userModel = UserModel(
        userId: userDoc.get('userId'),
        userName: userDoc.get('userName'),
        userEmail: userDoc.get('userEmail'),
        userImage: userDoc.get('userImage'),
        createdAt: userDoc.get('createdAt'),
        userCart:
            userDocDisc!.containsKey('userCart') ? userDoc.get('userCart') : [],
        userWish:
            userDocDisc.containsKey('userWish') ? userDoc.get('userWish') : [],
      );
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
