import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/providers/provider_pref.dart';
import 'package:device_apps/device_apps.dart';
import 'package:piproy/scr/sharedpreferences/usuario_pref.dart';
import 'package:piproy/scr/widgets/api_menup.dart';
import 'package:piproy/scr/widgets/contactos_card.dart';
import 'package:piproy/scr/widgets/elementos.dart';
import 'package:piproy/scr/widgets/google_busqueda.dart';
import 'package:piproy/scr/widgets/opciones_menu.dart';

Future<List<Widget>> detalle(BuildContext context, bool configurar) async {
  final apiProvider = Provider.of<AplicacionesProvider>(context);

  final pref = Provider.of<Preferencias>(context);

  final listaMenu = apiProvider.listaCategoria;
  List<Widget> listaOpciones = [];
  if (configurar) {
    listaOpciones.add(listaOpciones2(context, 0));
    listaOpciones.add(listaOpciones2(context, 1));
  }
  if (pref.iGoogle && !configurar) {
    final Application? apiGoogle =
        await apiProvider.obtenerApi('com.google.android.googlequicksearchbox');
    if (apiGoogle != null) {
      listaOpciones.add(googleBusqueda(context, apiGoogle));
      listaOpciones.add(
        SizedBox(height: 3),
      );
    }
  }
  if (listaMenu != []) {
    listaOpciones
        .addAll(await listaContactosLlamadas(context, listaMenu, configurar));
    listaOpciones
        .addAll(await listaContactosWhatsapp(context, listaMenu, configurar));
    listaOpciones.addAll(await listaContactos(context, listaMenu, configurar));
    listaOpciones.add(await matrizApis(context, listaMenu, configurar));
    listaOpciones.addAll(listaGrupos(context, listaMenu, configurar));
  }
  if (configurar) {
    listaOpciones.add(Container(
      height: 90,
      //color: Colors.amber,
      child: GestureDetector(
          onTap: () {
            SharedPref().iContactos = !pref.iContactos;
            pref.iContactos = !pref.iContactos;
          },
          child: OpcionOnOff(texto: 'Contactos', onoff: pref.iContactos)),
    ));

    listaOpciones.add(Container(
      height: 90,
      // color: Colors.amber,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
          onTap: () {
            SharedPref().iAplicaciones = !pref.iAplicaciones;
            pref.iAplicaciones = !pref.iAplicaciones;
          },
          child: OpcionOnOff(
            texto: 'Aplicaciones',
            onoff: pref.iAplicaciones,
          )),
    ));
  }
  if (pref.iContactos && !configurar) {
    listaOpciones.add(elementos(
        context,
        Text('Contactos',
            style: TextStyle(
              fontSize: 40.0,
            )),
        60,
        'contactos',
        '',
        configurar));
    listaOpciones.add(SizedBox(height: 3));
  }
  if (pref.iAplicaciones && !configurar) {
    listaOpciones.add(elementos(
        context,
        Text(
          'Aplicaciones',
          style: TextStyle(
              fontSize: 40.0,
              color: pref.paleta == '4' || pref.paleta == '5'
                  ? Theme.of(context).primaryColor
                  : Colors.white),
        ),
        60,
        'apigrupos',
        '',
        configurar));

    listaOpciones.add(SizedBox(
      height: 70,
    ));
  }

  return listaOpciones;
}

Iterable<Widget> listaGrupos(
    BuildContext context, List<String> listaMenu, bool configurar) {
  final List<String> lista = [];
  final List<Widget> listaGrupos = [];
  //********************************************************** */
  //************** grupos de contactos************************* */
  lista.addAll(listaMenu.where((element) => element.contains('MPE')));
  for (var i = 0; i < lista.length; i++) {
    final String titulo = lista[i].substring(3);
    final Widget etiquetaGrupo = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(titulo, style: TextStyle(fontSize: 40.0)),
        Text('Contactos', style: TextStyle(fontSize: 25.0))
      ],
    );
    listaGrupos.add(
        elementos(context, etiquetaGrupo, 60, titulo, lista[i], configurar));
    listaGrupos.add(SizedBox(height: 3));
  }

  //********************************************************** */
  //************** grupos de APPS************************* */
  final List<String> lista2 = [];

  lista2.addAll(listaMenu.where((element) => element.contains('MPF')));
  for (var i = 0; i < lista2.length; i++) {
    final String titulo = lista2[i].substring(3);
    final etiquetaGrupo = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(titulo, style: TextStyle(fontSize: 40.0)),
        Text('Aplicaciones', style: TextStyle(fontSize: 25.0))
      ],
    );
    listaGrupos.add(
        elementos(context, etiquetaGrupo, 60, titulo, lista2[i], configurar));
    listaGrupos.add(SizedBox(height: 3));
  }
  return listaGrupos;
}

