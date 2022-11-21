import 'dart:io';

import 'package:app/interceptors/logger_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class Http extends DioForNative {
  Http(String baseUrl)
      : super(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: 5000,
            receiveTimeout: 3000,
            contentType: "application/json",
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
          ),
        ) {
    interceptors.add(LoggerInterceptor());
  }
}
