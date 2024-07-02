import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend_store/common/styles/custom_text.style.dart';
import 'package:frontend_store/common/widgets/layout.view.dart';
import 'package:frontend_store/common/widgets/loading.view.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:get/get.dart';

import 'scanner.controller.dart';

class ScannerView extends StatefulWidget {
  ScannerView({super.key});

  final ScannerController controller = ScannerController();

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  String scanBarcode = 'Unknown';
  double total = 0.0;
  bool addingProduct = false;

  Map<String, dynamic> product = {};

  List<Map<String, dynamic>> detalleVenta = [];

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
    });
  }

  increaseAmount(Map<String, dynamic> info) {
    setState(() {
      info['amount'] += 1;
      double subtotal = info['amount'] * info['price'];
      info['sub-total'] = double.parse(subtotal.toStringAsFixed(2));
    });
  }

  decreaseAmount(Map<String, dynamic> info) {
    setState(() {
      info['amount'] -= 1;
      double subtotal = info['amount'] * info['price'];
      info['sub-total'] = double.parse(subtotal.toStringAsFixed(2));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.controller.isLoading.isTrue
          ? const LoadingView()
          : LayoutView(
              screenToShow: Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        setState(() {
                          addingProduct = true;
                        });
                        if (kIsWeb) {
                          setState(() {
                            product = {
                              "id": 1,
                              "name": "Producto 1",
                              "price": 4.99,
                              "amount": 1,
                              "sub-total": 4.99,
                            };
                          });
                        } else {
                          scanBarcodeNormal();
                        }
                      },
                      child: Container(
                        width: GetSize.width * .7,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: const CustomText(text: 'Escanear código'),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const CustomText(
                      text: 'Total de la venta:',
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: '\$${total.toString()}',
                    ),
                    const SizedBox(height: 30),
                    if (!addingProduct && detalleVenta.isNotEmpty) ...[
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: GetSize.width * .4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                  child: const CustomText(text: 'Cancelar'),
                                ),
                              ),
                              SizedBox(width: GetSize.width * .07),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: GetSize.width * .4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                  child:
                                      const CustomText(text: 'Finalizar venta'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ] else if (product.isNotEmpty) ...[
                      Column(
                        children: [
                          CustomText(
                            text: 'Producto : ${product['name']}',
                          ),
                          CustomText(
                            text: 'Precio : \$${product['price'].toString()}',
                          ),
                          CustomText(
                            text: 'Cantidad : ${product['amount'].toString()}',
                          ),
                          CustomText(
                            text:
                                'Sub total : \$${product['sub-total'].toString()}',
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (product['amount'] > 1) {
                                    decreaseAmount(product);
                                  }
                                },
                                child: Container(
                                  width: GetSize.width * .3,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: product['amount'] > 1
                                        ? Colors.red
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                  child: const FaIcon(FontAwesomeIcons.minus),
                                ),
                              ),
                              const SizedBox(width: 20),
                              InkWell(
                                onTap: () {
                                  increaseAmount(product);
                                },
                                child: Container(
                                  width: GetSize.width * .3,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                  child: const FaIcon(FontAwesomeIcons.plus),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                detalleVenta.add(product);
                                total += product['price'];
                                product = {};
                              });
                            },
                            child: Container(
                              width: GetSize.width * .8,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: const CustomText(text: 'Agregar producto'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                product = {};
                              });
                            },
                            child: Container(
                              width: GetSize.width * .8,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: const CustomText(text: 'Cancelar'),
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ),
    );
  }
}
