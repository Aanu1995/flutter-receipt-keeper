import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_book_keeping/view/builder_page.dart';

class ReceiptPage extends StatelessWidget {
  final String category;

  ReceiptPage(this.category);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection(category).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError || !snapshot.hasData || snapshot.data.documents.length < 1) {
          return Center(
            child: Container(
              child: Text(
                  "No Data Available"
                ,style: TextStyle(
                fontSize: 24
              ),),
            ),
          );
        }
        else if(snapshot.hasData){
          return BuilderPage(snapshot.data.documents, category);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

}