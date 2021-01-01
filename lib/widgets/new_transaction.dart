// import 'dart:io';

import 'package:expense_tracker/widgets/adaptive/adaptive_button.dart';
import 'package:expense_tracker/widgets/adaptive/adaptive_textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:expense_tracker/theme_data.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    // Platform.isIOS
    //     ? CupertinoDatePicker(
    //         initialDateTime: DateTime.now(),
    //         maximumDate: DateTime.now(),
    //         minimumDate: DateTime(2019),
    //         mode: CupertinoDatePickerMode.date,
    //         onDateTimeChanged: (DateTime pickedDate) {
    //           print(pickedDate);
    //         },
    //       )
    //     :
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _query = MediaQuery.of(context);

    final _bottomPad = _query.viewInsets.bottom == 0;

    final dateSelector = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            _selectedDate == null
                ? 'No Date Chosen'
                : 'Picked Date : ${DateFormat.yMMMd().format(_selectedDate)}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        InkWell(
          splashColor: Color.fromRGBO(220, 160, 120, 1),
          child: FlatButton(
            textColor: Theme.of(context).accentColor,
            onPressed: _presentDatePicker,
            child: Text(
              'Choose Date',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );

    final heading = Padding(
      padding: const EdgeInsets.only(
        top: 12,
      ),
      child: Text(
        'Add New Transaction',
        style: Theme.of(context).textTheme.headline5.copyWith(
              color: Theme.of(context).secondaryHeaderColor,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w600,
            ),
      ),
    );

    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        elevation: 0,
        child: Container(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: 12,
            bottom: _bottomPad
                ? _query.size.height * 0.2
                : _query.viewInsets.bottom * 1.2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              heading,
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 2,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 12,
                ),
                child: AdaptiveTextField(
                  text: 'Title',
                  prefix: null,
                  controller: _titleController,
                  handler: _submitData,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 6,
                ),
                child: AdaptiveTextField(
                  text: 'Amount',
                  prefix: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      '\$',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  controller: _amountController,
                  handler: _submitData,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: dateSelector,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  AdaptiveButton(
                    label: 'Add Transaction',
                    handler: _submitData,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
