import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserManagement {
  Future<String> uploadImage(String name, File image) async{
   try{
     final StorageReference storageReference = FirebaseStorage.instance.ref().child(name);
     final StorageUploadTask task = storageReference.putFile(image);
     StorageTaskSnapshot taskSnapshot = await task.onComplete;
     String downloadURL = await taskSnapshot.ref.getDownloadURL();
     return downloadURL.toString();
   }
   on Exception{
      print(" Errot");
      throw Exception;
   }
  }

  Future<Null> addItem(Map map, String category)async{
    await Firestore.instance.collection(category).add(map);
   /*try{
     await Firestore.instance.runTransaction((transaction){
       transaction.set(Firestore.instance.collection(category).document(), map);

     });
   }
   catch(e){

   }*/
  }

  Future<Null> updateItem(var document,String companyName)async{
    await Firestore.instance.collection(document["category"]).document(document.documentID).updateData({
      "company_name":companyName,
    });
  }


  void getMessage(String message, Color color){
    Fluttertoast.instance.showToast(msg: message,backgroundColor: color,toastLength: Toast.LENGTH_SHORT);
  }

  void getMessage2(BuildContext context, String message, Color color){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message,style: TextStyle(color: Colors.white,fontSize: 18.0),
      ),backgroundColor: color,));
  }


  // function to delete documents from the Firestore
  Future<Null> deleteDocument(BuildContext context, String category, var document)async{
    await Firestore.instance.collection(category).document(document.documentID).delete().whenComplete((){
      deleteImage(document["id"]);
      Fluttertoast.instance.showToast(msg:  "Deleted Successfully",backgroundColor: Colors.green,toastLength: Toast.LENGTH_SHORT);
    }).catchError((error){
      Fluttertoast.instance.showToast(msg:  "Failed to delete",backgroundColor: Colors.red,toastLength: Toast.LENGTH_SHORT);
    });
  }

  // function to delete image from the Firebase storage
  Future<Null> deleteImage(String imagePath)async{
    await FirebaseStorage.instance.ref().child(imagePath).delete();
  }

  // This function shows dialog before a document item is deleted
  showAlertDialog(BuildContext context, String category, var document){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Delete",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: Colors.red
            ),
          ),
          content: Text(
              "Are you sure you want to delete this Item?",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "YES",
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                deleteDocument(context, category, document);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                  "Cancel",
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}


