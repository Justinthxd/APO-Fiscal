import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double opacity = 1;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 1000), () {
      opacity = 0;
      setState(() {});
    });
    Timer(const Duration(seconds: 3), () {
      opacity = 1;
      setState(() {});
    });
    Timer(const Duration(milliseconds: 3700), () {
      Navigator.restorablePushNamed(context, '/Login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Column(
              children: [
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
                const Spacer(),
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
                const SizedBox(height: 50),
              ],
            ),
            IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                color: Colors.white.withOpacity(opacity),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
