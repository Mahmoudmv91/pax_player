import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pax_player/pax_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pax Player Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Test Pax Player'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    super.key,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _cardNumber = 'Unknown card number.';
  String? _deviceInfo = 'Unknown device.';
  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List?> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return null;
  }

  Future<void> _getCardNumber() async {
    setState(() {
      _cardNumber = 'swipe the card';
    });
    String? number;

    try {
      String? result = await PaxPlayer().getCardNumber();
      if (result != null) {
        number = result;
      }
    } on PlatformException catch (e) {
      number = "Failed to get card number: '${e.message}'.";
    }
    if (!mounted) return;
    setState(() {
      _cardNumber = number;
    });
    await PaxPlayer().getBeep(100);
  }

  Future<void> _getDeviceInfo() async {
    String? device;
    try {
      String? result = await PaxPlayer().getDeviceInfo();
      if (result != null) {
        device = result;
      }
    } on PlatformException catch (e) {
      device = "Failed to get device info: '${e.message}'.";
    }
    if (!mounted) return;
    setState(() {
      _deviceInfo = device;
    });
  }

  Future<void> _print() async {
    final a = await PaxPrinter().initPrinter();
    if (a != null && a) {
      String? status = await PaxPrinter().getStatusPrinter();
      log(status.toString());
      Uint8List? bitmapWidget = await _capturePng();
      if (bitmapWidget != null) {
        await PaxPrinter().printBitmap(bitmapWidget);
      }
      // await PaxPrinter().printReceipt();
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await PaxPlayer().setEnableNavBar(true);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'تست پرینت حروف فارسی',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  _deviceInfo ?? 'Unknown device info',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  _cardNumber ?? 'Unknown card number',
                  style: const TextStyle(fontSize: 50),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    _getDeviceInfo();
                    _getCardNumber();
                  },
                  child: const Text("Reset", style: TextStyle(fontSize: 40)),
                ),
                TextButton(
                  onPressed: () {
                    _print();
                  },
                  child: const Text("Print", style: TextStyle(fontSize: 40)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
