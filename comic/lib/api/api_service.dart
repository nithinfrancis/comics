import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:comic/utils/app_errors.dart';
import 'package:comic/utils/logger.dart';
import 'package:dio/dio.dart';

class Environment {
  static const String production = "https://xkcd.com/";
}

class APIService {
  Dio dio = Dio(BaseOptions(
    baseUrl: Environment.production,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    receiveDataWhenStatusError: true,
  ));

  APIService() {
    // ignore: unnecessary_null_comparison
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: Environment.production,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        receiveDataWhenStatusError: true,
      );
      dio = Dio(options);
    }
  }

  Future<ParsedResponse> get(String path,{Map<String, dynamic>? headers, Map<String, dynamic>? params, String? contentType}) async {

    Logger.log("URL : $path \nHeaders : $headers queryParameters : $params");

    return dio.get(path,
        queryParameters: params,
        options: Options(headers: headers, responseType: ResponseType.plain, contentType: contentType ?? "application/json"))
        .then((Response response) {
      final String? res = response.data;
      final int? code = response.statusCode;
      Logger.log("Status code for " + path + "::: " + code.toString());

      if (res == null || res.isEmpty) {
        throw AppError.internalError;
      } else {
        return ParsedResponse(code!, res);
      }
    }).catchError((Object e) {
      if (e is DioError) {
        handleDioException(e);
      } else {
        throw e;
      }
    });
  }

  Future<ParsedResponse> post(String path,
      {Map<String, dynamic>? headers,
        body,
        Map<String, dynamic>? params,
        encoding,
        bool needAuthentication = false,
        String? contentType}) async {

    return dio.post(path,
        data: body,
        queryParameters: params,
        options: Options(headers: headers, responseType: ResponseType.plain, contentType: contentType ?? "application/json"))
        .then((Response response) {
      final String? res = response.data;
      final int? code = response.statusCode;
      Logger.log("response status code ${response.statusCode}");
      Logger.log("Status code for " + path + "::: " + code.toString());

      if (res == null || res.isEmpty) {
        throw AppError.internalError;
      } else {
        return ParsedResponse(code!, res);
      }
    }).catchError((Object e) {
      if (e is DioError) {
        handleDioException(e);
      } else {
        throw e;
      }
    });
  }

  Future<ParsedResponse> put(String path,
      {Map<String, dynamic>? headers,
        body,
        Map<String, dynamic>? params,
        encoding,
        String? contentType}) async {

    return dio.put(path,
        data: body,
        queryParameters: params,
        options: Options(headers: headers, responseType: ResponseType.plain, contentType: contentType ?? "application/json"))
        .then((Response response) {
      final String? res = response.data;
      final int? code = response.statusCode;
      Logger.log("response status code ${response.statusCode}");
      Logger.log("Status code for " + path + "::: " + code.toString());

      if (res == null || res.isEmpty) {
        throw AppError.internalError;
      } else {
        return ParsedResponse(code!, res);
      }
    }).catchError((Object e) {
      if (e is DioError) {
        handleDioException(e);
      } else {
        throw e;
      }
    });
  }

}

class ParsedResponse {
  int code;
  String response;

  ParsedResponse(this.code, this.response);

  bool isOk() {
    return code == 200;
  }

  @override
  String toString() {
    return 'ParsedResponse{code : $code, response : " $response "}';
  }
}

///All error handling should be done in this method
void handleDioException(exception) {
  if (exception is DioError) {
    if (exception.type == DioErrorType.response) {
      if (null != exception.response) {
        dynamic json = jsonDecode(exception.response!.data);
        if (null != json) {
          throw AppError(
              errorCode: json["status"] ?? 0, message: json["message"] ?? json["error_description"] ?? "Something went wrong");
        }
      }
    } else if (exception.type == DioErrorType.other) {
      if (exception.error is SocketException) {
        throw AppError.noInternet;
      }
    } else if (exception.type == DioErrorType.connectTimeout || exception.type == DioErrorType.receiveTimeout) {
      throw AppError.noInternet;
    }
    throw exception;
  } else {
    throw exception;
  }
}
