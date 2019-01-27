import 'dart:async';
import 'dart:io';
import 'package:flutter_book_keeping/model/receipt.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_book_keeping/model/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ReceiptBloc implements BlocBase{
  Receipt receipt =  Receipt();
  ConnectivityResult connectionStatus;
  bool isLoading = false;
  int _selectedIndex = 0;

  // connectivity
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> subscription;

  BehaviorSubject<dynamic> _imageController = BehaviorSubject();
  Stream<dynamic> get getImageFile => _imageController.stream;

  PublishSubject<int> _categoryController = PublishSubject();
  Stream<int> get getCategory => _categoryController.stream;
  int get selectedIndex => _selectedIndex;

  PublishSubject<bool> _loadingController = PublishSubject();
  Stream<bool> get loadingStream => _loadingController.stream;

  BehaviorSubject<dynamic> _updateImageController = BehaviorSubject();
  Stream<dynamic> get getUpdateImageFile =>_updateImageController.stream;


  @override
  void dispose() {
    getConnectivity();
    subscription.cancel();
   _imageController.close();
    _updateImageController.close();
   _categoryController.close();
   _loadingController.close();
  }

  ReceiptBloc(){
    setLoading = false ;
  }

  Future getCameraImage() async {
    try{
       File file = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 512,maxWidth: 512);
       /*var value = await file.readAsBytes();
       print(value.length);*/
       _imageController.add(file);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future getStorageImage() async {
    try{
      File file = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 512,maxWidth: 512);
      /*var value = await file.readAsBytes();
       print(value.length);*/
      _imageController.add(file);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future getUpdatedCameraImage() async {
    try{
      File file = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 512,maxWidth: 512);
      _updateImageController.add(file);
    }
    catch(e){
      print(e.toString());
    }
  }


  set setCategory(int value){
    _selectedIndex = value;
    _categoryController.add(value);
  }

  set setLoading(bool value){
    _loadingController.add(value);
  }

  set setUpdateImage(var value){
    _updateImageController.add(value);
  }




  void getConnectivity() {
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          connectionStatus = result;
          print(connectionStatus);
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            print("There is connection");
          }
          else{
          }
        });
  }


}