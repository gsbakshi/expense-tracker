import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tx;
  final Function removeTx;
  const TransactionItem({
    Key key,
    @required this.tx,
    @required this.removeTx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 8,
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${tx.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          tx.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(tx.date),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                onPressed: () => removeTx(tx.id),
                icon: const Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                label: const Text('Delete'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => removeTx(tx.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
