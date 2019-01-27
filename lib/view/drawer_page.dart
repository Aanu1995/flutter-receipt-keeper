import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/home_page.dart';
import 'package:flutter_book_keeping/main.dart';

class DrawerPage extends StatelessWidget {
  TextStyle style = TextStyle(
    fontSize: 18.0,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            "ABC Accountants & Co",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.5,
                color: Colors.white),
          ),
          accountEmail: Text(
            "james@abcaccountants.com",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/index.png"),
          ),
          decoration: BoxDecoration(
            color: PRIMARY_COLOR,
          ),
        ),
        ListTile(
          title: Text(
            "Categories",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,color: PRIMARY_COLOR),
          ),
          trailing: FlatButton(
            onPressed:()=> Navigator.pop(context),
            child:Icon(Icons.exit_to_app,color: PRIMARY_COLOR,size: 30,),
          ),
        ),
        SizedBox(height: 20,),
        listItems("Advertisements", context),
        listItems("Rents", context),
        listItems("Repairs", context),
        listItems("Travels", context),
        listItems("Taxes", context),
        listItems("Utilities", context),
        listItems("Uncategorized",  context),
      ],
    ));
  }

  Widget listItems(String category,  BuildContext context) {
    return Card(
      elevation: 0.0,
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ListTile(
          title: Text(
            category,
            style: style,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomePage(category)));
          },
        ),
      ),
    );
  }
}
