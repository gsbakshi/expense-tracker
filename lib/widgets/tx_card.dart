import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

Widget txCard(Transaction tx, ctx) {
  return Card(
    margin: EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 8,
    ),
    elevation: 5,
    child: ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: FittedBox(
            child: Text(
              '\$${tx.amount.toStringAsFixed(2)}',
            ),
          ),
        ),
      ),
      title: Text(
        tx.title,
        style: Theme.of(ctx).textTheme.headline6,
      ),
      subtitle: Text(
        DateFormat.yMMMd().format(tx.date),
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    ),
  );
}
