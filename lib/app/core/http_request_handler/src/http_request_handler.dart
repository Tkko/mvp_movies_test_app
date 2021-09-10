part of http_request_handler;

enum HttpMethod { GET, POST, PUT, DELETE, READ }

class HttpRequestHandler {
  String deviceId;

  HttpRequestHandler({this.host, this.apiKey});

  final _responseStreamCtrl = BehaviorSubject<ApiResponse>();

  Stream<ApiResponse> get responseStream => _responseStreamCtrl.stream;

  void _addResponse(ApiResponse res) {
    if (_responseStreamCtrl != null && !_responseStreamCtrl.isClosed)
      _responseStreamCtrl.add(res);
  }

  void dispose() {
    _responseStreamCtrl.close();
  }

  // Base URL of API
  final String host;
  final String apiKey;
  String locale;
  String authToken;

  ///Sets language for API processing. API class does not work if Language is not specified.
  void setLocale(String language) {
    locale = language;
  }

  void setAuth(String token) => authToken = token;

  void removeAuth() => authToken = null;

  String requestURI({String path, String method, String queryParams}) {
    String url = [host, locale, path, method]
        .where((p) => (p != null && p != ''))
        .join('/');

    if (queryParams != null) url += queryParams;
    return url;
  }

  String convertQueryParams(Map<String, dynamic> queryParams) {
    final Map<String, dynamic> defQueryParams = {
      'api_key': this.apiKey,
    };
    if (queryParams != null) {
      defQueryParams.addAll(queryParams);
    }

    String queryString = '';

    queryString = '?' +
        defQueryParams.entries
            .where((p) => p.value != null)
            .map((p) => '${p.key}=${p.value}')
            .join('&');

    return Uri.encodeFull(queryString);
  }

  Future<ApiResponse> invokeAPI({
    HttpMethod httpMethod = HttpMethod.GET,
    String path,
    String method,
    body,
    Map<String, dynamic> queryParams,
    contentType = 'application/json',
  }) async {
    final Map<String, String> headerParams = {'Content-Type': contentType};
    final queryString = convertQueryParams(queryParams);
    final url =
        requestURI(path: path, method: method, queryParams: queryString);

    print('invokeApi Start $httpMethod $url');
    try {
      final res = await retry(
          () {
            switch (httpMethod) {
              case HttpMethod.POST:
                return post(Uri.parse(url), headers: headerParams, body: body);
              case HttpMethod.PUT:
                return put(Uri.parse(url), headers: headerParams, body: body);
              case HttpMethod.DELETE:
                return delete(Uri.parse(url),
                    headers: headerParams, body: body);
              case HttpMethod.READ:
                return read(Uri.parse(url), headers: headerParams);
              default:
                return get(Uri.parse(url), headers: headerParams);
            }
          },
          retryIf: (e) => e is SocketException,
          onRetry: (e) {
            _addResponse(ApiFailureResponse(exception: e));
            print('onRetry  $url');
          });
      final parsedResponse = _parseResponse(res);
      _addResponse(parsedResponse);
      return parsedResponse;
    } catch (e) {
      print('invokeApi End ${e.runtimeType} $e');
      final exc = ApiFailureResponse(
        exception: e,
        url: url,
      );
      _addResponse(exc);
      return exc;
    }
  }

  ApiResponse _parseResponse(Response res) {
    final url = res.request.url.toString();
    try {
      if (res.statusCode == 200) {
        return ApiSuccessResponse(res);
      }
      return ApiFailureResponse(url: url, response: res);
    } catch (e) {
      print('invokeApi _parseResponse  $e');
      return ApiFailureResponse(exception: e, url: url, response: res);
    }
  }
}
