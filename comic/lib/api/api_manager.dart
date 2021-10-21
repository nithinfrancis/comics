import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:comic/screens/dashboard/dash_board_data_classes.dart';
import 'package:comic/utils/app_errors.dart';
import 'package:comic/utils/logger.dart';
import 'api_service.dart';

class APIManager {
  APIManager();

  APIService apiService = APIService();

  Future<Comic?> getComic({
    required int pageNumber,
  }) async {
    try {
      var headers = <String, String>{};
      headers["Authorization"] = "Basic==";

      ParsedResponse result = await apiService.get(
        "/$pageNumber/info.0.json",
        headers: headers,
      );
      Logger.log("result");
      Logger.log(result.response.toString());
      if (result.isOk()) {
        Comic comic = Comic.fromJson(jsonDecode(result.response));
        return comic;
      } else if (result.response.isNotEmpty) {
        final eventPlusError = AppError.fromJson(json.decode(result.response), result.code);
        if (eventPlusError.message.isNotEmpty) {
          throw eventPlusError;
        } else {
          throw AppError.internalError; /* Will display Something went wrong */
        }
      } else {
        throw AppError.internalError; /* Will display Something went wrong */
      }
    } catch (e) {
      throwProperException(e);
      return null;
    }
  }
}

extension LocalizedMessage on Exception {
  String getMessage() {
    String message = toString();
    if (message.isEmpty) {
      message = "Something went wrong";
    } else if (message.contains("Exception: ")) {
      message = message.replaceFirst("Exception: ", "");
    }
    return message;
  }
}

///All error handling should be done in this method
void throwProperException(exception) {
  if (exception is AppError) {
    ///AppError can be throw
    throw exception;
  } else if (exception is SocketException) {
    throw AppError.noInternet;
  } else if (exception is TimeoutException) {
    throw Exception("Unable to communicate with server at the moment");
  } else if (exception is FormatException) {
    throw Exception("Invalid File Format");
  } else {
    throw exception;
  }
}
