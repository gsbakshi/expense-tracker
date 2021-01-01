import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final Function handler;
  const AdaptiveTextField(
      {Key key,
      @required this.text,
      @required this.controller,
      @required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            padding: const EdgeInsets.all(12),
            placeholder: text,
            controller: controller,
            onSubmitted: (_) => handler(),
            autofocus: true,
          )
        : TextField(
            decoration: InputDecoration(
              labelText: text,
            ),
            controller: controller,
            onSubmitted: (_) => handler(),
            autofocus: true,
          );
  }
}
