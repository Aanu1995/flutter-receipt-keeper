import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/home_page.dart';
import 'package:flutter_book_keeping/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerPage extends StatelessWidget {
  TextStyle style = TextStyle(
    fontSize: 17.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
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
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Divider(),
        SizedBox(height: 10,),
        listItems("Advertisements",FontAwesomeIcons.buysellads, context),
        listItems("Rents", FontAwesomeIcons.renren, context),
        listItems("Repairs", FontAwesomeIcons.toolbox, context),
        listItems("Travels", Icons.card_travel, context),
        listItems("Taxes", FontAwesomeIcons.newspaper, context),
        listItems("Utilities", Icons.settings, context),
        listItems("Uncategorized", Icons.category, context),
      ],
    ));
  }

  Widget listItems(String category,  IconData icon, BuildContext context) {
    return InkWell(
      splashColor: Colors.green,
      highlightColor: Colors.grey,
      child: ListTile(
        leading: Icon(icon,color: PRIMARY_COLOR,),
        title: Text(
          category,
          style: style,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => HomePage(category)));
      },
    );
  }
}
