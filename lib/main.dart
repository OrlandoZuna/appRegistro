import 'dart:typed_data';

import 'package:appp/pages/cuaderno_virtual.dart';
import 'package:appp/pages/impor_expor.dart';
import 'package:appp/pages/login2_page.dart';
import 'package:appp/pages/menu_page.dart';
import 'package:appp/pages/mac_page.dart';
import 'package:appp/pages/registro_asistencia.dart';
import 'package:appp/pages/ver_registro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:device_info/device_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,

        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: Login2Page.id,
      routes: {
        MyHomePage.id: (context)=> MyHomePage(title:''),
        HomePage.id: (context)=> HomePage(),
        MenuPage.id: (context)=> MenuPage(),
        Login2Page.id: (context) => Login2Page(),
        MenuPage.id: (context)=> MenuPage(),
        MyHomePage2.id: (context)=> MyHomePage(title: ''),
        RegistroPage.id: (context)=> RegistroPage(),
        VerRegistroPage.id: (context)=> VerRegistroPage(),
        ImporExpor.id: (context) => ImporExpor(),
      },
      home: const MyHomePage(title: 'DIRECCION MAC ADDRESS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  static String id = 'main';
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _mac = "unknow";
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  static const Channel = MethodChannel('com.example.getmac');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'mac:',textAlign: TextAlign.center,
            ),

            Text(" es:  " + _mac,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          setState(() {

            _incrementCounter();
            getmac();
            //Navigator.pushNamed(context, HomePage.id);
          });
        },
        //tooltip: 'Increment',
        child: const Icon(Icons.male),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<String> getmac() async {
    String mac = await Channel.invokeMethod('getMAC');
    print(mac);
    _mac = mac;
    return mac;
  }

}
