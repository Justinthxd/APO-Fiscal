import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, dynamic scaffoldKey, String title,
    [bool? backButton]) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 22,
      ),
    ),
    leadingWidth: backButton ?? true ? 90 : null,
    leading: backButton ?? true
        ? Container(
            margin: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          )
        : GestureDetector(
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
              color: Colors.cyan,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
    actions: [
      GestureDetector(
        child: const Icon(
          Icons.menu_rounded,
          size: 30,
          color: Colors.cyan,
        ),
        onTap: () {
          scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      const SizedBox(
        width: 20,
      ),
    ],
  );
}
