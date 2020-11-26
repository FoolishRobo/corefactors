import 'dart:convert';

import 'package:corefactors/models/users_list.dart';
import 'package:dio/dio.dart';

Future getHttpsServiceFuture(String requestUrl, responseSerializer,
    {Map<String, dynamic> queryParams}) async {
  Dio http = Dio();
  Response httpResponse;

  try {
    print("url = ${requestUrl + "?" + queryParams.toString()}");
    httpResponse = await http.get(requestUrl, queryParameters: queryParams);
  } on DioError catch (error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return null;
      case DioErrorType.RECEIVE_TIMEOUT:
        return null;
      case DioErrorType.SEND_TIMEOUT:
        return null;
      case DioErrorType.CANCEL:
        return null;
      case DioErrorType.DEFAULT:
        return null;
      case DioErrorType.RESPONSE:
        return null;
    }
    // TODO: log error

  }

  if (httpResponse.statusCode < 300 && httpResponse.statusCode >= 200) {
    List<Users> responseBody=[];
    httpResponse.data.map((j) => responseBody.add(responseSerializer(j))).toList();
    return responseBody;
  } else {
    return httpResponse.data;
  }
}
