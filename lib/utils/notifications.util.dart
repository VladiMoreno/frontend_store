import 'package:flutter/material.dart';
import 'package:frontend_store/constants/type_notification.constants.dart';
import 'package:frontend_store/utils/get_size.util.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class Notifications {
  TypeNotification typeProcess;
  String typeNotification;
  String titleNotification;
  String textNotification;
  Function? functionToDo;
  String? redirectTo;

  Notifications({
    required this.typeProcess,
    required this.typeNotification,
    required this.titleNotification,
    required this.textNotification,
    this.functionToDo,
    this.redirectTo,
  }) {
    double width = GetSize.width;
    double widthNotification = 500;
    String gifToShow = 'assets/gifs/action_success.gif';

    if (width < 400) {
      widthNotification = width * .8;
    }

    switch (typeNotification) {
      case 'success':
        gifToShow = 'assets/gifs/action_success.gif';
        break;
      case 'error':
        gifToShow = 'assets/gifs/action_error.gif';
        break;
      case 'warning':
        gifToShow = 'assets/gifs/action_warning.gif';
        break;
      default:
        gifToShow = 'assets/gifs/action_success.gif';
    }

    switch (typeProcess) {
      case TypeNotification.simpleNotification:
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          customAsset: gifToShow,
          title: titleNotification,
          text: textNotification,
          confirmBtnText: 'Aceptar',
          width: widthNotification,
          barrierDismissible: false,
        );
        break;
      case TypeNotification.notificationWithRedirect:
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          customAsset: gifToShow,
          title: titleNotification,
          text: textNotification,
          confirmBtnText: 'Aceptar',
          width: widthNotification,
          onConfirmBtnTap: () => Get.toNamed(redirectTo!),
          barrierDismissible: false,
        );
        break;
      case TypeNotification.confirmNotification:
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          customAsset: gifToShow,
          title: titleNotification,
          text: textNotification,
          width: widthNotification,
          barrierDismissible: false,
          confirmBtnText: 'Aceptar',
          cancelBtnText: 'No',
          showCancelBtn: true,
          confirmBtnColor: const Color.fromRGBO(255, 63, 63, 1),
          onConfirmBtnTap: () async {
            Navigator.pop(Get.context!);
            await Future.delayed(const Duration(milliseconds: 100));
            await functionToDo!();
          },
        );
        break;
      case TypeNotification.notificationWithFunctionToDo:
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          customAsset: gifToShow,
          title: titleNotification,
          text: textNotification,
          width: widthNotification,
          barrierDismissible: false,
          confirmBtnText: 'Aceptar',
          showCancelBtn: false,
          confirmBtnColor: const Color.fromRGBO(255, 63, 63, 1),
          onConfirmBtnTap: () async {
            Navigator.pop(Get.context!);
            await Future.delayed(const Duration(milliseconds: 100));
            await functionToDo!();
          },
        );
        break;
      default:
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          customAsset: gifToShow,
          title: titleNotification,
          text: textNotification,
          confirmBtnText: 'Aceptar',
          width: widthNotification,
          barrierDismissible: false,
        );
    }
  }
}
