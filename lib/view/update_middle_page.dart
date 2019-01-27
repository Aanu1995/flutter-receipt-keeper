import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/model/bloc_provider.dart';
import 'package:flutter_book_keeping/main.dart';
import 'package:flutter_book_keeping/controller/receipt_bloc.dart';
import 'package:flutter_book_keeping/controller/user_management.dart';

class UpdateMiddlePage extends StatelessWidget{
  var _image;
  var _document;

  UpdateMiddlePage(this._image, this._document);

  UserManagement _userManagement = UserManagement();

  @override
  Widget build(BuildContext context) {
    var _receiptBloc = BlocProvider.of<ReceiptBloc>(context);
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text("Category: ${_document["category"]}",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20.0,),
        TextField(
          keyboardType: TextInputType.text,
          cursorColor: PRIMARY_COLOR,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              labelText: "Company name",
              hintText: _document["company_name"],
              border: OutlineInputBorder()),
          onChanged: (value) {
            _receiptBloc.receipt.companyName = value;
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
                "Update",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              onPressed: ()async{
                try{
                  if( _receiptBloc.receipt.companyName != null  &&  _receiptBloc.receipt.companyName != ""){
                      if (_receiptBloc.connectionStatus == ConnectivityResult.wifi ||
                          _receiptBloc.connectionStatus == ConnectivityResult.mobile){

                      }
                      else{
                        _userManagement.getMessage("No Internet Connection", Colors.red,);
                      }
                      await _userManagement.updateItem(_document, _receiptBloc.receipt.companyName).whenComplete((){
                        _userManagement.getMessage("Data Updated Successfully", Colors.green,);
                        Navigator.pop(context);
                      }).catchError((error){
                        _userManagement.getMessage("Failed to Upload Data: $error", Colors.red,);
                      });
                  }
                  else{
                    _userManagement.getMessage2(context,"Fields can not be empty", Colors.red,);
                  }
                }on Exception{
                  print("Error just occurred");
                }
              },
            );
          },
        ),
      ],
    );
  }
}