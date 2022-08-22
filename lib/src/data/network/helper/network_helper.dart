import 'dart:convert';

import 'package:app/res/R.dart';
import 'package:app/src/utils/logger.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class NetworkHelper {
  static Future<bool> isNetworkConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static getNetworkErrorMessage(error) async {
    logger.e("******************************** NETWORK EXCEPTION ********************************");
    // print("* Exception: " + error?.toString());
    logger.e("***********************************************************************************");
    String errorMessage = R.string.error_no_network_connection;
    if (error != null && error is DioError) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          errorMessage = R.string.error_no_network_connection;
          break;
        case DioErrorType.response:
          errorMessage = _parseResponseError(error);
          break;
        default:
          errorMessage = R.string.error_connect_to_server;
          break;
      }
    }
    return errorMessage;
  }

  static _parseResponseError(error) {
    try {
      return error.response.data['message'] as String;
    } catch (e) {
      try {
        Map<String, dynamic> map = jsonDecode(error.response.data);
        return map['message'] as String;
      } catch (e) {
        return R.string.error_connect_to_server;
      }
    }
  }

  static getNetworkErrorCode(error) async {
    String? errorCode;
    if (error != null && error is DioError) {
      switch (error.type) {
        case DioErrorType.response:
          errorCode = _parseResponseCodeError(error);
          break;
        default:
          break;
      }
    }
    return errorCode;
  }

  static _parseResponseCodeError(error) {
    try {
      return error.response.data['code'] as String;
    } catch (e) {
      try {
        Map<String, dynamic> map = jsonDecode(error.response.data);
        return map['code'] as String;
      } catch (e) {
        return null;
      }
    }
  }
}
