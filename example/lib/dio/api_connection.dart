import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiConnection {
  // static final String domain = "http://BamaAPI.ecomgroup.ir/";
  // static final String domain = "http://api.shandiz.ir/";
  // static const String domain = "http://bamoallemapi.eclubgroup.ir/";

  // static String domain = "http://api.etripgroup.com/";
  // static String domain = "https://parssafariapi.eclubgroup.ir/";
  static String domain = "https://testapi.ep7.ir/";
  // static String newDomain = "https://api.etripgroup.com/";
  static String newDomain = "http://testapi.ep7.ir";
  // static const String newDomain = 'https://bamoallemapi.eclubgroup.ir/';

  // static String domain = "https://api.eclubgroup.ir/";

  // static String domain = 'https://aloapi.eclubgroup.ir/';

  // static String domain = 'https://hashtbitApi.eclubgroup.ir/';

  // static String domain = 'http://192.168.3.50:91/';
  static String baseUrl = '${domain}ClubAPI/';
}

@protected
String? token = 'BB8B866E-913C-4F9F-A70B-82348AF7BA6D';
Dio _dio = Dio(
  BaseOptions(
    receiveDataWhenStatusError: true,
    baseUrl: ApiConnection.baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  ),
);

String apiToken = r'ClU8$5^7*9QAZ123wsxn22df2UJMik{=$,11yhn2#$F22UJMik,OL>p;/';
Map<String, String> apiHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authentication': '{"PrivateKey": "$apiToken" }',
};

Future<Dio> getApiConnection() async {
  _dio.interceptors.clear();
  _dio.options.baseUrl = ApiConnection.baseUrl;

  _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, requestHeader: true));

  _dio.interceptors.add(
    QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll(apiHeaders);
        if (token != null && token!.isNotEmpty) {
          options.headers['Authorization'] = '{"Token":"$token"}';

          log(options.headers['Authorization']);
        }
        handler.next(options);
      },
      onResponse: (Response response, handler) {
        handler.next(response);
      },
      onError: (error, handler) async {
        // if (navigatorKey.currentState?.canPop() ?? false) {
        //   navigatorKey.currentState!.pop();
        // }
        // // showLoading(navigatorKey.currentState!.context);
        // AlertClass.globalAlert(
        //   navigatorKey.currentState!.context,
        //   error.message,
        //   buttonTitle: 'تلاش مجدد',
        //   function: () async => await _dio.fetch(error.requestOptions).then(
        //     (r) => handler.resolve(r),
        //     onError: (e) {
        //       log(e.toString());
        //       handler.reject(e);
        //     },
        //   ),
        //
        //   //
        //   // },
        // );
        //
        // // log('تایم اوت');
        //
        // // log('خطا${error.error.type}');
        // // log('خطا2${error.error}');
        //
        // if (error.error is SocketException) {
        //   log('error connection ====> ${error.message}');
        // } else if (error.error is HandshakeException) {
        //   // ApiConnection.domain = newDomain;
        //   ApiConnection.baseUrl = '${ApiConnection.newDomain}ClubAPI/';
        //   error.requestOptions.baseUrl = ApiConnection.baseUrl;
        //   handler.resolve(await _dio.fetch(error.requestOptions));
        // } else {
        //   handler.next(error);
        // }

        // if (error.error.type == 'SocketException') {
        //   log('خطا${error.error.type}');
        //   log('خطا2${error.error}');
        // }
        // if (error.error.type == 'HandshakeException') {
        //   final RequestOptions options = error.requestOptions;
        //   // _dio.lock();
        //   // _dio.interceptors.responseLock.lock();

        //   // _dio.interceptors.errorLock.lock();
        //   ApiConnection.domain = 'http://bamoallemapi.eclubgroup.ir/';
        //   ApiConnection.baseUrl = '${ApiConnection.domain}ClubAPI/';
        //   options.baseUrl = ApiConnection.baseUrl;
        //   // _dio.unlock();
        //   // _dio.interceptors.responseLock.unlock();
        //   // _dio.interceptors.errorLock.unlock();
        //   _dio.fetch(options).then(
        //     (r) => handler.resolve(r),
        //     onError: (e) {
        //       log(e.toString());
        //       handler.reject(e);
        //     },
        //   );
        //   return;
        // }

        log('error connection ===== > ${error.message}');

        // handler.next(error);
      },
    ),
  );
  return _dio;
}
