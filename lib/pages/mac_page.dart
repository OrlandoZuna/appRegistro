import 'dart:async';
import 'package:appp/main.dart';
import 'package:flutter/material.dart';
import 'package:macadress_gen/macadress_gen.dart';
import 'package:device_info/device_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = 'mac_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MacadressGen macadressGen = MacadressGen();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  String mac = 'MAC';
  String model = "MODELO";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATOS DEL EQUIPO'),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Datos del Movil:',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),


            Text(" Mac: " + mac,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 20.0,),

            Text("Modelo: " + model, style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),),
           _butonDatos(),
          ],

        ),

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          setState(() {

            //getMAc();
            //getModel();
            _butonDatos();
            //Navigator.pushNamed(context, MyHomePage.id);
          });
        },
        backgroundColor: Colors.orangeAccent,

        //tooltip: 'Increment',
        child: const Icon(Icons.data_saver_off_outlined,semanticLabel: 'mostrar',color: Colors.yellowAccent,
        size: 35.0,),


      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<String> getMAc() async {
    //await Future.delayed(Duration(seconds: 3));
    mac = await macadressGen.getMac();
    return mac;
  }

   Future<void> getModel() async {

     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
     model = androidInfo.model;
     print('${androidInfo.model}'.toString()+'  hola');  // e.g. "Moto G (4)"

     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
     print('${iosInfo.utsname.machine}');
   }

  Widget _butonDatos() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Builder(
              builder: (context) {
                return RaisedButton(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                    child: const Text('Datos',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10.0,
                  color: Colors.green,
                  onPressed: (){
                    getMAc();getModel();
                    //Navigator.pushNamed(context, Login2Page.id),
                     // arguments: ClaseDatos(mac.toString(), model.toString()),
                    //);


                    //Navigator.pushNamed(context, Login2Page.id);
                  },
                );
              }
          );
        }
    );
  }
}



