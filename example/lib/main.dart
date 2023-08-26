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
  final GlobalKey _globalKey = GlobalKey();
  bool isLoading = false;

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

  Future<void> _printReceiptBitmap() async {
    // setState(() => isLoading = true);
    Uint8List? bitmapWidget = await _capturePng();
    if (bitmapWidget != null) {
      await PaxPrinter().initPrinter();
      await PaxPrinter().setGray(3);
      await PaxPrinter().printBitmap(bitmapWidget);
      await PaxPrinter().start();
      // await PaxPrinter().print("\n\n\n", null);
      // await FlutterPaxPrinterUtility.init;
      // await FlutterPaxPrinterUtility.setGray(3);
      // await FlutterPaxPrinterUtility.printBitmap(bitmapWidget);
      // await FlutterPaxPrinterUtility.printStr("\n\n\n\n", null);
      // await FlutterPaxPrinterUtility.start();
    }
    // setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Print From Bitmap"),
        actions: [
          IconButton(onPressed: _printReceiptBitmap, icon: const Icon(Icons.print)),
        ],
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: const Center(
            child: Text('تست فارسی'),
          ),
        ),
      ),
    );
  }
}
