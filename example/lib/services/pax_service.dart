import 'dart:developer';

import 'package:dio/dio.dart';

import '../dio/api_connection.dart';

Future<Response?>? callGeneralApi({
  //Complete
  String? macAddress,
  String? browser,
  String? browserVersion,
  String? os,
  String? osVersion,
  String? resolution,
  String? ip,
  String? addressApi,
  String? terminalGUID,
  String? cardNo,
  int? qty,
}) async {
  final Map params = {
    'MacAddress': macAddress,
    'Browser': browser,
    'BrowserVersion': browserVersion,
    'OS': os,
    'OSVersion': osVersion,
    'Resolution': resolution,
    'IP': ip,
    'TerminalGUID': terminalGUID,
    'CardNo': cardNo,
    'QTY': qty,
  };
  try {
    final Dio dio = await getApiConnection();
    final Response response = await dio.post('/$addressApi', data: params);
    return response;
  } catch (error, stacktrace) {
    // if (kDebugMode) {
    log('stackTrace: ${stacktrace.toString()}', error: error);
    // }
    // return error;
  }
  return null;
}
