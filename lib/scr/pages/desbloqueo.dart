import 'package:flutter/material.dart';
import 'package:piproy/scr/pages/password.dart';
import 'package:piproy/scr/pages/pregunta_seguridad.dart';
import 'package:piproy/scr/sharedpreferences/usuario_pref.dart';
import 'package:piproy/scr/ui/input_decorations.dart';
import 'package:provider/provider.dart';

import '../providers/provider_pref.dart';

class Desbloqueo extends StatelessWidget {
  Desbloqueo({required this.desbloqueo});
  final bool desbloqueo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  validaPasword() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height);
    final pref = Provider.of<Preferencias>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              // height: height <= 500 ? 10 : 60,
              child: Text('Autorizar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).primaryColor,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 340,
              decoration: BoxDecoration(
                  color: pref.backgroundColor,
                  borderRadius: BorderRadius.circular(60.0)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            color: pref.backgroundColor,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                              // textCapitalization: TextCapitalization.words,
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Theme.of(context).primaryColor),
                              //    controller: _tipoControle,
                              validator: (valor) {
                                return valor!.trim() != pref.password
                                    ? "Clave incorrecta"
                                    : null;
                              },
                              decoration: InputDecorations.claveInputDecoration(
                                context: context,
                                hintText: "INGRESA LA CLAVE",
                                labelText: 'Clave',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PreguntaSeguridad()));
                              },
                              child: Text(
                                'Olvidó su Clave ?',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        //change width and height on your need width = 200 and height = 50
                                        //  minimumSize: Size(40, 20),
                                        backgroundColor:
                                            Color.fromRGBO(249, 75, 11, 1)),
                                    onPressed: () {
                                      if (validaPasword()) {
                                        if (desbloqueo) {
                                          final pref =
                                              Provider.of<Preferencias>(context,
                                                  listen: false);
                                          pref.modoConfig = !pref.modoConfig;
                                          SharedPref().modoConfig =
                                              pref.modoConfig;
                                          Navigator.of(context).pop();
                                        } else {
                                          /// vengo de password
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Password()));
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Aceptar',
                                      style: TextStyle(
                                          fontSize: height <= 500 ? 15 : 25,
                                          color: Colors.white),
                                    )),
                              ),
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        //change width and height on your need width = 200 and height = 50
                                        //minimumSize: Size(40, 20),
                                        backgroundColor:
                                            Color.fromRGBO(249, 75, 11, 1)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancelar',
                                      style: TextStyle(
                                          fontSize: height <= 500 ? 15 : 25,
                                          color: Colors.white),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<bool>('desbloqueo', desbloqueo));
  // }
}
