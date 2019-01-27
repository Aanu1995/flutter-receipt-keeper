import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/main.dart';
import 'package:flutter_book_keeping/view/builder_page.dart';

class SearchPage extends SearchDelegate{
  final String category;

  SearchPage(this.category);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear,color: PRIMARY_COLOR,),
        onPressed: (){
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back,color: PRIMARY_COLOR),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
          List list = [];
          for(int i=0; i<snapshot.data.documents.length; i++){
            if(snapshot.data.documents[i]["company_name"].toString().toLowerCase().contains(query.toLowerCase()) ||
                snapshot.data.documents[i]["date"].toString().toLowerCase().contains(query.toLowerCase())){
              list.add(snapshot.data.documents[i]);
            }
          }
          return BuilderPage(list, category);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }


}