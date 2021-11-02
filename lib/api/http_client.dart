import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather/api/api_url.dart';
import 'package:weather/view/widgets/snackbar.dart';

class HttpClient {
  int timeOut; // response time in seconds
  HttpClient({this.timeOut = 20});

  Future<dynamic>? fetchData(String url,
      {dynamic modelConverter, Map<String, String>? params}) async {
    String uri = ApiUrl.baseUrl +
        url +
        ((params != null) ? queryParameters(params) : "");
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(uri), headers: {}).timeout(Duration(seconds: timeOut));
      ///convert from json to model
      final json = _returnResponse(response);
      responseJson = modelConverter != null ? modelConverter(json) : json;
    } on SocketException {
      SnackbarMessage.getSnackbarMessage("No internet connection");
      // throw const SocketException("No internet connection");
    } on TimeoutException {
      SnackbarMessage.getSnackbarMessage("Time out, try again");
      // throw TimeoutException("Time out");
    } catch (e) {
      SnackbarMessage.getSnackbarMessage("Please try again");
      log("General Error: $e");
    }
    return responseJson;
  }

  String queryParameters(Map<String, String> params) {
    final jsonString = Uri(queryParameters: params);
    return '?${jsonString.query}';
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = json.decode(response.body);

          return responseJson;
        }
      case 401:
        {
          SnackbarMessage.getSnackbarMessage("Please try again later");

          return null;
        }

      case 500:
        {
          SnackbarMessage.getSnackbarMessage("Please try again later");
          log('Error from server');
          return null;
        }
      default:
        {
          SnackbarMessage.getSnackbarMessage("Please try again later");
          log('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
          return null;
          //throw FetchDataException(
          //  'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
    }
  }
}
