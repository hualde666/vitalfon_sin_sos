import 'package:flutter/material.dart';
import 'package:piproy/scr/sharedpreferences/usuario_pref.dart';

class ClaveFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String clave = SharedPref().password;
  String pregunta = SharedPref().pregunta;
  String respuesta = SharedPref().respuesta;
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
