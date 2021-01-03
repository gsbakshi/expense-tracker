import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart'; // ## 1

import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transactions_list.dart';
import 'models/transaction.dart';

void main() {
  // ## Make the app orientation fixed in Portrait Up mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp],
  // );
  // ## 1
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themer = ThemeData(
      primarySwatch: Colors.lightGreen,
      accentColor: Colors.indigo,
      // accentColor: Colors.green[400],
      errorColor: Colors.red,
      buttonColor: Colors.green[400],
      secondaryHeaderColor: Colors.indigo,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            headline5: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            button: TextStyle(
              color: Colors.white,
            ),
          ),
      appBarTheme: AppBarTheme(
        color: Colors.green[400],
        textTheme: ThemeData.dark().textTheme.copyWith(
              headline6: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
      ),
    );
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: themer,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
    String txTitle,
    double txAmount,
    DateTime chosenDate,
  ) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _triggerNewTx(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => NewTransaction(_addNewTransaction),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  Widget txListWidget(double screenHeight) {
    return Container(
      height: screenHeight,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TransactionsList(
        _userTransactions,
        _deleteTransaction,
      ),
    );
  }

  List<Widget> _buildLandscapeContent(
    double height,
    Widget txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              'Show Chart',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: height * 0.75,
              child: Chart(_recentTransactions),
            )
          : txListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(
    double height,
    Widget txListWidget,
  ) {
    return [
      Container(
        height: height * 0.25,
        child: Chart(_recentTransactions),
      ),
      txListWidget,
    ];
  }

  Widget _buildBody(
    double height,
    bool landscape,
  ) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (landscape)
              ..._buildLandscapeContent(
                height,
                txListWidget(height),
              ),
            if (!landscape)
              ..._buildPortraitContent(
                height,
                txListWidget(height),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Theme.of(context).appBarTheme.color,
            middle: Text('Expense Tracker'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.black,
                  ),
                  onTap: () => _triggerNewTx(context),
                ),
              ],
            ),
          )
        : AppBar(
            backgroundColor: Theme.of(context).appBarTheme.color,
            title: Text('Expense Tracker'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _triggerNewTx(context),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final isLandscape = query.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAppBar();

    final screenHeight =
        query.size.height - appBar.preferredSize.height - query.padding.top;

    final pageBody = _buildBody(
      screenHeight,
      isLandscape,
    );

    final fab = Platform.isIOS
        ? Container()
        : FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _triggerNewTx(context),
          );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation: isLandscape
                ? FloatingActionButtonLocation.endFloat
                : FloatingActionButtonLocation.centerFloat,
            floatingActionButton: fab,
          );
  }
}
