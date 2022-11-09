import 'package:apo_delivery/data/api.dart';
import 'package:apo_delivery/provider/provider.dart';
import 'package:apo_delivery/widgets/AppBarWidget.dart';
import 'package:apo_delivery/widgets/DottedLineWidget.dart';
import 'package:apo_delivery/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final main = Provider.of<MainProvider>(context);
    final api = API_APO();
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(context, scaffoldKey, 'PERFIL', false),
      endDrawer: DrawerWidget(homeBack: true),
      body: Container(
        height: size.height,
        width: size.width,
        margin: const EdgeInsets.all(20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.2),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black38,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  FadeInImage(
                    placeholder: const AssetImage(
                      'assets/images/placeholder.png',
                    ),
                    image: NetworkImage(
                      '${main.getUserInfo['DELIVERY']['PROFILE_IMAGE_URL']}',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: FloatingActionButton(
                      backgroundColor: Colors.cyan.withOpacity(0.9),
                      mini: true,
                      child: const Icon(
                        Icons.photo_camera_rounded,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            line(),
            const Center(
              child: Text(
                'DATOS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ),
            line(),
            const Text(
              'Nombre Completo',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black38,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              '${main.getUserInfo['DELIVERY']['DELIVERY_NAME']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Establecimiento',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black38,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              '${main.getUserInfo['DELIVERY']['BUSINESS']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Delivery ID',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black38,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              '${main.getUserInfo['DELIVERY']['DELIVERY_ID']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            line(),
            const Center(
              child: Text(
                'CONTRASEÑA',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ),
            line(),
            const Text(
              'Contraseña Actual',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black38,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: controller1,
              style: const TextStyle(
                fontSize: 18.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withOpacity(0.1),
                labelText: 'Contraseña Actual',
                labelStyle: const TextStyle(
                  color: Colors.black26,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Nueva Contraseña',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black38,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: controller2,
              style: const TextStyle(
                fontSize: 18.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withOpacity(0.1),
                labelText: 'Nueva Contraseña',
                labelStyle: const TextStyle(
                  color: Colors.black26,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Confirmar Nueva Contraseña',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black38,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: controller3,
              style: const TextStyle(
                fontSize: 18.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withOpacity(0.1),
                labelText: 'Confirmar Nueva Contraseña',
                labelStyle: const TextStyle(
                  color: Colors.black26,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                ),
                child: const Text('CAMBIAR CONTRASEÑA'),
                onPressed: () {
                  api.updatePassword(
                    main.getToken,
                    controller1.text,
                    controller2.text,
                    controller3.text,
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
