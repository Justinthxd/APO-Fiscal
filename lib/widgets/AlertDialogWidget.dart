import 'dart:async';
import 'dart:ui';

import 'package:apo_delivery/data/api.dart';
import 'package:apo_delivery/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

alert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      final main = Provider.of<MainProvider>(context);
      final api = API_APO();
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Actualizacion de estado',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '¿Estas seguro que quieres actualizar el estado actual a ACTIVO?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                value: main.getRememberAnswer,
                activeColor: Colors.cyan,
                title: const Text(
                  'Recordar mi respuesta',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                onChanged: (value) {
                  main.setRememberAnswer = !main.getRememberAnswer;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              child: const Text('Si'),
              onPressed: () {
                api.updateDeliveryStatus(main.getToken, main.getEnable ? 1 : 2);
                main.setEnable = !main.getEnable;
                main.getEnable
                    ? ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          content: const Text(
                            'Estás disponible',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 59, 214, 64),
                          actions: [
                            Container(),
                          ],
                        ),
                      )
                    : ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          content: const Text(
                            'Estás fuera de servicio',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: Colors.red[700],
                          actions: [
                            Container(),
                          ],
                        ),
                      );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

alertValidating(BuildContext context) {
  bool button = false;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      final main = Provider.of<MainProvider>(context);
      final api = API_APO();
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Mensaje del sistema.',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Su cuenta no ha sido validada, debe de proceder a validarla. Para hacerlo, debera de contactar el administrador del establecimiento para que le proporcione un codigo de 6 digitos el cual digitara luego de tomarse una foto de su cara.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              onPressed: button
                  ? null
                  : () {
                      button = true;
                      setState(() {});
                      api.getImage().then((value) {
                        main.setImage = value;
                        Navigator.pop(context);
                        alertValidatingCode(context);
                      });
                    },
              child: const Text('OK'),
            ),
            const SizedBox(width: 5),
          ],
        ),
      );
    },
  );
}

alertValidatingCode(BuildContext context) {
  TextEditingController controller = TextEditingController();
  bool validating = false;
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final main = Provider.of<MainProvider>(context);
      final api = API_APO();
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          content: AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: !validating
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Validar Usuario',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 18.5,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          labelText: 'Codigo',
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(height: 50),
                      Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyan,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Validando delivery',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              onPressed: validating
                  ? null
                  : () {
                      Navigator.pop(context);
                    },
              child: const Text('Cancelar'),
            ),
            const SizedBox(width: 0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              onPressed: validating
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      api
                          .validateDelivery(main.getImage, controller.text)
                          .then((value) {
                        if (value['ERROR'] == false) {
                          api.logout(value['DELIVERY']['TOKEN']);
                          validating = false;
                          Navigator.pop(context);
                          alertAccountValidated(context);
                        }
                      });
                      validating = true;
                      setState(() {});
                    },
              child: const Text('Continuar'),
            ),
          ],
        ),
      );
    },
  );
}

alertAccountValidated(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Timer(const Duration(milliseconds: 1700), () {
        Navigator.pop(context);
      });
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(height: 50),
              Center(
                child: Icon(
                  Icons.done_rounded,
                  size: 100,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Cuenta validada',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
