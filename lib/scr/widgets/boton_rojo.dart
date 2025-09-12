import 'package:flutter/material.dart';
import 'package:installed_apps/index.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';

import 'package:piproy/scr/providers/estado_celular.dart';

import 'package:piproy/scr/widgets/boton_rojo_dibujo.dart';
import 'package:provider/provider.dart';

Widget botonRojoHeader(BuildContext context, bool activo) {
  final celProvider = Provider.of<EstadoProvider>(context);
  final activoDatos = celProvider.conexionDatos;
  final apiProvider = Provider.of<AplicacionesProvider>(context);

  return GestureDetector(
      onTap: () {
        if (activoDatos) {
          if (activo) {
            // TODO ojo abre vitalfonSOS

            InstalledApps.startApp('com.vitalfon.SOS');
            // apiProvider.vitalfonSOS?.openApp();
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => BotonRojoPage()));
          }
        }
      },
      child: activoDatos
          ? BotonRojo()
          : Container(
              height: 100,
              width: 100,
            ));
}
