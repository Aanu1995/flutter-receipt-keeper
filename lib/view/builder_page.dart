import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/controller/receipt_bloc.dart';
import 'package:flutter_book_keeping/controller/user_management.dart';
import 'package:flutter_book_keeping/model/bloc_provider.dart';
import 'package:flutter_book_keeping/view/update_camera.dart';
import 'package:intl/intl.dart';

class BuilderPage extends StatelessWidget {
  final List _list;
  final String category;
  final formatCurrency = NumberFormat.currency(symbol: "€");
  UserManagement _userManagement = UserManagement();

  BuilderPage(this._list, this.category);

  @override
  Widget build(BuildContext context) {
    var _receiptBloc = BlocProvider.of<ReceiptBloc>(context);
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        var document = _list[index];
        return Builder(
            builder: (context){
              return GestureDetector(
                child: Card(
                  elevation: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 1.0),
                  child:Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purpleAccent,
                        radius: 24,
                        child: Text(
                          "Me",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          document["company_name"],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        document["date"]== null? "":document["date"],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                      ),
                      trailing: Text(
                        "${formatCurrency.format(document["expenses"])}",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> UpdateCameraApp(document)));
                      },
                    ),
                  ),
                ),
                onLongPress:(){
                  if (_receiptBloc.connectionStatus == ConnectivityResult.wifi ||
                      _receiptBloc.connectionStatus == ConnectivityResult.mobile) {

                  }
                  else{
                    _userManagement.getMessage2(context, "No Internet Connection", Colors.red);
                  }
                  _userManagement.showAlertDialog(context, category, document);
                },
              );
            },
        );
      },
    );
  }
}
