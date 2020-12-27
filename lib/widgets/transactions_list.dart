import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import './../models/transaction.dart';
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
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text('No transactions added yet'),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  margin: EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Text(
                //   '${DateFormat.yMMMd().format(DateTime.now())}',
                // ),
                // ListView.builder(itemBuilder: (ctx, index) {
                //   return Container(
                //     color: Colors.black,
                //   )
                // },),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return txCard(transactions[index], ctx);
                  },
                  itemCount: transactions.length,
                ),
              ],
            ),
    );
  }
}
