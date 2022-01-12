import 'package:flutter/material.dart';

class ImporExpor extends StatefulWidget {
  const ImporExpor({Key? key}) : super(key: key);

  static String id = 'impor_expor';

  @override
  _ImporExporState createState() => _ImporExporState();
}

class _ImporExporState extends State<ImporExpor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Importar && Exportar'),
      ),
    );
  }
}
