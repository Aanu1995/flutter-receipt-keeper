import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/model/bloc_provider.dart';
import 'package:flutter_book_keeping/main.dart';
import 'package:flutter_book_keeping/controller/receipt_bloc.dart';
import 'package:flutter_book_keeping/controller/user_management.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class MiddlePage extends StatelessWidget{
  var _image;

  MiddlePage(this._image);

  final List<String> list = ["Advertisements","Rents","Repairs","Travels","Taxes","Utilities","Uncategorized"];
  final TextStyle popButtonTextStyle = TextStyle(color: Colors.black,fontSize: 14,);
  UserManagement _userManagement = UserManagement();
  var _random = Random();

  @override
  Widget build(BuildContext context) {
    var _receiptBloc = BlocProvider.of<ReceiptBloc>(context);
    var _receipt = _receiptBloc.receipt;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Category: ",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20.0,),
            StreamBuilder(
              stream: _receiptBloc.getCategory,
                builder: (context, snapshot2){
                  return PopupMenuButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(list[_receiptBloc.selectedIndex],style:popButtonTextStyle,),
                        Icon(Icons.arrow_drop_down,color: Colors.black,)
                      ],
                    ),
                    itemBuilder: (BuildContext context){
                      return <PopupMenuItem<int>>[
                        PopupMenuItem(
                          child: Text(list[0],style:popButtonTextStyle,),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text(list[1],style:popButtonTextStyle,),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text(list[2],style:popButtonTextStyle,),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text(list[3],style:popButtonTextStyle,),
                          value: 3,
                        ),
                        PopupMenuItem(
                          child: Text(list[4],style:popButtonTextStyle,),
                          value: 4,
                        ),
                        PopupMenuItem(
                          child: Text(list[5],style:popButtonTextStyle,),
                          value: 5,
                        ),
                        PopupMenuItem(
                          child: Text(list[6],style:popButtonTextStyle,),
                          value: 6,
                        ),
                      ];
                    },
                    onSelected:(index){
                      _receiptBloc.setCategory = index ;
                    },
                  );
                },
            )
          ],
        ),
        SizedBox(height: 40.0,),
        TextField(
          keyboardType: TextInputType.text,
          cursorColor: PRIMARY_COLOR,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              labelText: "Company name",
              hintText: "Enter Company name",
              border: OutlineInputBorder()),
          onChanged: (value) {
            _receipt.companyName = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.number,
          cursorColor: PRIMARY_COLOR,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: "Expense",
            hintText: "Enter amount spent",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            _receipt.expenses = double.parse(value);
          },
        ),
        SizedBox(
          height: 30,
        ),
        Builder(
          builder: (context) {
            return RaisedButton(
              padding: EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 16.0),
              color: PRIMARY_COLOR,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              onPressed: ()async{
                try{
                  String name = "receipts/${list[_receiptBloc.selectedIndex].toLowerCase()}/${_random.nextInt(100000).toString()}.jpg";
                  _receipt.id = name;
                  if(_receipt.companyName != null && _receipt.expenses != null && _receipt.companyName != ""){
                    if(_image != null){
                      if (_receiptBloc.connectionStatus == ConnectivityResult.wifi ||
                          _receiptBloc.connectionStatus == ConnectivityResult.mobile){

                        _receiptBloc.setLoading = true ;

                        await _userManagement.uploadImage(name, _image).then((value){
                          print(value);
                          _receipt.downloadURL = value;
                          _receipt.category = list[_receiptBloc.selectedIndex];
                          _receipt.date = DateFormat.yMMMd().format(DateTime.now());

                        }).whenComplete((){
                          _userManagement.getMessage("Images Uploaded Successfully", Colors.green,);
                        }).catchError((error){
                          _userManagement.getMessage("Failed to Upload Image: $error", Colors.red,);
                        });
                        await _userManagement.addItem(_receipt.toMap(),list[_receiptBloc.selectedIndex]).whenComplete((){
                          _userManagement.getMessage("Data Uploaded Successfully", Colors.green,);
                          Navigator.pop(context);
                        }).catchError((error){
                          _userManagement.getMessage("Failed to Upload Data: $error", Colors.red,);
                        });
                      }
                      else{
                        _userManagement.getMessage2(context,"No Internet Connection", Colors.red,);
                      }
                    }
                    else{
                      _userManagement.getMessage("Image of Receipts must be taken", Colors.red,);
                    }
                  }
                  else{
                    _userManagement.getMessage2(context,"Fields can not be empty", Colors.red,);
                  }
                }on Exception{
                  print("Error just occurred");
                }
                _receiptBloc.setLoading = false;
              },
            );
          },
        ),
      ],
    );
  }
}