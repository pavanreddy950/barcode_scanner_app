import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Barcode Scanner',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.deepPurple,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: (result != null)
                        ? Text(
                            'Barcode Type: ${describeEnum(result!.format)}\nData: ${result!.code}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                          )
                        : Text(
                            'Scan a code',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          if (result == null)
            const Center(
              child: SpinKitPulse(
                color: Colors.deepPurple,
                size: 100.0,
              ),
            ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  describeEnum(BarcodeFormat format) {}
}
