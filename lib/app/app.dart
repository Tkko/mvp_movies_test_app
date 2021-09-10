import 'package:get_it/get_it.dart';
import 'package:mvp_movies/app/core/api_client/api_client.dart';
import 'package:mvp_movies/app/core/local_storage/local_storage.dart';
export 'package:bloc/bloc.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:provider/provider.dart';
export 'package:mvp_movies/app/styles/app_themes.dart';
export 'package:mvp_movies/app/view/app_helper_widgets.dart';
export 'package:mvp_movies/app/extensions.dart';
export 'package:mvp_movies/app/core/http_request_handler/http_request_handler.dart';

GetIt locator = GetIt.instance;

ApiClient get apiClient => locator<ApiClient>();

LocalStorage get storage => locator<LocalStorage>();

/// Print for debugging
void dd(d) {
  if (true) print(d);
}
