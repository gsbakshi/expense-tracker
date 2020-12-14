import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

Widget txCard(Transaction tx) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 8,
    ),
    child: Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              '\$${tx.amount}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white.withOpacity(1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tx.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(tx.date),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
