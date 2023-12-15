import 'package:flutter/material.dart';
import 'page/teller_page.dart';
import 'page/cs_page.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Antrian',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HalamanDashboard(),
    );
  }
}

class HalamanDashboard extends StatelessWidget {
  const HalamanDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ambil Antrian'),
        ),
        body: Column(
          children: [
            Text('Silahkan Pilih Bagian Anda :', style: 
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),),
            Row(children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TellerPage()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.orange[900]),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(400, 200))),
                          child: Text(
                            'Teller',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          )))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CsPage()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green[700]),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(400, 200))),
                          child: Text(
                            'Customer Services',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          )))),
            ]),
          ],
        ));
  }
}
