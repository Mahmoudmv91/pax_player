import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pax_player/pax_player.dart';
import 'package:pax_player_example/services/pax_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'سیستم پرداخت الکترونیک اتوبوسرانی قزوین'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String? _cardNumber = 'Unknown card number.';
  String? _deviceInfo = 'Unknown Device.';

  // String _card='';

  Future<void> _getCardNumber() async {
    setState(() {
      _cardNumber = 'کارت را بکشید';
    });
    String? number;
    try {

      String? result = await PaxPlayer().getCardNumber();
      if(result !=null){

      if (result.length > 16) result = result.substring(1, 17);
      number = result;
      }
    } on PlatformException catch (e) {
      number = "Failed to get card number: '${e.message}'.";
    }

    // setState(() {
    _cardNumber = number;
    // });
    if (mounted) {

      if (_cardNumber !=null && _cardNumber!.length == 16) {
        onGetGateWay(context, _cardNumber!);
      }
    }
  }

  Future<void> _getDeviceInfo() async {
    String? device;
    try {
      String? result = await PaxPlayer().getDeviceInfo();
      if(result !=null){

      final sn = result.split("\n");

      result = sn[0].split(":").last;
      device = result;
      }
    } on PlatformException catch (e) {
      device = "Failed to get device info: '${e.message}'.";
    }
    _deviceInfo = device;
  }

  Future<void> onGetGateWay(BuildContext context, String cardNumber) async {
    // showLoading(context);

    if (2 + 2 == 4) {
      await callGeneralApi(
        macAddress: '74-D4-35-5C-CD-F4',
        browser: 'IPhone6',
        browserVersion: '1.0.02',
        os: 'xx',
        osVersion: '1.0.02',
        resolution: '1000*200',
        ip: '192.168.1.2',
        // token: tokenProvider,
        addressApi: 'SetDisCharge',
        terminalGUID: _deviceInfo,
        cardNo: cardNumber,
        qty: 1,
      )!
          .then((response) => onGetGateWayMethod(response, context))
          .onError((error, stackTrace) => log(error.toString()))
          .whenComplete(() {});
    } else {
      // pop(context);
      // isConnect(context);
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await PaxPlayer().setDisableNavBar();
      await PaxPlayer().setEnableNavBar();
      _getDeviceInfo();
      _getCardNumber();
    });
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              //
              // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
              // action in the IDE, or press "p" in the console), to see the
              // wireframe for each widget.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text(
                //   _deviceInfo,
                //   style: Theme.of(context).textTheme.headlineMedium,
                // ),
                Text(
                  _cardNumber ?? 'Not Found',
                  style: const TextStyle(fontSize: 50),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: const Text(
                'پرهام کیش',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onGetGateWayMethod(Response? response, BuildContext context) async {
    if (response!.statusCode == 200) {
      final jsonResponse = jsonDecode(response.data);

      debugPrint(jsonResponse.toString());

      final Map<String, dynamic> map = jsonResponse;
      final int returnValue = map['Result']['ReturnValue'];
      switch (returnValue) {
        case 3000:
        case 4000:
          try {
            // Navigator.pop(context);
            // tokenExpired(jsonResponse, context);
          } catch (error) {
            debugPrint(error.toString());
          }
          break;
        case 0:
          try {
            log(jsonResponse.toString());
            await PaxPlayer().getBeep(100);
            setState(() {
              _cardNumber = map['Result']['ReturnValueMessage'];
            });
            Future.delayed(const Duration(milliseconds: 500)).then((value) => _getCardNumber());
          } catch (error) {
            debugPrint(error.toString());
          }
          break;
        default:
          await PaxPlayer().getBeep(500);
          setState(() {
            _cardNumber = map['Result']['ReturnValueMessage'];
          });
          Future.delayed(const Duration(milliseconds: 500)).then((value) => _getCardNumber());
        // pop(context);
      }
    }
  }
}
