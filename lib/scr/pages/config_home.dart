import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/detalle_menup.dart';
import 'package:piproy/scr/widgets/header_app.dart';

//import 'package:piproy/scr/widgets/header_botones.dart';
import 'package:piproy/scr/widgets/vitalfon_fondo.dart';

class ConfigHomePage extends StatefulWidget {
  @override
  State<ConfigHomePage> createState() => _ConfigHomePageState();
}

class _ConfigHomePageState extends State<ConfigHomePage> {
  @override
  Widget build(BuildContext context) {
    // final lista = apiProvider.listaMenu;
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Editar Pantalla Principals', Text(''), 0.0,
            true, 'ConfigurarHome'),
        body: FutureBuilder(
            future: detalle(context, true),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      FondoVitalfon(),
                      ListView.builder(
                          padding: EdgeInsets.only(bottom: 100),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return snapshot.data[i];
                          }),
                    ],
                  );
                } else {
                  return Container();
                }
              }
            }),
      ),
    );
  }
}
