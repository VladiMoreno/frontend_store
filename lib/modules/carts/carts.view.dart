import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend_store/common/styles/custom_text.style.dart';
import 'package:frontend_store/common/widgets/layout.view.dart';
import 'package:frontend_store/common/widgets/loading.view.dart';
import 'package:frontend_store/common/widgets/return_home.view.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:frontend_store/utils/logg_message.util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'carts.controller.dart';

class CartsView extends StatefulWidget {
  CartsView({super.key});

  final CartsController controller = CartsController();

  @override
  State<CartsView> createState() => _CartsViewState();
}

class _CartsViewState extends State<CartsView> {
  @override
  void initState() {
    widget.controller.onReady();
    super.initState();
  }

  String formatterDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

  getDetailPurchase(int id) async {
    try {
      final detailInfo = await widget.controller.getDetailPurchase(id);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        barrierColor: const Color.fromARGB(115, 0, 0, 0),
        builder: (BuildContext context) {
          return ModalDetailPurchase(
            info: detailInfo,
          );
        },
      );
    } catch (e) {
      printMessageParam(
        message: 'Ha ocurrido un error',
        param: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.controller.isLoading.isTrue
          ? const LoadingView()
          : LayoutView(
              screenToShow: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    const ReturnHomeView(),
                    const SizedBox(height: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        widget.controller.info.length,
                        (index) {
                          final info = widget.controller.info[index];

                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            width: GetSize.width * .8,
                            child: Column(
                              children: [
                                const CustomText(text: 'Realizado por:'),
                                CustomText(text: info['user_name']),
                                const SizedBox(height: 10),
                                const CustomText(text: 'Total de la venta:'),
                                CustomText(
                                  text: '\$${info['total'].toString()}',
                                ),
                                const SizedBox(height: 10),
                                const CustomText(text: 'Fecha realizada:'),
                                CustomText(
                                  text: formatterDate(info['created_at']),
                                ),
                                const SizedBox(height: 25),
                                InkWell(
                                  onTap: () async {
                                    await getDetailPurchase(info['id']);
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.eye,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ModalDetailPurchase extends StatelessWidget {
  final Map info;

  const ModalDetailPurchase({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          minWidth: GetSize.width,
          maxHeight: GetSize.height * .7,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: GetSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.circleXmark,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: GetSize.width * .05),
                  ],
                ),
              ),
              const CustomText(text: 'Detalle de la venta'),
              const SizedBox(height: 15),
              const CustomText(text: 'Realizado por:'),
              CustomText(text: info['user']),
              const SizedBox(height: 15),
              const CustomText(text: 'Compra realizada:'),
              CustomText(text: info['fecha']),
              const SizedBox(height: 15),
              const CustomText(text: 'Total de la compra:'),
              CustomText(
                text: '\$${info['total'].toString()}',
              ),
              const SizedBox(height: 15),
              const CustomText(text: 'Detalle de la compra:'),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: GetSize.width * .04),
                  SizedBox(
                    width: GetSize.width * .25,
                    child: const CustomText(
                      text: 'Producto',
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: GetSize.width * .25,
                    child: const CustomText(
                      text: 'Cantidad',
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: GetSize.width * .25,
                    child: const CustomText(
                      text: 'Sub-Total',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: List.generate(
                  info['detalle'].length,
                  (index) {
                    final detalle = info['detalle'][index];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: GetSize.width * .04),
                        SizedBox(
                          width: GetSize.width * .25,
                          child: CustomText(
                            text: detalle['producto'],
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: GetSize.width * .25,
                          child: CustomText(
                            text: detalle['amount'].toString(),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: GetSize.width * .25,
                          child: CustomText(
                            text: '\$${detalle['price']}',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
