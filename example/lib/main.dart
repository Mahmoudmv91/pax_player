import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pax_printer_utility/flutter_pax_printer_utility.dart';
import 'package:pax_player/pax_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        title: 'Pax Player Demo',
        debugShowCheckedModeBanner: false,
        // home: MyHomePage(title: 'Test Pax Player'),
        home: PaxMainPage(),
      ),
    );
  }
}

class PaxMainPage extends StatefulWidget {
  const PaxMainPage({super.key});

  @override
  State<PaxMainPage> createState() => _PaxMainPageState();
}

class _PaxMainPageState extends State<PaxMainPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('نام دستگاه:'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                child: const Center(child: Text('عملیات با موفقیت انجام شد')),
              ),
              const Spacer(),
              Material(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Text(
                      'اسکن',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaxManualPage(),
                    ),
                  );
                },
                child: const Text('ثبت دستی'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaxManualPage extends StatefulWidget {
  const PaxManualPage({super.key});

  @override
  State<PaxManualPage> createState() => _PaxManualPageState();
}

class _PaxManualPageState extends State<PaxManualPage> {
  String _data = '';
  final List<String> _key = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '*',
    '0',
    'x',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('نام دستگاه:', textDirection: TextDirection.rtl),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(_data),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: GridView.builder(
                  itemCount: _key.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (BuildContext context, int index) {
                    final item = _key[index];
                    return Material(
                      color: Colors.grey.shade200,
                      child: InkWell(
                        onTap: () {
                          switch (item) {
                            case '1':
                              _data += '1';
                              break;
                            case '2':
                              _data += '2';
                              break;
                            case '3':
                              _data += '3';
                              break;
                            case '4':
                              _data += '4';
                              break;
                            case '5':
                              _data += '5';
                              break;
                            case '6':
                              _data += '6';
                              break;
                            case '7':
                              _data += '7';
                              break;
                            case '8':
                              _data += '8';
                              break;
                            case '9':
                              _data += '9';
                              break;
                            case '*':
                              // _data += '*';
                              break;
                            case '0':
                              _data += '0';
                              break;
                            case 'x':
                              if (_data.isNotEmpty) {
                                _data = _data.substring(0, _data.length - 1);
                              }
                              break;
                          }
                          setState(() {});
                        },

                        // width: 100,
                        // height: 100,
                        child: Center(child: Text(_key[index])),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                ),
                child: const Text(
                  'تایید',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     required this.title,
//     super.key,
//   });
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey _globalKey = GlobalKey();
//   bool isLoading = false;
//
//   Future<Uint8List?> _capturePng() async {
//     try {
//       RenderRepaintBoundary boundary = _globalKey.currentContext!
//           .findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);
//       var pngBytes = byteData!.buffer.asUint8List();
//       return pngBytes;
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(e.toString()),
//           backgroundColor: Colors.red,
//         ));
//       }
//     }
//     return null;
//   }
//
//   Future<void> _printReceiptBitmap() async {
//     Uint8List? bitmapWidget = await _capturePng();
//     if (bitmapWidget != null) {
//       await PaxPrinter().initPrinter();
//       await PaxPrinter().setGray(3);
//       await PaxPrinter().printBitmap(bitmapWidget);
//       await PaxPrinter().start();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Print From Bitmap"),
//         actions: [
//           IconButton(
//               onPressed: _printReceiptBitmap, icon: const Icon(Icons.print)),
//         ],
//       ),
//       body: RepaintBoundary(
//         key: _globalKey,
//         child: Container(
//           decoration: const BoxDecoration(color: Colors.white),
//           child: const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('تست فارسی'),
//                 Text('تست فارسی'),
//                 Text('تست فارسی'),
//                 Text('تست فارسی'),
//                 Text('تست فارسی'),
//                 Text('تست فارسی'),
//                 Text('تست فارسی'),
//                 Text('تست فارسی'),
//                 Text('تست فارسی'),
//                 Text('تست فارسی'),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SignBarcode extends StatefulWidget {
//   const SignBarcode({super.key});
//
//   @override
//   State<SignBarcode> createState() => _SignBarcodeState();
// }
//
// class _SignBarcodeState extends State<SignBarcode> {
//   // final TextEditingController _number = TextEditingController();
//   // final TextEditingController _count = TextEditingController();
//   //
//   // @override
//   // void dispose() {
//   //   _number.dispose();
//   //   _count.dispose();
//   //   super.dispose();
//   // }
//
//   printQrCode() async {
//     await FlutterPaxPrinterUtility.init;
//     await FlutterPaxPrinterUtility.fontSet(
//         EFontTypeAscii.FONT_24_24, EFontTypeExtCode.FONT_24_24);
//     await FlutterPaxPrinterUtility.printQRCode('123456789', 512, 512);
//     await FlutterPaxPrinterUtility.step(150);
//     var status = await FlutterPaxPrinterUtility.start();
//     return status;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ثبت نام / بارکد'),
//       ),
//       body: Column(
//         children: [
//           const Text('شماره موبایل:'),
//           const SizedBox(height: 10),
//           TextField(
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.number,
//           ),
//           const SizedBox(height: 10),
//           const Text('تعداد همراه:'),
//           const SizedBox(height: 10),
//           TextField(
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.number,
//           ),
//           const SizedBox(height: 50),
//           ElevatedButton(
//               onPressed: () => printQrCode(), child: const Text('چاپ')),
//         ],
//       ),
//     );
//   }
// }
//
// class SignCard extends StatefulWidget {
//   const SignCard({super.key});
//
//   @override
//   State<SignCard> createState() => _SignCardState();
// }
//
// class _SignCardState extends State<SignCard> {
//   String _cardNumber = 'کارت را بکشید';
//
//   Future<void> _getCardNumber() async {
//     setState(() {
//       _cardNumber = 'کارت را بکشید';
//     });
//     String? number;
//
//     try {
//       await FlutterPaxPrinterUtility.init;
//       await FlutterPaxPrinterUtility.fontSet(
//           EFontTypeAscii.FONT_24_24, EFontTypeExtCode.FONT_24_24);
//       await FlutterPaxPrinterUtility.spaceSet(0, 10);
//       String? result = await PaxPlayer().getCardNumber();
//       if (result != null) {
//         number = 'عملیات با موفقیت انجام شد';
//       }
//     } on PlatformException catch (e) {
//       number = "Failed to get barcode: '${e.message}'.";
//     }
//     if (!mounted) return;
//     setState(() {
//       _cardNumber = number!;
//     });
//     await FlutterPaxPrinterUtility.printQRCode('12345678', 512, 512);
//     await FlutterPaxPrinterUtility.step(150);
//     final status = await FlutterPaxPrinterUtility.start();
//     debugPrint(status);
//     await PaxPlayer().getBeep(100);
//     setState(() {
//       _cardNumber = 'number';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ثبت نام / کارت'),
//       ),
//       body: Column(
//         children: [
//           const Text('شماره موبایل:'),
//           const SizedBox(height: 10),
//           TextField(
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.number,
//           ),
//           const SizedBox(height: 10),
//           const Text('تعداد همراه:'),
//           const SizedBox(height: 10),
//           TextField(
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.number,
//           ),
//           const SizedBox(height: 50),
//           ElevatedButton(
//               onPressed: () {
//                 _getCardNumber();
//               },
//               child: const Text('کارت بکشید')),
//           const SizedBox(height: 30),
//           _cardNumber.contains('عملیات')
//               ? Text(_cardNumber)
//               : const SizedBox.shrink(),
//         ],
//       ),
//     );
//   }
// }
//
// class ScanCard extends StatefulWidget {
//   const ScanCard({super.key});
//
//   @override
//   State<ScanCard> createState() => _ScanCardState();
// }
//
// class _ScanCardState extends State<ScanCard> {
//   String _cardNumber = 'کارت را بکشید';
//
//   Future<void> _getCardNumber() async {
//     setState(() {
//       _cardNumber = 'کارت را بکشید';
//     });
//     String? number;
//
//     try {
//       String? result = await PaxPlayer().getCardNumber();
//       if (result != null) {
//         number = 'عملیات با موفقیت انجام شد';
//       }
//     } on PlatformException catch (e) {
//       number = "Failed to get barcode: '${e.message}'.";
//     }
//     if (!mounted) return;
//     setState(() {
//       _cardNumber = number!;
//     });
//     await PaxPlayer().getBeep(100);
//     Future.delayed(const Duration(milliseconds: 500), _getCardNumber);
//   }
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       _getCardNumber();
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('اسکن کارت'),
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(_cardNumber),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ScanBarcode extends StatefulWidget {
//   const ScanBarcode({super.key});
//
//   @override
//   State<ScanBarcode> createState() => _ScanBarcodeState();
// }
//
// class _ScanBarcodeState extends State<ScanBarcode> {
//   String _barcodeData = 'بارکد را اسکن نمایید';
//
//   Future<void> _getBarcode() async {
//     setState(() {
//       _barcodeData = 'بارکد را اسکن نمایید';
//     });
//     String? number;
//
//     try {
//       String? result = await PaxPlayer().getScanBarcode();
//       if (result != null) {
//         number = 'عملیات با موفقیت انجام شد';
//       }
//     } on PlatformException catch (e) {
//       number = "Failed to get barcode: '${e.message}'.";
//     }
//     if (!mounted) return;
//     setState(() {
//       _barcodeData = number!;
//     });
//     await PaxPlayer().getBeep(100);
//   }
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       _getBarcode();
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _getBarcode(),
//         child: const Icon(Icons.qr_code_scanner_outlined),
//       ),
//       appBar: AppBar(
//         title: const Text('اسکن بارکد'),
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(_barcodeData),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MainPax extends StatelessWidget {
//   const MainPax({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('پدیده'),
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SignBarcode()));
//                 },
//                 child: const Text('ثبت نام / بارکد')),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SignCard()));
//                 },
//                 child: const Text('ثبت نام / کارت')),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ScanCard()));
//                 },
//                 child: const Text('اسکن / کارت')),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ScanBarcode()));
//                 },
//                 child: const Text('اسکن / بارکد')),
//           ],
//         ),
//       ),
//     );
//   }
// }
