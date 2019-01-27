import 'package:flutter/material.dart';
import 'package:flutter_book_keeping/model/bloc_provider.dart';
import 'package:flutter_book_keeping/home_page.dart';
import 'package:flutter_book_keeping/controller/receipt_bloc.dart';

const Color PRIMARY_COLOR = Colors.deepOrange;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReceiptBloc>(
      bloc: ReceiptBloc(),
      child: MaterialApp(
        title: "Receipt keeper",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: PRIMARY_COLOR),
        home: HomePage("Purchases"),
      ),
    );
  }
}
