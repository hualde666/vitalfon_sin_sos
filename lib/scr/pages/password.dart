import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/provider_pref.dart';
import 'package:piproy/scr/sharedpreferences/usuario_pref.dart';
import 'package:provider/provider.dart';
import 'package:piproy/scr/providers/clave_form.dart';
import 'package:piproy/scr/ui/input_decorations.dart';

class Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Clave de bloqueo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
              )),
          SizedBox(
            height: 50,
          ),
          ChangeNotifierProvider(
            create: (_) => new ClaveFormProvider(),
            child: ClaveForm(),
          )
        ]),
      ),
    );
  }
}

class ClaveForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final claveForm = Provider.of<ClaveFormProvider>(context);
    final pref = Provider.of<Preferencias>(context);

    return SingleChildScrollView(
      child: Container(
        height: 500,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: pref.backgroundColor,
            borderRadius: BorderRadius.circular(60.0)),
        child: Form(
          key: claveForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                obscureText: false,
                initialValue: claveForm.clave,
                style: TextStyle(
                    fontSize: 40, color: Theme.of(context).primaryColor),
                onChanged: (valor) => claveForm.clave = valor,
                validator: (valor) {
                  return valor!.length < 6
                      ? "Debe tener mas de seis caracteres"
                      : null;
                },
                decoration: InputDecorations.claveInputDecoration(
                    context: context,
                    hintText: "ESCRIBE TU CLAVE",
                    labelText: 'Clave'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: false,
                initialValue: claveForm.pregunta,
                style: TextStyle(
                    fontSize: 30, color: Theme.of(context).primaryColor),
                onChanged: (valor) => claveForm.pregunta = valor,
                validator: (valor) {
                  return valor == '' ? "Escriba una pregunta" : null;
                },
                decoration: InputDecorations.claveInputDecoration(
                  context: context,
                  hintText: "ESCRIBE TU PREGUNTA SECRETA",
                  labelText: 'Pregunta secreta',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  obscureText: false,
                  initialValue: claveForm.respuesta,
                  style: TextStyle(
                      fontSize: 40, color: Theme.of(context).primaryColor),
                  onChanged: (valor) => claveForm.respuesta = valor,
                  validator: (valor) {
                    return valor == "" ? "Ingrese respuesta" : null;
                  },
                  decoration: InputDecorations.claveInputDecoration(
                    context: context,
                    hintText: "ESCRIBE TU RESPUESTA SECRETA",
                    labelText: 'Respuesta secreta',
                  ),
                ),
              ),
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
                            backgroundColor: Color.fromRGBO(249, 75, 11, 1)),
                        onPressed: () {
                          if (claveForm.isValidForm()) {
                            SharedPref().password = claveForm.clave;
                            SharedPref().pregunta = claveForm.pregunta;
                            SharedPref().respuesta = claveForm.respuesta;
                            pref.password = claveForm.clave;
                            pref.pregunta = claveForm.pregunta;
                            pref.respuesta = claveForm.respuesta;
                            // Navigaitor.
                            Navigator.of(context).pop();
                          } else {
                            print('invalidoo');
                          }
                        },
                        child: Text(
                          'Aceptar',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        )),
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //change width and height on your need width = 200 and height = 50
                            //minimumSize: Size(40, 20),
                            backgroundColor: Color.fromRGBO(249, 75, 11, 1)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
