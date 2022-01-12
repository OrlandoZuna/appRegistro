import 'package:flutter/material.dart';

class VerRegistroPage extends StatefulWidget {
  const VerRegistroPage({Key? key}) : super(key: key);

  static String id ='ver_registro';

  @override
  _VerRegistroPageState createState() => _VerRegistroPageState();
}

class _VerRegistroPageState extends State<VerRegistroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Ver Rgistros')
      ),
    );
  }
}
