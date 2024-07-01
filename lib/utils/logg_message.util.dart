import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
  ),
);

///Esta es una función para imprimir un error en consola
///
///Los parámetros necesarios son:
///
///nombre de la función
///
///nombre del archivo
///
///para utilizar la función quedaría
///
/// ```dart
///printLogg(nombre_de_la_función, nombre_del_archivo)
/// ```
void printLogg(String functionName, String fileName) {
  logger.e('Error en la función : $functionName en el archivo $fileName');
}

///Esta es una función para imprimir un mensaje en consola
///
///El parámetro necesario es:
///
///Mensaje o parámetro a mostrar
///
///para utilizar la función quedaría
///
/// ```dart
///printConsole(message)
/// ```
void printConsole(String message) {
  logger.i(message);
}

///Esta es una función para imprimir una variable en consola
///
///El parámetro necesario es:
///
///Mensaje a mostrar (no requerido)
///
///Variable a mostrar
///
///para utilizar la función quedaría
///
/// ```dart
///printConsole(message)
/// ```
void printMessageParam({String message = "", dynamic param}) {
  logger.i(message);
  logger.i(param);
}

///Esta es una función para imprimir un error en consola
///
///Los parámetros necesarios son:
///
///el error a mostrar
///
///el tipo de error obtenido
///
///para utilizar la función quedaría
///
/// ```dart
///printErrorLog(error, tipo_del_error)
/// ```
void printErrorLog({dynamic error, dynamic typeError}) {
  logger.f('ERROR TYPE: $typeError\nMESSAGE: $error');
}
