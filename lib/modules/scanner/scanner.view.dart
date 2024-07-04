import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend_store/common/styles/custom_text.style.dart';
import 'package:frontend_store/common/widgets/close_session.view.dart';
import 'package:frontend_store/common/widgets/layout.view.dart';
import 'package:frontend_store/common/widgets/loading.view.dart';
import 'package:frontend_store/common/widgets/return_home.view.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:frontend_store/utils/get_storage.util.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import 'scanner.controller.dart';

class ScannerView extends StatefulWidget {
  ScannerView({super.key});

  final ScannerController controller = ScannerController();

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  double total = 0.0;
  bool addingProduct = false;

  Map<String, dynamic> product = {};

  List<Map<String, dynamic>> detalleVenta = [];

  increaseAmount(Map<String, dynamic> info) {
    setState(() {
      info['amount'] += 1;
      double subtotal = info['amount'] * double.parse(info['price']);
      info['sub-total'] = double.parse(subtotal.toStringAsFixed(2));
    });
  }

  decreaseAmount(Map<String, dynamic> info) {
    setState(() {
      info['amount'] -= 1;
      double subtotal = info['amount'] * double.parse(info['price']);
      info['sub-total'] = double.parse(subtotal.toStringAsFixed(2));
    });
  }

  finishPurchase() async {
    await widget.controller.finishPurchase(detalleVenta);

    setState(() {
      detalleVenta = [];
      total = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userType = StorageService().storage.read('user_type');

    return Obx(
      () => widget.controller.isLoading.isTrue
          ? const LoadingView()
          : LayoutView(
              screenToShow: Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    if (userType == '1') ...[
                      const ReturnHomeView(),
                    ],
                    if (userType == '2') ...[
                      const CloseSessionView(),
                    ],
                    const SizedBox(height: 25),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          addingProduct = true;
                        });
                        var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SimpleBarcodeScannerPage(),
                            ));

                        if (res is String) {
                          final response =
                              await widget.controller.getInformationByCode(
                            res,
                          );

                          setState(() {
                            product = response;
                          });
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                product = {};
                                detalleVenta = [];
                                total = 0.0;
                              });
                            },
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
                            onTap: () async {
                              await finishPurchase();
                            },
                            child: Container(
                              width: GetSize.width * .4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: const CustomText(text: 'Finalizar venta'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: List.generate(detalleVenta.length, (index) {
                          final info = detalleVenta[index];

                          return Container(
                            width: GetSize.width * .9,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const CustomText(text: 'Producto: '),
                                    CustomText(text: info['name']),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const CustomText(text: 'Amount: '),
                                    CustomText(text: info['amount'].toString()),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const CustomText(text: 'Sub Total: '),
                                    CustomText(
                                      text: '\$${info['sub-total'].toString()}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
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
                                double subTotal = double.parse(
                                    product['sub-total'].toString());
                                total +=
                                    double.parse(subTotal.toStringAsFixed(2));
                                product = {};
                                addingProduct = false;
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
                                addingProduct = false;
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
