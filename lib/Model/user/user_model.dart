import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class UserModel {
  // Keep those values final which you do not want to update
  final String id;
  String firstName;

  final String email;

  String profilePicture;

  /// Constructor for userModel
  UserModel({
    required this.id,

    required this.email,
    required this.firstName,

    required this.profilePicture,
  });



   /// Static function to create an empty user model
 static UserModel empty() => UserModel(id: '', email: '', firstName: '',  profilePicture: '');

   /// Convert model to JSON structure for storing data in Firebase
    Map<String, dynamic> toJson(){
      return{
        "FirstName": firstName,
        "Email": email,
        "ProfilePicture": profilePicture,
      };
    }

    /// Factory method to create a UserModel from a firebase document snapshot
     factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
      if(document.data() != null){
        final data = document.data()!;
        return UserModel(
            id: document.id,
            email: data['Email'] ?? '',
            firstName: data['FirstName'] ?? '',
            profilePicture: data['ProfilePicture'] ?? '',
        );
      }
      return UserModel.empty();
     }
}
