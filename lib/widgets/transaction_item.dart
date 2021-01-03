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
        vertical: 6,
        horizontal: 12,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Material(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(12),
          // radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FittedBox(
              child: Text(
                '\$${tx.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.w500,
                      // color: Theme.of(context).textTheme.button.color,
                    ),
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
