import 'package:flutter/material.dart';
import 'package:game/pg2.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

final nick = TextEditingController();

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String nickSalvo = "";

  @override
  void initState() {
    super.initState();
    lerString();
  }

  void salvarString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('chaveSharedPreferences', nickSalvo);
  }

  void lerString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? valor = prefs.getString('chaveSharedPreferences');
    if (valor != null) {
      setState(() {
        nickSalvo = valor;
        nick.text = valor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 50, 22, 46),
        appBar: AppBar(
          title: Text(nick.text.isNotEmpty ? nick.text : nickSalvo),
          backgroundColor: const Color.fromARGB(255, 102, 44, 110),
          actions: [Builder(builder: (context) => ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Pg2())), child: Text("Ir")))],
        ),
        body: Center(
          child: TextField(
            controller: nick,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 212, 251),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              nickSalvo = nick.text;
              salvarString();
            });
          },
        ),
      ),
    );
  }
}