import 'dart:async';

import 'package:apo_delivery/data/api.dart';
import 'package:apo_delivery/widgets/AlertDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double opacity = 1;

  final LocalAuthentication auth = LocalAuthentication();
  String authorized = 'Not Authorized';
  bool isAuthenticating = false;

  TextEditingController textField1 = TextEditingController();
  TextEditingController textField2 = TextEditingController();
  TextEditingController textField3 = TextEditingController();

  bool obscureText = true;

  Future authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        isAuthenticating = true;
        authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint or face to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        isAuthenticating = false;
        authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      setState(() {
        isAuthenticating = false;
        authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    return authenticated ? true : false;
  }

  Future cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => isAuthenticating = false);
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      opacity = 0;
      setState(() {});
    });
    super.initState();
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
    final api = API_APO();
    final main = Provider.of<MainProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: size.height * 0.1),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: textField1,
                      style: const TextStyle(
                        fontSize: 18.5,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.1),
                        labelText: 'Establacimiento',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear_rounded,
                            size: 23,
                          ),
                          onPressed: () {
                            textField1.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: textField2,
                      style: const TextStyle(
                        fontSize: 18.5,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.1),
                        labelText: 'Usuario',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear_rounded,
                            size: 23,
                          ),
                          onPressed: () {
                            textField2.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: textField3,
                      obscureText: obscureText,
                      style: const TextStyle(
                        fontSize: 18.5,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.1),
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye_rounded,
                            size: 23,
                          ),
                          onPressed: () {
                            obscureText = !obscureText;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                      ),
                      child: const Text('INICIAR SESIÓN'),
                      onPressed: () {
                        // FocusScope.of(context).unfocus();
                        // authenticateWithBiometrics().then((value) {
                        //   print(value);
                        // });
                        api
                            .login(
                          textField1.text,
                          textField2.text,
                          textField3.text,
                        )
                            .then((value) {
                          if (!value['ERROR']) {
                            main.setToken = value['DELIVERY']['TOKEN'];
                            Navigator.pushReplacementNamed(context, '/');
                          }
                          try {
                            if (value['HAS_TO_VALIDATE']) {
                              alertValidating(context);
                            }
                          } catch (e) {}

                          // Login - Information - - - - - - //

                          main.setUserInfo = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.16),
                  const Center(
                    child: Text(
                      'Desarrollado por ODESPRA SRL | Versión 1.0',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                color: Colors.white.withOpacity(opacity),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
