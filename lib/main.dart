import 'package:flutter/material.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/app/core/api_client/api_client.dart';
import 'package:mvp_movies/app/core/local_storage/local_storage.dart';
import 'package:mvp_movies/app/view/app_helper_widgets.dart';
import 'package:mvp_movies/app/view/app_view.dart';
import 'package:mvp_movies/pages/home/cubit/home_page_cubit.dart';
import 'package:mvp_movies/pages/search/recent_searches/core/recent_searches_cubit.dart';

void main() async {
  Future<bool> registerLocalSingletons() async {
    try {
      final storage = LocalStorage();
      await storage.init();
      locator.registerSingleton<LocalStorage>(storage);
      locator.registerSingleton<ApiClient>(ApiClient());
      return true;
    } catch (e) {
      dd('registerLocalSingletons $e');
      return false;
    }
  }

  Future<bool> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await registerLocalSingletons();
    return true;
  }

  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final recentSearches = RecentSearchesCubit();
  final homePageCubit = HomePageCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: recentSearches),
        BlocProvider.value(value: homePageCubit),
      ],
      child: InitScreenUtils(child: AppView()),
    );
  }
}
