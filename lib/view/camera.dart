import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/model/bloc_provider.dart';
import 'package:flutter_book_keeping/view/image_view_page.dart';
import 'package:flutter_book_keeping/view/middle_widget.dart';
import 'package:flutter_book_keeping/model/receipt.dart';
import 'package:flutter_book_keeping/controller/receipt_bloc.dart';
import 'package:flutter_book_keeping/controller/user_management.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _receiptBloc = BlocProvider.of<ReceiptBloc>(context);
    _receiptBloc.setLoading = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _receiptBloc.getImageFile,
          builder: (context, snapshot) {
            return StreamBuilder(
              stream: _receiptBloc.loadingStream,
              builder: (context, snapshotLoading) {
                return Stack(
                  children: <Widget>[
                    getBody(snapshot),
                    (snapshotLoading.data != null && snapshotLoading.data)
                        ? Container(
                            color: Colors.black54,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container()
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget getBody(AsyncSnapshot snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        DisplayImage(snapshot.data, true),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MiddlePage(snapshot.data),
            ],
          ),
        )
      ],
    );
  }
}
