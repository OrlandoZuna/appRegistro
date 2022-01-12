import 'dart:async';

import 'package:appp/pages/menu_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


import 'package:macadress_gen/macadress_gen.dart';
import 'package:provider/provider.dart';

class Login2Page extends StatefulWidget{
  static String id = 'login2';



  @override
  _Login2PageState createState() => _Login2PageState();
}

class _Login2PageState extends State<Login2Page>{

  mostrar_conexion(){
    if( _connectionStatus == "ConnectivityResult.wifi" || _connectionStatus == "ConnectivityResult.mobile" ){
      showModalBottomSheet(context: context,backgroundColor: Colors.white70,

          builder: (BuildContext context){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Image.asset('images/conexion.jpg'),
          Text('$_connectionStatus',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              backgroundColor: Colors.white,

            ),
          ),
        ],
      );
      }
      );
    }
    if( _connectionStatus == "ConnectivityResult.none"){
      showModalBottomSheet(context: context,backgroundColor: Colors.white70,

          builder: (BuildContext context){
            onTap: (){
              Navigator.of(context).pop();
            };
            return Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                ListTile(
                  leading: Icon(Icons.cancel, size: 60, color: Colors.yellow,),
                  title: Text('salir'),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                ),
                Image.asset('images/sin_conexion.jpg'),
                SizedBox(height: 20.0),
                Text('$_connectionStatus',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    backgroundColor: Colors.white,

                  ),

                ),

              ],

            );

          }
      );
    }

  }

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  MacadressGen macadressGen = MacadressGen();
  String mac = 'MAC';
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }


  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Image.asset('images/descarga.png',
          height: 200.0,
          ),),
           // SizedBox(height: 10.0,),
             _userTextField(),
            SizedBox(height: 5.0,),
            _passwordTextField(),
            SizedBox(height: 15.0,),
            _bottonLogin(),
            SizedBox(height: 5.0,),
            _bottonDatos(),
            Text('$_connectionStatus'),

          ],
        ),
      ),
    ));
  }

   Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'ejemplo@gmail.com',
                labelText: 'correo de usuario',
              ),
              onChanged: (value){

              },
            ),
          );
        });
   }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              controller: passController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'ingrese su contraseña',
                labelText: 'contraseña',
              ),
              onChanged: (value){

              },
            ),
          );
        });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Builder(
              builder: (context) {
                return RaisedButton(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,
                        vertical: 5.0,),
                    child: const Text('Ingresar',
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
                    login();
                  },
                );
              }
          );
        }
    );
  }
  Widget _bottonDatos() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Builder(
              builder: (context) {
                return RaisedButton(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: const Text('Mostrar Mac',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10.0,
                  color: Colors.orangeAccent,
                  onPressed: (){
                      mostrar();
                      mostrar_conexion();
                  },
                );
              }
          );
        }
    );
  }
  Future<String> getMAc() async {
    //await Future.delayed(Duration(seconds: 3));
    mac = await macadressGen.getMac();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(mac, style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Colors.white,
        ),)));
    print(mac);
    return mac;
  }
  Future<void> login() async {
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty){
      var response = await http.post(Uri.parse("http://swservice.uatf.edu.bo/api/login"),
          body: ({
            'email': emailController.text,
            'password': passController.text
          }));
      if(response.statusCode == 200 && mac != 'MAC'){
        print('inicio sesion');
        Navigator.pushNamed(context, MenuPage.id);

      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('datos no correctos o presione Mostar Mac')));
      }
    } else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("ingrese datos en los campos requeridos")));
    }
  }
  Future<void> mostrar() async {
    getMAc();
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}








