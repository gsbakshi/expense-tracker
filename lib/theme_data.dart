import 'package:flutter/material.dart';

ThemeData dsOne() {
  return ThemeData(
    primarySwatch: Colors.lightGreen,
    // accentColor: Colors.amber,
    accentColor: Colors.green[400],
    fontFamily: 'Quicksand',
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
    appBarTheme: AppBarTheme(
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
}
