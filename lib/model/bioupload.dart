import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../homepage.dart';

var storage = FirebaseStorage.instance;
var db = FirebaseFirestore.instance;

UserCredential ?userCredential;



Future<void> uploadData(String email,String name,File image) async {
  // Upload image to Firebase Storage
  final Reference storageRef = storage.ref().child('images/${DateTime.now().toString()}');
  final UploadTask uploadTask = storageRef.putFile(image);
  final TaskSnapshot downloadUrl = (await uploadTask);

  // Create a document in the 'users' collection with the image URL and user input data
  await db.collection('userBio').doc(userCredential?.user!.uid).set({
    'email':email,
    'name': name,
    'picture': await downloadUrl.ref.getDownloadURL(),
  });
}