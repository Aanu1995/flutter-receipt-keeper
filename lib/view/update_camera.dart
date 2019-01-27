import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/model/bloc_provider.dart';
import 'package:flutter_book_keeping/view/image_view_page.dart';
import 'package:flutter_book_keeping/controller/receipt_bloc.dart';
import 'package:flutter_book_keeping/view/update_middle_page.dart';


class UpdateCameraApp extends StatefulWidget {

  final document;

  UpdateCameraApp(this.document);
  
  @override
  _UpdateCameraAppState createState() => _UpdateCameraAppState();
}

class _UpdateCameraAppState extends State<UpdateCameraApp> {

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    var _receiptBloc = BlocProvider.of<ReceiptBloc>(context);
    _receiptBloc.setLoading = false ;
    _receiptBloc.setUpdateImage = widget.document["download_url"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Receipt Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: StreamBuilder(
            stream: _receiptBloc.getUpdateImageFile,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return getBody(snapshot);
              }
            },
          )
      ),
    );
  }

  Widget getBody(AsyncSnapshot snapshot){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        DisplayImage(snapshot.data,false),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              UpdateMiddlePage(snapshot.data,widget.document),
            ],
          ),
        )
      ],
    );
  }
}
