import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/provider_pref.dart';
import 'package:piproy/scr/sharedpreferences/usuario_pref.dart';
import 'package:provider/provider.dart';

List<Widget> listaOpciones2(BuildContext context) {
  final pref = Provider.of<Preferencias>(context);

  double padding = (MediaQuery.of(context).size.width - 280) / 2 > 0
      ? (MediaQuery.of(context).size.width - 320) / 2
      : 0;

  List<Widget> opciones = [
    // Divider(
    //   height: 2,
    //   color: Theme.of(context).primaryColor,
    // ),
    // SizedBox(
    //   height: 5,
    // )
    // **************** menu horizontal 0**************
    Container(
      height: 105,
      padding: EdgeInsets.symmetric(horizontal: padding),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () {
              SharedPref().iTelefono = !pref.iTelefono;
              pref.iTelefono = !pref.iTelefono;
            },
            child: IconOpcion(
                iconop: Icons.call,
                icontext: 'telefono',
                activo: pref.iTelefono),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {
                SharedPref().iLinterna = !pref.iLinterna;
                pref.iLinterna = !pref.iLinterna;
              },
              child: IconOpcion(
                  iconop: Icons.filter_alt,
                  icontext: 'linterna',
                  activo: pref.iLinterna)),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {
                SharedPref().iMensaje = !pref.iMensaje;
                pref.iMensaje = !pref.iMensaje;
              },
              child: IconOpcion(
                  iconop: Icons.chat,
                  icontext: 'mensaje',
                  activo: pref.iMensaje)),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {
                SharedPref().iReloj = !pref.iReloj;
                pref.iReloj = !pref.iReloj;
              },
              child: IconOpcion(
                  iconop: Icons.access_alarm,
                  icontext: 'reloj',
                  activo: pref.iReloj)),
        ],
      ),
    ),

    // **************** Google 1 **************
    Container(
      height: 60,
      child: GestureDetector(
        onTap: () {
          SharedPref().iGoogle = !SharedPref().iGoogle;
          pref.iGoogle = !pref.iGoogle;
        },
        child: GoogleOpcion(),
      ),
    ),
  ];
  return opciones;
}

class IconOpcion extends StatelessWidget {
  const IconOpcion(
      {required this.iconop, required this.icontext, required this.activo});

  final bool activo;
  final IconData iconop;
  final String icontext;

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    final colorIcon =
        pref.paleta == "2" ? Colors.white : Theme.of(context).primaryColor;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
                color: activo
                    ? pref.backgroundColor
                    : pref.backgroundColor.withAlpha(120),
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                    color: activo
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withAlpha(120))),
            child: Icon(iconop,
                size: 40.0, color: activo ? colorIcon : colorIcon.withAlpha(120)
                // color: activo ? color : color.withAlpha(120),
                ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(icontext,
                style: TextStyle(
                    color: activo
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withAlpha(120),
                    fontSize: 20) //,Colors.white60),
                ),
          ),
        ],
      ),
    );
  }
}

class GoogleOpcion extends StatelessWidget {
  // final BuildContext context;

  // const GoogleOpcion({super.key, required this.context});
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      decoration: BoxDecoration(
          color: SharedPref().iGoogle
              ? Colors.white
              : Theme.of(context).primaryColor.withAlpha(50),
          borderRadius: BorderRadius.circular(60.0),
          border: Border.all(
              color: Colors.black26, // Theme.of(context).primaryColor,
              width: 0.5)),
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 20,
          ),
          Container(
            child: Center(
                child: pref.iGoogle
                    ? Image(
                        image: AssetImage('assets/google.png'),
                        fit: BoxFit.fill)
                    : Text(
                        'Google',
                        style: TextStyle(
                            fontSize: 35,
                            color:
                                Theme.of(context).primaryColor.withAlpha(50)),
                      )),
            height: 40,
            width: 195,
            //color: Colors.red),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.search,
            color: Colors.blue,
            size: 35,
          ),
        ]),
      ),
    );
  }
}

class OpcionOnOff extends StatelessWidget {
  const OpcionOnOff({
    super.key,
    required this.texto,
    required this.onoff,
  });

  final String texto;
  final onoff;
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: onoff
              ? pref.backgroundColor
              : pref.backgroundColor.withAlpha(120),
          // color:
          //     /** es un contacto o grupo de contacto */
          //     Colors.green,
          borderRadius: BorderRadius.circular(60.0),
          border: Border.all(
            color: onoff
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withAlpha(120),
          )),
      child: Center(
        child: Text(
          texto,
          style: TextStyle(
            // color: onoff
            //     ? Theme.of(context).primaryColor
            //     : Theme.of(context).primaryColor.withOpacity(0.4),
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
