import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDateSelector extends StatefulWidget {
  final Function selector;
  CupertinoDateSelector({
    Key key,
    @required this.selector,
  }) : super(key: key);

  @override
  _CupertinoDateSelectorState createState() => _CupertinoDateSelectorState();
}

class _CupertinoDateSelectorState extends State<CupertinoDateSelector> {
  DateTime date = DateTime.now();
  void _submitDate() {
    widget.selector(date);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InkWell(
              splashColor: Color.fromRGBO(220, 160, 120, 1),
              child: FlatButton(
                textColor: Theme.of(context).errorColor,
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            InkWell(
              splashColor: Color.fromRGBO(220, 160, 120, 1),
              child: FlatButton(
                textColor: Theme.of(context).accentColor,
                onPressed: _submitDate,
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            maximumDate: DateTime.now(),
            minimumDate: DateTime(20, 12, 2020),
            maximumYear: 2021,
            minimumYear: 2020,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime pickedDate) {
              setState(() {
                date = pickedDate;
              });
            },
          ),
        ),
      ],
    );
  }
}
