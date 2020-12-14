import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

import 'tx_card.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      // height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return txCard(transactions[index]);
        },
        itemCount: transactions.length,
      ),
    );
  }
}
