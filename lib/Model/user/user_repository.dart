
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hair_haven/Model/user/user_model.dart';

import '../../data/respositories/authentication/authentication_respo.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  /// Function to save user data to Firebase
  Future<void> saveUserRecord(UserModel user) async{
    try{
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch(e) {
      throw (e.code);
    } on PlatformException catch(e) {
      throw (e.code);
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch user details based on user ID.
  Future<UserModel> fetchUserDetails() async{
    try{
      final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }
    } on FirebaseException catch(e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const AFormatException();
    } on PlatformException catch(e) {
      throw APlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

/// Function to update user data in firebase
  Future<void> updateUserDetails(UserModel updatedUser) async{
    try{
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseException catch(e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const AFormatException();
    } on PlatformException catch(e) {
      throw APlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

/// Update any field in specific Users collection
  Future<void> updateSingleField(Map<String, dynamic> json) async{
    try{
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FirebaseException catch(e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const AFormatException();
    } on PlatformException catch(e) {
      throw APlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

/// Function to remove user data from firebase
  Future<void> removeUserRecrod(String userId) async{
    try{
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch(e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const AFormatException();
    } on PlatformException catch(e) {
      throw APlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

// /// Upload any image
//  Future<String> uploadImage(String path , XFile image) async {
//    try{
//
//      final ref = FirebaseStorage.instance.ref(path).child(image.name);
//      await ref.putFile(File(image.path));
//      final url = await ref.getDownloadURL();
//      return url;
//
//    } on FirebaseException catch(e) {
//      throw TFirebaseException(e.code).message;
//    } on FormatException catch(_){
//      throw const TFormatException();
//    } on PlatformException catch(e) {
//      throw TPlatformException(e.code).message;
//    } catch(e){
//      throw 'Something went wrong. Please try again';
//    }
//  }

}
