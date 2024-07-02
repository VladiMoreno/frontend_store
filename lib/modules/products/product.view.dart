import 'package:flutter/material.dart';
import 'package:frontend_store/common/styles/custom_text.style.dart';
import 'package:frontend_store/common/widgets/forms/text.input.dart';
import 'package:frontend_store/common/widgets/layout.view.dart';
import 'package:frontend_store/common/widgets/loading.view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend_store/config/env.config.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:get/get.dart';

import 'product.controller.dart';

class ProductView extends StatefulWidget {
  ProductView({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String action = 'View';

  manejoProducto(Map<String, dynamic> info) async {
    await widget.controller.actualizarProducto(info);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.controller.isLoading.isTrue
          ? const LoadingView()
          : LayoutView(
              screenToShow: Column(
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
                      child: Column(
                        children: [
                          const CustomText(text: 'Nombre del producto:'),
                          CustomText(text: info['name']),
                          const SizedBox(height: 10),
                          const CustomText(text: 'Precio del producto:'),
                          CustomText(text: '\$${info['price'].toString()}'),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    barrierColor:
                                        const Color.fromARGB(115, 0, 0, 0),
                                    builder: (BuildContext context) {
                                      return ModalProduct(
                                        action: 'view',
                                        info: info,
                                      );
                                    },
                                  );
                                },
                                child: const FaIcon(
                                  FontAwesomeIcons.eye,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    barrierColor:
                                        const Color.fromARGB(115, 0, 0, 0),
                                    builder: (BuildContext context) {
                                      return ModalProduct(
                                        action: 'update',
                                        info: info,
                                        function: manejoProducto,
                                      );
                                    },
                                  );
                                },
                                child: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const FaIcon(
                                  FontAwesomeIcons.trashCan,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class ModalProduct extends StatelessWidget {
  final String action;
  final Map<String, dynamic> info;
  final Function? function;

  const ModalProduct({
    super.key,
    required this.action,
    required this.info,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    TextEditingController idController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    final FocusNode idNode = FocusNode();
    final FocusNode nameNode = FocusNode();
    final FocusNode priceNode = FocusNode();

    cleanParameters() {
      idController.text = "";
      nameController.text = "";
      priceController.text = "";
    }

    setParameters() {
      idController.text = info['id'].toString();
      nameController.text = info['name'];
      priceController.text = info['price'].toString();
    }

    setParameters();

    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          minWidth: GetSize.width,
          maxHeight: GetSize.height * .8,
        ),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                if (action == 'view') ...[
                  const CustomText(text: 'Detalle del producto')
                ],
                if (action == 'update') ...[
                  const CustomText(text: 'Actualizar información')
                ],
                if (action == 'add') ...[
                  const CustomText(text: 'Añadir producto')
                ],
                const SizedBox(height: 15),
                TextInput(
                  width: GetSize.width * .65,
                  labelText: 'ID',
                  enabled: false,
                  controller: idController,
                  currentFocus: idNode,
                  nextFocus: nameNode,
                ),
                const SizedBox(height: 15),
                TextInput(
                  width: GetSize.width * .65,
                  labelText: 'Nombre',
                  enabled: action == 'view' ? false : true,
                  controller: nameController,
                  currentFocus: nameNode,
                  nextFocus: priceNode,
                ),
                const SizedBox(height: 15),
                TextInput(
                  width: GetSize.width * .65,
                  labelText: 'Precio',
                  enabled: action == 'view' ? false : true,
                  controller: priceController,
                  currentFocus: priceNode,
                  nextFocus: priceNode,
                ),
                const SizedBox(height: 15),
                const CustomText(text: 'Código de barra'),
                if (action != 'add') ...[
                  const SizedBox(height: 15),
                  Image.network(
                    imageUrl + info['barcode_image_path'],
                  ),
                ],
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: GetSize.width * .3,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: const CustomText(text: 'Cerrar'),
                      ),
                    ),
                    if (action != 'view') ...[
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            final info = {
                              "id": idController.value.text.toString(),
                              "name": nameController.value.text.toString(),
                              "price": priceController.value.text.toString()
                            };
                            await function!(info);

                            cleanParameters();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          width: GetSize.width * .3,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: CustomText(
                            text: action == 'update' ? 'Actualizar' : 'Añadir',
                          ),
                        ),
                      ),
                    ],
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
