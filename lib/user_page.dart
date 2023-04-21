import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'homepage.dart';

class userPage extends StatefulWidget {
  const userPage({super.key, File? imageFile});

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Data"),
        centerTitle: true,
      ),
      body: Container(
        height: 1850,
        child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('userBio').snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return const Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Text('Loading...');
    }

    return ListView(
      children: snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

        return ListTile(
          leading: const Text("Name"),
          title: Text(data['name'].toString()),
          subtitle: const Text('Email'),
          trailing: Text(data['email'].toString()),
        );
      }).toList(),
      
    );
    
  },
),
      ),
    );
  }
}