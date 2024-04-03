import 'package:flutter/material.dart';

AppBar customAppBar(Function() callback) {
  return AppBar(
    title: const Text('TNP.Connect()'),
    actions: [
      IconButton(
        onPressed: callback,
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}
