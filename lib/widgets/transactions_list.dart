import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import './../models/transaction.dart';
import 'tx_card.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionsList(
    this.transactions,
    this.deleteTx,
  );

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  margin: EdgeInsets.only(
                    top: 30,
                  ),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return txCard(transactions[index], ctx, deleteTx);
                },
                itemCount: transactions.length,
              ),
            ],
          );
  }
}
