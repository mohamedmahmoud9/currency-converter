import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../error/exceptions.dart';

// ignore: constant_identifier_names
const String API_KEY = 'fca_live_vQGYK1Z8EjR44h8pVjcBRqC3jhgkpKf80sks38nf';

class ApiBaseHelper {
  final String _baseUrl = 'https://api.freecurrencyapi.com/v1/';
  final Dio dio = Dio();
  void dioInit() {
    dio.options.baseUrl = _baseUrl;
    dio.options.headers = headers;
    dio.options.sendTimeout = const Duration(milliseconds: 30000);
    dio.options.connectTimeout = const Duration(milliseconds: 30000);
    dio.options.receiveTimeout = const Duration(milliseconds: 30000);
  }

  ApiBaseHelper();
  Map<String, String> headers = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get({
    required String url,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
        dio.options.headers = headers;
        log(url + token);
      }

      log(url);
      final Response response = await dio.get(url,
          queryParameters: {...queryParameters ?? {}, 'apikey': API_KEY});
      final responseJson = _returnResponse(response);
      log(responseJson.toString());
      return responseJson;
    } on SocketException {
      throw ServerException(message: 'No Internet Connection');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        throw ServerException(message: 'No Internet Connection');
      }

      _returnResponse(e.response);
    }
  }

  dynamic _returnResponse(Response? response) {
    if (response == null) {
      throw ServerException(
        message: 'No Internet Connection',
      );
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw ServerException(
            message: response.data['message'],
            errorMap: response.data['errors']);
      case 422:
        throw ServerException(
            message: response.data['message'],
            errorMap: response.data['errors']);
      case 401:
      case 403:
        throw ServerException(message: response.data);
      case 500:
      default:
        throw ServerException(message: 'Something went wrong!');
    }
  }
}

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, '');
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([message]) : super(message, 'Unauthorized: ');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}
