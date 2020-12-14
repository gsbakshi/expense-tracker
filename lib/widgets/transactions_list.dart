import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

import 'tx_card.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // padding: EdgeInsets.symmetric(
      //   vertical: 10,
      // ),
      // itemBuilder: (ctx, index) => txCard(transactions[index]),
      shrinkWrap: true,
      children: transactions.map((tx) => txCard(tx)).toList(),
    );
  }
}
