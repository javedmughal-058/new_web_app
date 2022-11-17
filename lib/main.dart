import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    final newVersion = NewVersionPlus(androidId: "com.usapparelandtextiles.us_app");
    Timer(const Duration(milliseconds: 800), (){
      checkNewVersion(newVersion);
    });
  }
  
  void checkNewVersion(NewVersionPlus newVersionPlus)async{
    final statusValue = await newVersionPlus.getVersionStatus();
    if(statusValue != null){
      if(statusValue.canUpdate){
        newVersionPlus.showUpdateDialog(
          context: context,
          versionStatus: statusValue,
          dialogText: 'New Version is available in the app store(${statusValue.storeVersion}), update now! ',
          dialogTitle: 'update is available',

        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          String _url = 'https://africaexchange.cash/admin/cnetpay/cnetpay.php?user_id=25&receiver_country=Ivory-XOF&amount=300&fee=100&total_pay=400&receiver_f_name=Sarem&receiver_l_name=Iftikhar&receiver_email=sarimiftikhar@gmail.com&receiver_phone=03361149673&currency_type=XAF&status=0&transaction_id=29797053';
          openBrowserUrl(url : _url, inApp: false);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<void> openBrowserUrl({required String url, bool inApp =false,})async {
    if(await canLaunchUrl(Uri.parse(url))){
      await launch(url, forceSafariVC: inApp, forceWebView: inApp, enableJavaScript: true);
    }
  }
}
