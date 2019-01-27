import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/model/bloc_provider.dart';
import 'package:flutter_book_keeping/main.dart';
import 'package:flutter_book_keeping/controller/receipt_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DisplayImage extends StatelessWidget{
  var _image;
  bool status; // check if the image is in file format or string, true for file format
                // false for string format.
  DisplayImage(this._image, [this.status = true]);

  @override
  Widget build(BuildContext context) {
    var receiptBloc = BlocProvider.of<ReceiptBloc>(context);
    return Container(
      child: Column(
        children: <Widget>[
          _image == null? Container(
            height:320.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey.withOpacity(0.5),
              image: DecorationImage(
                  image: AssetImage("assets/empty2.png"),
                  fit: BoxFit.contain),
            ),
          ):
          Container(
            height:status == true? 320.0:520,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey.withOpacity(0.3),
              image: DecorationImage(
                  image:_image.runtimeType == String?CachedNetworkImageProvider(_image): FileImage(_image,),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          status?Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Tooltip(
                message: "Camera",
                child: RaisedButton(
                  color: PRIMARY_COLOR,
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  child: Icon(Icons.photo_camera,color: Colors.white,),
                  onPressed:(){
                    receiptBloc.getCameraImage();
                  },
                ),
              ),
              Tooltip(
                  message: "Photo Library",
                child: RaisedButton(
                  color: PRIMARY_COLOR,
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  child: Icon(Icons.photo_library,color: Colors.white,),
                  onPressed:(){
                    receiptBloc.getStorageImage();
                  },
                ),
              )
            ],
          ):Container()
        ],
      ),
    );
  }

}