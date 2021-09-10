part of http_request_handler;

abstract class ApiResponse {
  final Response response;
  final exception;

  ApiResponse({
    this.response,
    this.exception,
  });
}

class ApiSuccessResponse extends ApiResponse {
  List data;
  Map<String, dynamic> body;

  ApiSuccessResponse(Response response) : super(response: response) {
    parseResponse();
  }

  void parseResponse() {
    body = jsonDecode(response.body);
    data = body['results'];
  }
}

class ApiFailureResponse extends ApiResponse {
  String get message => 'Error occurred with code ${response.statusCode}';

  ApiFailureResponse({exception, String url, Response response})
      : super(response: response, exception: exception);
}
