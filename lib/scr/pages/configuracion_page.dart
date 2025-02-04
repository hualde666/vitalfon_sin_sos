import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:piproy/scr/pages/api_grupos.dart';
import 'package:piproy/scr/pages/ayuda_nueva.dart';
import 'package:piproy/scr/pages/config_home.dart';
import 'package:piproy/scr/pages/conta_grupos.dart';
import 'package:piproy/scr/pages/desbloqueo.dart';

import 'package:piproy/scr/pages/inicialza_vitalfon.dart';

//import 'package:piproy/scr/pages/opciones_page.dart';
import 'package:piproy/scr/pages/paletta_colores.dart';
import 'package:piproy/scr/pages/password.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';

import 'package:piproy/scr/widgets/header_app.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../providers/provider_pref.dart';
import '../sharedpreferences/usuario_pref.dart';

class ConfiguracionPage extends StatelessWidget {
  final apiProvider = new AplicacionesProvider();

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    final colorBloqueo = pref.paleta != '2' && pref.paleta != '5'
        ? Colors.white38
        : Colors.black26;
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(
            context, 'Configuración', Text(''), 0.0, true, 'Configurar'),

        // title: Text('Configuración'),

        body: ListView(children: [
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),

          ListTile(
              leading: Icon(
                Icons.help,
                size: 40.0,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('Ayuda',
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).primaryColor,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AyudaNuevaPage()));
              }),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),

          ItemConfig(
            icon: Icons.groups,
            texto: 'Establecer contactos en la pantalla principal',
            onPress: ContactsGruposPage(configurar: true),
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ItemConfig(
            icon: Icons.app_registration,
            texto: 'Establecer aplicaciones en la pantalla principal',
            onPress: ApiGruposPage(configurar: true),
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ItemConfig(
            icon: Icons.engineering,
            texto:
                'Habilitar o deshabilitar elementos en la pantalla principal',
            onPress: ConfigHomePage(),
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          // ItemConfig(
          //   icon: Icons.engineering,
          //   texto:
          //       'Habilitar o deshabilitar elementos en la pantalla principal',
          //   onPress: OpcionesPage(),
          // ),
          // Divider(
          //   height: 10,
          //   color: Theme.of(context).primaryColor,
          // ),
          ItemConfig(
            icon: Icons.palette,
            texto: 'Color de vitalfon',
            onPress: PaletaPage(),
          ),

          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
            leading: Icon(
              Icons.key,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Clave bloqueo',
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                )),
            onTap: () {
              if (pref.password != "") {
                // pedir password.. lo tiene?
                // mostra en password los datos actuales para modificar

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Desbloqueo(
                              desbloqueo: false,
                            )));
                //
                // no lo tiene ? hacer pregunta de seguridad
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Password()));
              }
            },
          ),

          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
            leading: Icon(
              pref.modoConfig ? Icons.lock_open : Icons.lock_outline,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
                pref.modoConfig
                    ? 'Bloquear Configuración'
                    : 'Desbloquear Configuración',
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                )),
            onTap: () {
              final pref = Provider.of<Preferencias>(context, listen: false);

              /// preguntar si ten con password
              if (pref.password != "" && !pref.modoConfig) {
                // final claveForm = Provider.of<ClaveFormProvider>(context);
                // pedir password
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Desbloqueo(
                              desbloqueo: true,
                            )));

                // pedirPassword(context,claveForm, true);
              } else {
                /// si no hay pasword
                pref.modoConfig = !pref.modoConfig;
                SharedPref().modoConfig = pref.modoConfig;
              }
            },
          ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
              leading: Icon(
                Icons.email,
                size: 40.0,
                color: pref.modoConfig
                    ? Theme.of(context).primaryColor
                    : colorBloqueo,
              ),
              title: Text('Contactenos',
                  style: TextStyle(
                    fontSize: 25,
                    color: pref.modoConfig
                        ? Theme.of(context).primaryColor
                        : colorBloqueo,
                  )),
              onTap: () {
                if (pref.modoConfig) {
                  correoVitalfon();
                }
              }),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
              leading: Icon(
                Icons.web_sharp,
                size: 40.0,
                color: pref.modoConfig
                    ? Theme.of(context).primaryColor
                    : colorBloqueo,
              ),
              title: Text('www.vitalfon.com',
                  style: TextStyle(
                    fontSize: 25,
                    color: pref.modoConfig
                        ? Theme.of(context).primaryColor
                        : colorBloqueo,
                  )),
              onTap: () async {
                if (pref.modoConfig) {
                  Uri url = Uri.parse('https://www.vitalfon.com');
                  await launchUrl(url);
                }
                // if (await canLaunchUrlString('https://www.com.proy.vitalfon')) {
                //   await launchUrlString('https://www.com.proy.vitalfon');
                // }
              } // paginaWep,
              ),
          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ItemConfig(
              icon: Icons.delete_forever_outlined,
              texto: 'Inicializar vitalfon',
              onPress: Inicializar()),

          Divider(
            height: 10,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
              leading: Icon(
                Icons.logout,
                size: 40.0,
                color: pref.modoConfig
                    ? Theme.of(context).primaryColor
                    : colorBloqueo,
              ),
              title: Text('Salir de vitalfon',
                  style: TextStyle(
                    fontSize: 25,
                    color: pref.modoConfig
                        ? Theme.of(context).primaryColor
                        : colorBloqueo,
                  )),
              onTap: () {
                if (pref.modoConfig) {
                  salida(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ElejirLauncher()));
                }
              }),
        ]),
      ),
    );
  }

  void correoVitalfon() async {
    final String toEmail = 'atencion_usuarios@com.proy.vitalfon';
    final String asunto = 'Contactando a vitalfon';
    final String contenido = ' ';
    //'Gracias por contactarnos. Nos gustaría leer tus comentarios:   ';

    final url = 'mailto:$toEmail?subject=$asunto&body=$contenido';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
    //final resp = await launchUrlString(url);
    //print(resp);
  }

  void paginaWep() async {
    if (await canLaunchUrlString('https://www.com.proy.vitalfon')) {
      await launchUrlString('https://www.com.proy.vitalfon');
    }
  }
}

