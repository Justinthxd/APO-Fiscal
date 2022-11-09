import 'dart:async';

import 'package:apo_delivery/data/api.dart';
import 'package:apo_delivery/data/sqlite.dart';
import 'package:apo_delivery/provider/provider.dart';
import 'package:apo_delivery/widgets/AlertDialogWidget.dart';
import 'package:apo_delivery/widgets/AppBarWidget.dart';
import 'package:apo_delivery/widgets/DrawerWidget.dart';
import 'package:apo_delivery/widgets/OrderItemWidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ref = FirebaseDatabase.instance.ref();

  Timer timer = Timer(const Duration(seconds: 0), () {});

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    final size = MediaQuery.of(context).size;
    final main = Provider.of<MainProvider>(context);
    final api = API_APO();
    final sqflite = SQLite.instance;
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(context, scaffoldKey, 'ÓRDENES'),
      endDrawer: DrawerWidget(homeBack: false),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(10),
        child: FloatingActionButton(
          backgroundColor: main.getEnable
              ? const Color.fromARGB(255, 79, 221, 84)
              : Colors.red[800],
          child: Icon(
            main.getEnable
                ? Icons.delivery_dining_rounded
                : Icons.delivery_dining_outlined,
            size: 35,
          ),
          onPressed: () {
            // ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            // alert(context).then((value) {
            //   setState(() {});
            // });
            // Timer(const Duration(seconds: 2), () {
            //   ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            // });
            // setState(() {});
          },
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'ÓRDENES PENDIENTES',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Divider(
                height: 0,
                color: Colors.black12,
                thickness: 2,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: api.getDeliveryOrdersPendings(main.getToken),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_awesome_mosaic_rounded,
                              size: 45,
                              color: Colors.cyan.withOpacity(0.1),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'No tiene órdenes',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.07),
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          for (int i = 0; i < snapshot.data.length; i++)
                            OrderItem(
                              order: snapshot.data[i],
                            ),
                        ],
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyan,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'ÓRDENES ENTREGADAS ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Divider(
                height: 0,
                color: Colors.black12,
                thickness: 2,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: api.getDeliveryOrdersDelivered(main.getToken),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_awesome_mosaic_rounded,
                              size: 45,
                              color: Colors.cyan.withOpacity(0.1),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'No tiene órdenes',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.07),
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          for (int i = 0; i < snapshot.data.length; i++)
                            OrderItem(
                              order: snapshot.data[i],
                            ),
                        ],
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyan,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
