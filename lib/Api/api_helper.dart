import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nebulae/Api/my_exception.dart';

class ApiHelper {
  Future<dynamic> getApiData(
      {required String url, Map<String, String>? mHeader}) async {
    try {
      var res = await http.get(Uri.parse(url),
          headers: mHeader ??
              {
                "Authorization":
                    "BqPWVyQC1cmDBDb0HtajPIFOvsQW30rGQC1cwhFgshqPA8XQinkGSINJ",
              });
      return returnDataResponse(res);
    } on SocketException {
      throw FetchDataException(body: "Internet Error");
    }
  }

  Future<dynamic> postApi(
      {required String url,
      Map<String, String>? mHeader,
      Map<String, String>? body}) async {
    //var mData;

    try {
      var res = await http.post(Uri.parse(url),
          body: body,
          headers: mHeader ??
              {
                "Authorization":
                    "BqPWVyQC1cmDBDb0HtajPIFOvsQW30rGQC1cwhFgshqPA8XQinkGSINJ"
              });

      return returnDataResponse(res);
    } on SocketException {
      throw FetchDataException(body: "Internet Error");
    }
  }
}

dynamic returnDataResponse(http.Response res) {
  switch (res.statusCode) {
    case 200:
      var mData = res.body;
      return jsonDecode(mData);
    case 400:
      throw BadRequestException(body: res.body.toString());
    case 401:
    case 403:
    case 407:
      throw UnAuthrisedException(body: res.body.toString());
    case 500:
      throw FetchDataException(body: "Error while communicating to server");
  }
}
