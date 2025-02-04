import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/provider_pref.dart';
import 'package:provider/provider.dart';

class InputDecorations {
  static InputDecoration claveInputDecoration(
      {BuildContext? context,
      required String hintText,
      required String labelText}) {
    final pref = Provider.of<Preferencias>(context!);
    return InputDecoration(
        errorStyle: TextStyle(
            color: (pref.paleta == '5') ? Colors.red[200] : Colors.green[200],
            fontSize: 25),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 30,
          color: Theme.of(context).primaryColor,
        ),
        hintStyle: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor));
  }
}
