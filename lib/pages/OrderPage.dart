import 'dart:async';

import 'package:apo_delivery/data/api.dart';
import 'package:apo_delivery/provider/provider.dart';
import 'package:apo_delivery/widgets/AppBarWidget.dart';
import 'package:apo_delivery/widgets/DottedLineWidget.dart';
import 'package:apo_delivery/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final order = arguments['order'];
    final size = MediaQuery.of(context).size;
    final main = Provider.of<MainProvider>(context);
    final api = API_APO();
    return Scaffold(
      key: scaffoldKey,
      appBar: customAppBar(
          context, scaffoldKey, 'ÓRDEN - No. ${order.orderId}', false),
      endDrawer: DrawerWidget(homeBack: true),
      body: Container(
        height: size.height,
        width: size.width,
        margin: const EdgeInsets.all(15),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Row(
            //   children: [
            //     ElevatedButton(
            //       child: Text('Confirmada'),
            //       onPressed: () {},
            //     ),
            //     ElevatedButton(
            //       child: Text('Transito'),
            //       onPressed: () {},
            //     ),
            //     ElevatedButton(
            //       child: Text('Destino'),
            //       onPressed: () {},
            //     ),
            //     ElevatedButton(
            //       child: Text('Entregada'),
            //       onPressed: () {},
            //     ),
            //   ],
            // ),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('ACTUALIZAR A: TRANSITO'),
                onPressed: () {
                  api.updateOrderDeliveryStatus(
                    main.getToken,
                    order.orderId,
                    -1,
                  );
                },
              ),
            ),
            line(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Orden - No. ${order.orderId}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.cyan,
                  ),
                  child: const Text(
                    'CONFIRMADA',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            line(),
            const Center(
              child: Text(
                'INFORMACION BASICA',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            line(),
            Row(
              children: [
                const Icon(
                  Icons.person_rounded,
                ),
                const SizedBox(width: 10),
                Text(
                  '${order.clientName} ${order.clientLastName}',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: size.width - 70,
                  child: Text(
                    "${order.address}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(
                  Icons.attach_money_rounded,
                ),
                SizedBox(width: 10),
                Text(
                  'Efectivo',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.date_range_rounded,
                ),
                const SizedBox(width: 10),
                Text(
                  '${order.orderDateTime}',
                ),
              ],
            ),
            line(),
            const Center(
              child: Text(
                'ITEMS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            line(),
            for (int i = 0; i < order.items.length; i++)
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Text(
                      '${order.items[i]['QUANTITY']} X ${order.items[i]['MENU_ITEM_NAME']} - ',
                      style: const TextStyle(),
                    ),
                    const Text(
                      'Aperitivo',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'RD\$ ${order.items[i]['UNIT_PRICE'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            line(),
            const Center(
              child: Text(
                'RESUMEN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            line(),
            Row(
              children: [
                const Text(
                  'Subtotal:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  'RD\$ ${order.subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox()
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Impuestos:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  'RD\$ ${order.tax.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox()
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Delivery:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  'RD\$ ${order.delivery.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox()
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Propina:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  'RD\$ ${order.tip.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox()
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  'RD\$ ${order.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox()
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent.withOpacity(1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.white12,
                    ),
                    Text('VER EN EL MAPA'),
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.white12,
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/Map');
                  main.setCurrentOrderAddress = order.address;
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('LLAMAR AL CLIENTE'),
                onPressed: () {
                  launchUrlString('tel://${order.phone}');
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