class ItemConfig extends StatelessWidget {
  final IconData icon;
  final String texto;
  final Widget onPress;
  const ItemConfig(
      {required this.icon, required this.texto, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    final colorBloqueo = pref.paleta != '2' && pref.paleta != '5'
        ? Colors.white38
        : Colors.black26;
    return ListTile(
      leading: Icon(
        icon,
        size: 40.0,
        color: pref.modoConfig ? Theme.of(context).primaryColor : colorBloqueo,
      ),
      title: Text(texto,
          style: TextStyle(
            fontSize: 25,
            color:
                pref.modoConfig ? Theme.of(context).primaryColor : colorBloqueo,
          )),
      onTap: () {
        if (pref.modoConfig) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => onPress));
        }
      },
    );
  }
}

salida(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            //backgroundColor: Colors.red[900],
            title: Container(
              width: 100,
              height: 100,
              child: Center(
                child: Text('¿ Desea salir de vitalfon ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Colors.red)),
              ),
            ),

            //shape: CircleBorder(),
            elevation: 14.0,
            //actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              ElevatedButton(
                onPressed: () {
                  // se sale con flecha menu inferior
                  SystemNavigator.pop();

                  exit(0);
                  //Navigator.pop(context);
                },
                child: Text('Si',
                    style: TextStyle(fontSize: 25.0, color: Colors.white)),
              ),
              ElevatedButton(
                  autofocus: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No',
                      style: TextStyle(fontSize: 25.0, color: Colors.white)))
            ],
          ));
}

Future pedirPassword(BuildContext context, bool desbloqueo) {
  final pref = Provider.of<Preferencias>(context, listen: false);

  ///final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // validoPassword() {
  //   final FormState? form = _formKey.currentState;

  //   if (form!.validate()) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            //backgroundColor: Colors.red[900],
            title: Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                child: TextFormField(
                  //key: _formKey, //claveForm.formKey,
                  // textCapitalization: TextCapitalization.words,
                  obscureText: true,
                  style: TextStyle(
                      fontSize: 40, color: Theme.of(context).primaryColor),
                  //    controller: _tipoControle,
                  validator: (valor) {
                    return valor!.trim() != pref.password
                        ? "Clave incorrecta"
                        : null;
                  },
                  decoration: InputDecoration(
                    hintText: "INGRESA LA CLAVE",
                    labelText: 'Clave',
                  ),
                ),
              ),
            ),

            //shape: CircleBorder(),
            elevation: 14.0,
            //actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              ElevatedButton(
                onPressed: () {
                  // se sale con flecha menu inferior
                  // if (claveForm.isValidForm()) {
                  //   if (desbloqueo) {
                  //     pref.modoConfig = !pref.modoConfig;
                  //     Navigator.pop(context);
                  //   }
                  //  }
                },
                child: Text('Aceptar',
                    style: TextStyle(fontSize: 25.0, color: Colors.white)),
              ),
              ElevatedButton(
                  autofocus: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar',
                      style: TextStyle(fontSize: 25.0, color: Colors.white)))
            ],
          ));
}
