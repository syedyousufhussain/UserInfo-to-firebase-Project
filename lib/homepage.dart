import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_page.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {

 ImagePicker picker = ImagePicker();
 
//Initiating Authentication variables
bool loading=false;

UserCredential ?userCredential;
TextEditingController email= TextEditingController();
TextEditingController name=TextEditingController();
File? _image;


//initialize database
var db = FirebaseFirestore.instance;
var storage = FirebaseStorage.instance;




//initiating Authentication function
  Future sendData() async{
    // final Reference storageRef = storage.ref().child('images/${DateTime.now().toString()}');
   
    // final UploadTask uploadTask = storageRef.putFile(File(_image!.path));
    // final TaskSnapshot downloadUrl = (await uploadTask);
    db.collection('userBio')
          .doc(userCredential?.user!.uid)
          .set({
            "email": email.text.trim(),
             "name": name.text.trim(),
            //  'picture': await downloadUrl.ref.getDownloadURL(),
             });
             }
             //adding validation
    void validation(){
        if(email.text.trim().isEmpty || email.text.trim() == null){
          const snackBar=SnackBar(content:Text("Username is Empty"));
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
           return;
           }
    else if (name.text.trim().isEmpty || name.text.trim() == null) {
        const snackBar=SnackBar(content: Text("Email is empty"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } 
    else {
      setState(() {
        loading=true;
      });
      sendData();
      }
    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Form"),
        centerTitle: true,
      ),
      body:Container(
        height:1350,
        width:850,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            TextFormField(
          controller:email,
          decoration:const InputDecoration(
                        labelText:("Email"),
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(10)),
                          )
                        )
                      ),
                      const SizedBox(height: 7,),
                      TextFormField(
                        controller:name,
                        decoration:const InputDecoration(
                        labelText:("Name"),
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(10)),
                          )
                        )
                      ),
                      const SizedBox(height: 7),
                      ElevatedButton(
      onPressed: () async {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      },
      child: Text('Select Image'),),
      
    
    ElevatedButton(
      onPressed:() {validation();},
      child: const Text('Submit'),
    ),
    ElevatedButton(onPressed: (){Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => userPage(imageFile:_image)));}, child: const Text("Go to User Page"))
             ],),
      )
    );
  }
}
