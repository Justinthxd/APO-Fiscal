import 'dart:convert';
import 'dart:io';

import 'package:apo_delivery/data/Order.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class API_APO {
  final url = 'https://apo.do/apodelivery/api.cfc?method=';

  Future login(String business, String username, String password) async {
    final body = {
      "push_id": "462",
      "finger_print": "3.2.1",
      "application_version": "3.2.1",
      "api_version": "0.01",
      "coordinates": "-1,-1",
    };

    final data = {
      "business": 'demo.apo.do',
      "username": 'Prueba-Justin',
      "password": 'admin1234',
    };

    body['data'] = json.encode(data);

    jsonEncode(body);

    final res = await http.post(
      Uri.parse('${url}login'),
      body: body,
    );

    print(res.body);

    return jsonDecode(res.body);
  }

  Future logout(String token) async {
    final body = {
      "delivery_id": "462",
      "business_id": "409",
      "token": token,
      "push_id": "462",
      "finger_print": "3.2.1",
      "aplication_version": "3.2.1",
      "api_version": "0.01",
      "coordinates": "-1,-1",
      "delivery_point_id": "6",
    };

    jsonEncode(body);

    final res = await http.post(
      Uri.parse('${url}logout'),
      body: body,
    );

    print(res.body);

    return jsonDecode(res.body);
  }

  Future updatePassword(String token, String currentPassword,
      String newPassword, String newPasswordConfirmation) async {
    final body = {
      "delivery_id": "462",
      "business_id": "409",
      "delivery_point_id": "6",
      "token": token,
      "push_id": "3.2.1",
      "finger_print": "3.2.1",
      "aplication_version": "3.2.1",
      "api_version": "0.01",
      "coordinates": "-1,-1",
    };

    final data = {
      "current_password": currentPassword,
      "new_password": newPassword,
      "new_password_confirmation": newPasswordConfirmation,
    };

    body['data'] = json.encode(data);

    jsonEncode(body);

    final res = await http.post(
      Uri.parse('${url}updatePassword'),
      body: body,
    );

    print(res.body);

    return jsonDecode(res.body);
  }

  Future validateDelivery(File image, String code) async {
    final body = {
      "delivery_id": "462",
      "business_id": "false",
      "token": "3.2.1",
      "push_id": "3.2.1",
      "finger_print": "3.2.1",
      "aplication_version": "3.2.1",
      "api_version": "0.01",
      "coordinates": "-1,-1",
    };

    final data = {
      "validation_image":
          'data:image/png;base64,${base64.encode(image.readAsBytesSync())}',
      "validation_code": code,
      "business": "demo.apo.do",
      "username": "Prueba-Justin",
    };

    body['data'] = json.encode(data);

    jsonEncode(body);

    final res = await http.post(
      Uri.parse('${url}validateDelivery'),
      body: body,
    );

    print(res.body);

    return jsonDecode(res.body);
  }

  Future updateDeliveryStatus(String token, int status) async {
    final body = {
      "delivery_id": "462",
      "business_id": "409",
      "token": token,
      "push_id": "3.2.1",
      "finger_print": "3.2.1",
      "aplication_version": "3.2.1",
      "api_version": "0.01",
      "coordinates": "-1,-1",
    };

    final data = {
      "new_status": status,
      "delivery_point_id": 6,
    };

    body['data'] = json.encode(data);

    jsonEncode(body);

    final res = await http.post(
      Uri.parse('${url}updateDeliveryStatus'),
      body: body,
    );

    // print(res.body);

    return jsonDecode(res.body);
  }

  Future updateOrderDeliveryStatus(
      String token, int orderId, int status) async {
    final body = {
      "delivery_id": "462",
      "business_id": "409",
      "delivery_point_id": "6",
      "token": token,
      "push_id": "3.2.1",
      "finger_print": "3.2.1",
      "aplication_version": "3.2.1",
      "api_version": "0.01",
      "coordinates": "-1,-1",
    };

    final data = {
      "order_id": orderId,
      "delivery_status": status,
    };

    body['data'] = json.encode(data);

    jsonEncode(body);

    final res = await http.post(
      Uri.parse('${url}updateOrderDeliveryStatus'),
      body: body,
    );

    print(res.body);

    return jsonDecode(res.body);
  }

  Future getDeliveryOrdersPendings(String token) async {
    List<Order> orders = [];

    final body = {
      "delivery_id": "462",
      "business_id": "409",
      "token": token,
      "push_id": "3.2.1",
      "finger_print": "3.2.1",
      "aplication_version": "3.2.1",
      "api_version": "0.01",
      "coordinates": "-1,-1",
    };

    jsonEncode(body);

    try {
      final res = await http.post(
        Uri.parse('${url}getDeliveryOrders'),
        body: body,
      );
      final data = jsonDecode(res.body);

      if (data['ORDERS'] != null) {
        data['ORDERS']['PENDINGS'].forEach((key, value) {
          Order order = Order();
          order.total = value['TOTAL'];
          order.clientLastName = value['CLIENT_LAST_NAME'];
          order.clientName = value['CLIENT_NAME'];
          order.phone = value['PHONE'];
          order.longitude = value['LONGITUDE'];
          order.tax = value['TAX'];
          order.items = value['ITEMS'];
          order.oldOrder = value['OLD_ORDER'];
          order.municipalityName = value['MUNICIPALITY_NAME'];
          order.delivery = value['DELIVERY'];
          order.paymentTypeName = value['PAYMENT_TYPE_NAME'];
          order.notes = value['NOTES'];
          order.status = value['STATUS'];
          order.sectorName = value['SECTOR_NAME'];
          order.subtotal = value['SUBTOTAL'];
          order.orderId = value['ORDER_ID'];
          order.orderDateTime = value['ORDER_DATETIME'];
          order.address = value['ADDRESS'];
          order.tip = value['TIP'];
          order.binnacle = value['BINNACLE'];
          order.latitude = value['LATITUDE'];
          order.deliveryStatus = value['DELIVERY_STATUS'];
          orders.add(order);
        });
      }
    } catch (e) {}

    return orders;
  }

  Future getDeliveryOrdersDelivered(String token) async {
    List<Order> orders = [];

    final body = {
      "delivery_id": "462",
      "business_id": "409",
      "token": token,
      "push_id": "3.2.1",
      "finger_print": "3.2.1",
      "aplication_version": "3.2.1",
      "api_version": "0.01",
      "coordinates": "-1,-1",
    };

    jsonEncode(body);

    final res = await http.post(
      Uri.parse('${url}getDeliveryOrders'),
      body: body,
    );

    final data = jsonDecode(res.body);

    if (data['ORDERS'] != null) {
      data['ORDERS']['DELIVERED'].forEach((key, value) {
        Order order = Order();
        order.total = value['TOTAL'];
        order.clientLastName = value['CLIENT_LAST_NAME'];
        order.clientName = value['CLIENT_NAME'];
        order.phone = value['PHONE'];
        order.longitude = value['LONGITUDE'];
        order.tax = value['TAX'];
        order.oldOrder = value['OLD_ORDER'];
        order.municipalityName = value['MUNICIPALITY_NAME'];
        order.delivery = value['DELIVERY'];
        order.paymentTypeName = value['PAYMENT_TYPE_NAME'];
        order.notes = value['NOTES'];
        order.status = value['STATUS'];
        order.sectorName = value['SECTOR_NAME'];
        order.subtotal = value['SUBTOTAL'];
        order.orderId = value['ORDER_ID'];
        order.orderDateTime = value['ORDER_DATETIME'];
        order.address = value['ADDRESS'];
        order.tip = value['TIP'];
        order.binnacle = value['BINNACLE'];
        order.latitude = value['LATITUDE'];
        order.deliveryStatus = value['DELIVERY_STATUS'];
        orders.add(order);
      });
    }

    return orders;
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    File file = File(image!.path);

    final img.Image? capturedImage =
        img.decodeImage(await File(file.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    await File(file.path).writeAsBytes(img.encodeJpg(orientedImage));

    return file;
  }
}
