import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/app/core/api_client/api_constants.dart';
import 'package:mvp_movies/app/core/http_request_handler/http_request_handler.dart';

@immutable
abstract class Repo {
  HttpRequestHandler get httpRequestHandler =>
      locator<ApiClient>().httpRequestHandler;
}

class ApiClient {
  final httpRequestHandler = HttpRequestHandler(
    host: ENVIRONMENT.API_URL,
    apiKey: ENVIRONMENT.API_KEY,
  );

  Stream<ApiResponse> get responseStream => httpRequestHandler.responseStream;

  Future<ApiResponse> keywords(Map<String, dynamic> params) =>
      httpRequestHandler.invokeAPI(
        path: ENVIRONMENT.SEARCH_CONTROLLER,
        method: ENVIRONMENT.SEARCH_KEYWORDS,
        queryParams: params,
      );

  Future<ApiResponse> multiSearch(Map<String, dynamic> params) =>
      httpRequestHandler.invokeAPI(
        path: ENVIRONMENT.SEARCH_CONTROLLER,
        method: ENVIRONMENT.MULTI_SEARCH,
        queryParams: params,
      );

  Future<ApiResponse> getMovie(int id) => httpRequestHandler.invokeAPI(
        path: ENVIRONMENT.MOVIE_CONTROLLER + '/$id',
      );

  Future<ApiResponse> getTv(int id) => httpRequestHandler.invokeAPI(
        path: ENVIRONMENT.TV_CONTROLLER + '/$id',
      );
}
