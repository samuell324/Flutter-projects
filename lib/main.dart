import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(MainWindow());
}

class MainWindow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainWindowState();
  }
}

class MainWindowState extends State {
  final List<Transaction> _userTransactions = [
    /*
    Transaction(
        id: 't1', title: 'New Shoes', amount: 35.75, dateTime: DateTime.now()),
    Transaction(
        id: 't2', title: 'New T-shirt', amount: 22.53, dateTime: DateTime.now()) */
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where((tx) =>
            tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String titleTransact, double amountTransact, DateTime chosenDate) {
    final newTransact = Transaction(
        title: titleTransact,
        amount: amountTransact,
        dateTime: chosenDate,
        id: DateTime.now().toString()
    );

    setState(() {
      _userTransactions.add(newTransact);
    });
  }

  void startAddNewTransact(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction (String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
          button: TextStyle(color: Colors.white)
          ), //textTheme
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'OpenSans', fontSize: 20)))),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction)
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  startAddNewTransact(context);
                })),
      ),
    );
  }
}
