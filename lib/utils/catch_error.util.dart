import 'package:dio/dio.dart';
import 'package:frontend_store/constants/error_message.constants.dart';
import 'package:frontend_store/constants/type_notification.constants.dart';
import 'package:frontend_store/utils/notifications.util.dart';

class CatchErrorManagement {
  dynamic error;
  Function? function;
  String? messageToShow;

  CatchErrorManagement({
    required this.error,
    this.function,
    this.messageToShow,
  }) {
    String message = '';

    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError) {
        message = messageToShow ?? connectionErrorMessage;
      } else if (error.type == DioExceptionType.badResponse) {
        if (error.message != null) {
          message = error.message;
        } else if (error.error != null) {
          message = '';
          for (var err in error.error) {
            message += err;
            message += '\n';
          }
        } else {
          message = badResponseMessage;
        }
      } else if (error.type == DioExceptionType.cancel) {
        message = messageToShow ?? cancelMessage;
      } else {
        message = messageToShow ?? dioExceptionMessage;
      }
    } else {
      message = messageToShow ?? exceptionErrorMessage;
    }

    Notifications(
      typeProcess: TypeNotification.notificationWithFunctionToDo,
      typeNotification: 'warning',
      titleNotification: 'Error!',
      textNotification: message,
      functionToDo: () => function != null ? function!() : () {},
    );
  }
}
