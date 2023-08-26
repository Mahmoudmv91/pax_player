// final String _cardNumber = 'Unknown card number.';
// final String _deviceInfo = 'Unknown device.';
// final GlobalKey _globalKey = GlobalKey();
// Uint8List? bitmapWidget;
//
// // Future<Uint8List?> _capturePng() async {
// //   try {
// //     RenderRepaintBoundary boundary =
// //         _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
// //     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
// //     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
// //     var pngBytes = byteData!.buffer.asUint8List();
// //     return pngBytes;
// //   } catch (e) {
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //       content: Text(e.toString()),
// //       backgroundColor: Colors.red,
// //     ));
// //   }
// //   return null;
// // }
// Future<Uint8List?> _capturePng() async {
//   try {
//     RenderRepaintBoundary boundary = _globalKey.currentContext!
//         .findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage();
//     ByteData? byteData =
//     await image.toByteData(format: ui.ImageByteFormat.png);
//     var pngBytes = byteData!.buffer.asUint8List();
//     return pngBytes;
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(e.toString()),
//       backgroundColor: Colors.red,
//     ));
//   }
//   return null;
// }
//
// // Future<void> _getCardNumber() async {
// //   setState(() {
// //     _cardNumber = 'swipe the card';
// //   });
// //   String? number;
// //
// //   try {
// //     String? result = await PaxPlayer().getCardNumber();
// //     if (result != null) {
// //       number = result;
// //     }
// //   } on PlatformException catch (e) {
// //     number = "Failed to get card number: '${e.message}'.";
// //   }
// //   if (!mounted) return;
// //   setState(() {
// //     _cardNumber = number;
// //   });
// //   await PaxPlayer().getBeep(100);
// // }
//
// // Future<void> _getDeviceInfo() async {
// //   String? device;
// //   try {
// //     String? result = await PaxPlayer().getDeviceInfo();
// //     if (result != null) {
// //       device = result;
// //     }
// //   } on PlatformException catch (e) {
// //     device = "Failed to get device info: '${e.message}'.";
// //   }
// //   if (!mounted) return;
// //   setState(() {
// //     _deviceInfo = device;
// //   });
// // }
//
// // Future<void> _print() async {
// //   final a = await PaxPrinter().initPrinter();
// //   if (a != null && a) {
// //     String? status = await PaxPrinter().getStatusPrinter();
// //     log(status.toString());
// //     Uint8List? bitmapWidget = await _capturePng();
// //     if (bitmapWidget != null) {
// //       // await PaxPrinter().initPrinter();
// //       // await PaxPrinter().setGray(3);
// //       // await PaxPrinter().printBitmap(bitmapWidget);
// //       // await PaxPrinter().start();
// //
// //       await FlutterPaxPrinterUtility.init;
// //       await FlutterPaxPrinterUtility.setGray(3);
// //       await FlutterPaxPrinterUtility.printBitmap(bitmapWidget);
// //       await FlutterPaxPrinterUtility.printStr("\n\n\n\n", null);
// //       await FlutterPaxPrinterUtility.start();
// //     }
// //   }
// //   // await PaxPrinter().printReceipt();
// // }
//
// Future<void> _printReceiptBitmap() async {
//
//   Uint8List? image = await _capturePng();
//   if (image != null) {
//     setState(() {
//       bitmapWidget = image;
//     });
//     Future.delayed(const Duration(seconds: 2)).then((_) async {
//
//       await FlutterPaxPrinterUtility.init;
//       await FlutterPaxPrinterUtility.setGray(3);
//       // await FlutterPaxPrinterUtility.printImageUrl("https://cdn.britannica.com/17/155017-050-9AC96FC8/Example-QR-code.jpg");
//       await FlutterPaxPrinterUtility.printBitmap(bitmapWidget!);
//       await FlutterPaxPrinterUtility.printStr("\n\n\n\n", null);
//       await FlutterPaxPrinterUtility.start();
//     });
//   }
//
// }
//
// @override
// void initState() {
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//   WidgetsBinding.instance.addPostFrameCallback((_) async {
//     // await PaxPlayer().setEnableNavBar(true);
//     // _getDeviceInfo();
//     // _getCardNumber();
//   });
//   super.initState();
//   // SystemChrome.setPreferredOrientations([
//   //   DeviceOrientation.landscapeRight,
//   // ]);
// }
//
// @override
// void dispose() {
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   super.dispose();
// }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Row(
//         children: [
//           Text(widget.title),
//           TextButton(
//             onPressed: _printReceiptBitmap,
//             child: const Text("Print", style: TextStyle(fontSize: 40,color: Colors.white)),
//           ),
//         ],
//       ),
//       centerTitle: true,
//     ),
//     body: RepaintBoundary(
//       key: _globalKey,
//       child: Center(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 'تست پرینت حروف فارسی',
//                 style: TextStyle(fontSize: 20),
//               ),
//               Text(
//                 _deviceInfo,
//                 style: const TextStyle(fontSize: 20),
//               ),
//               Text(
//                 _cardNumber,
//                 style: const TextStyle(fontSize: 50),
//                 textAlign: TextAlign.center,
//               ),
//               // TextButton(
//               //   onPressed: () {
//               //     // _getDeviceInfo();
//               //     // _getCardNumber();
//               //   },
//               //   child: const Text("Reset", style: TextStyle(fontSize: 40)),
//               // ),
//
//               if(bitmapWidget !=null) Image.memory(bitmapWidget!),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }