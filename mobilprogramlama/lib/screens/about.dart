import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkında'),
      ),
      body: Center(
        child: Text(
          'Bu uygulama Flutter kullanılarak geliştirilmiştir.',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