Future<Widget> matrizApis(
    BuildContext context, List<String> listaMenu, bool configurar) async {
  //******************************************************* */
  //********************* una Api   MPD            */

  final List<String> lista = [];
  final List<Application> listaApis = [];
  final List<Widget> listaApisWidget = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPD')));

  for (var i = 0; i < lista.length; i++) {
    final Application? api =
        await DeviceApps.getApp(lista[i].substring(3), true);

    if (api != null) {
      listaApis.add(api);
    }
  }
  //**************************************************** */
  /********** ORDENAR ALFABETICAMENTE LAS APPS ***********/

  listaApis.sort((a, b) {
    return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
  });
  //****  GENERO  WIDGET DE LAS APP */
  for (var i = 0; i < listaApis.length; i++) {
    listaApisWidget.add(elementoApi2(context, listaApis[i], configurar));
  }

  if (listaApisWidget.isNotEmpty) {
    final altura = listaApisWidget.length > 2
        ? 200.0 * (listaApisWidget.length / 2).round()
        : 200.0;
    return Container(
        height: altura,
        child: GridView.builder(
            itemCount: listaApisWidget.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // childAspectRatio: MediaQuery.of(context).size.width /
              //     (MediaQuery.of(context).size.height / 2),
            ),
            itemBuilder: (context, index) {
              return Container(child: listaApisWidget[index]);
            }));
  } else {
    return Container();
  }
}

Future<List<Widget>> listaContactosLlamadas(
    BuildContext context, List<String> listaMenu, bool configurar) async {
  //*********************************************************** */
  /****************** un contacto MPA***************************/
  //*********************************************************** */
  final contactosProvider =
      Provider.of<ContactosProvider>(context, listen: false);
  final List<Widget> listaWidgetContactos = [];
  final List<String> lista = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPA')));
  for (var i = 0; i < lista.length; i++) {
    String nombre = lista[i].substring(3);
    final ContactoDatos contacto =
        await contactosProvider.obtenerContacto(nombre);
    listaWidgetContactos
        .add(TarjetaContacto2(context, contacto, false, configurar, 'MPA'));
    listaWidgetContactos.add(SizedBox(height: 3));
  }

  return listaWidgetContactos;
}

Future<List<Widget>> listaContactos(
    BuildContext context, List<String> listaMenu, bool configurar) async {
  //*********************************************************** */
  /****************** MPC CONTACTOS CON TODAS LAS OPCIONES  *******/
  //*********************************************************** */
  final contactosProvider =
      Provider.of<ContactosProvider>(context, listen: false);
  final List<Widget> listaWidgetContactos = [];
  final List<String> lista = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPC')));
  for (var i = 0; i < lista.length; i++) {
    String nombre = lista[i].substring(3);
    final ContactoDatos contacto =
        await contactosProvider.obtenerContacto(nombre);
    // ignore: unnecessary_null_comparison
    listaWidgetContactos
        .add(TarjetaContacto2(context, contacto, false, configurar, 'MPC'));
    listaWidgetContactos.add(SizedBox(height: 3));
  }

  return listaWidgetContactos;
}

Future<List<Widget>> listaContactosWhatsapp(
    BuildContext context, List<String> listaMenu, bool configurar) async {
  //*********************************************************** */
  /****************** un contacto WHATSAPP MPB***************************/
  //*********************************************************** */
  final contactosProvider =
      Provider.of<ContactosProvider>(context, listen: false);
  final List<Widget> listaWidgetContactos = [];
  final List<String> lista = [];
  lista.addAll(listaMenu.where((element) => element.contains('MPB')));
  for (var i = 0; i < lista.length; i++) {
    String nombre = lista[i].substring(3);
    final ContactoDatos contacto =
        await contactosProvider.obtenerContacto(nombre);

    listaWidgetContactos
        .add(TarjetaContacto2(context, contacto, false, configurar, 'MPB'));
    listaWidgetContactos.add(SizedBox(height: 3));
  }

  return listaWidgetContactos;
}
