// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Center(
        child: Text('Loading...'),
      ),
    );
  }
}
