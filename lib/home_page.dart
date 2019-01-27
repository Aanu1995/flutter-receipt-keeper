import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/controller/receipt_bloc.dart';
import 'package:flutter_book_keeping/model/bloc_provider.dart';
import 'package:flutter_book_keeping/view/camera.dart';
import 'package:flutter_book_keeping/view/drawer_page.dart';
import 'package:flutter_book_keeping/view/receipt_page.dart';
import 'package:flutter_book_keeping/view/search.dart';

class HomePage extends StatefulWidget {
  final String category;

  HomePage(this.category);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReceiptBloc receiptBloc = BlocProvider.of<ReceiptBloc>(context);
    receiptBloc.getConnectivity();
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Rekeeper",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchPage(widget.category));
            },
          ),
        ],
      ),
      body: ReceiptPage(widget.category),
      drawer: Builder(
        builder: (context) {
          return DrawerPage();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CameraApp()));
        },
      ),
    );
  }
}
