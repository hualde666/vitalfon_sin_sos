import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/widgets/boton_amarillo.dart';
import 'package:piproy/scr/widgets/boton_rojo.dart';
import 'package:piproy/scr/widgets/boton_verde.dart';

Widget tresBotonesHeader(
  BuildContext context,
  bool rojo,
  String pagina,
) {
  final apiProvider = Provider.of<AplicacionesProvider>(context);
  return Container(
    padding: EdgeInsets.only(top: 5, left: 5, right: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        botonHomeHeader(context, pagina),
        // Container(
        //   width: 100,
        // ),
        (apiProvider.vitalfonSOS != null)
            ? botonRojoHeader(context, true)
            : Container(
                width: 100,
              ),

        botonBackHeader(context, pagina)
      ], // Ho
    ),
  );
}
