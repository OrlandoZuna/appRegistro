
import 'package:appp/pages/cuaderno_virtual.dart';
import 'package:appp/pages/impor_expor.dart';
import 'package:appp/pages/mac_page.dart';
import 'package:appp/pages/perfil_usuario.dart';
import 'package:appp/pages/registro_asistencia.dart';
import 'package:appp/pages/ver_registro.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MenuPage()));

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  static String id= 'menu_page';

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final NavigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    PersonalPage(),
    HomePage(),
    MyHomePage2(title: ''),
    RegistroPage(),
    VerRegistroPage(),
    ImporExpor(),
  ];

  @override
  Widget build(BuildContext context) {
    final itemss = <Widget>[
      Icon(Icons.perm_identity, size: 30),
      Icon(Icons.perm_device_info, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.my_library_books_outlined, size: 30),
      Icon(Icons.book_online, size: 30),
      Icon(Icons.account_balance_wallet_sharp, size: 30)

    ];

    return Scaffold(
    backgroundColor: Colors.blueAccent,
    body: screens[index],
      bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(
      color: Colors.black),
      ),
          child: CurvedNavigationBar(
          key: NavigationKey,
          color: Colors.blueAccent,
          backgroundColor: Colors.white,
          height: 60.0,
          animationCurve: Curves.easeInOutCubic,
          animationDuration: Duration(milliseconds: 600),
          index: index,
          items: itemss,
          onTap: (index) => setState(() {
            this.index = index;
          }),
          ),
      ),
    );
  }
}

