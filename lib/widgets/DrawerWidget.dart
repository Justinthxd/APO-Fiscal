import 'package:apo_delivery/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({super.key, required this.homeBack});

  bool homeBack;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<String> names = [
    'Inicio',
    'Mi Perfil',
    'Mapa',
  ];

  List<IconData> icons = [
    Icons.home_rounded,
    Icons.person_rounded,
    Icons.location_on_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final main = Provider.of<MainProvider>(context);
    final api = API_APO();
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleAvatar(
              maxRadius: 40,
              backgroundColor: Colors.black54,
              backgroundImage: NetworkImage(
                '${main.getUserInfo['DELIVERY']['PROFILE_IMAGE_URL']}',
              ),
            ),
          ),
          ListTile(
            title: Container(
              margin: const EdgeInsets.only(right: 40),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '${main.getUserInfo['DELIVERY']['DELIVERY_NAME']}',
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            subtitle: Text(
              '${main.getUserInfo['DELIVERY']['BUSINESS']}',
              style: TextStyle(
                color: Colors.cyan[600],
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: const Divider(
              thickness: 2,
            ),
          ),
          ListTile(
            title: Text(
              names[0],
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 18,
              ),
            ),
            leading: Icon(
              icons[0],
              size: 27,
              color: Colors.black.withOpacity(0.7),
            ),
            onTap: () {
              if (widget.homeBack) {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
          ),
          ListTile(
            title: Text(
              names[1],
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 18,
              ),
            ),
            leading: Icon(
              icons[1],
              size: 27,
              color: Colors.black.withOpacity(0.7),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/Account');
            },
          ),
          ListTile(
            title: Text(
              names[2],
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 18,
              ),
            ),
            leading: Icon(
              icons[2],
              size: 27,
              color: Colors.black.withOpacity(0.7),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/Map');
              main.setCurrentOrderAddress = '';
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: const Divider(
              thickness: 2,
            ),
          ),
          ListTile(
            title: Text(
              'Cerrar sesión',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 18,
              ),
            ),
            leading: Icon(
              Icons.logout_rounded,
              size: 27,
              color: Colors.black.withOpacity(0.7),
            ),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pop();
              api.logout(main.getToken);
            },
          ),
          const Spacer(),
          const Center(
            child: Text(
              'Desarrollado por ODESPRA SRL | Versión 1.0',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
