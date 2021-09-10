import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Boxes
const kDefaultHiveBox = 'mvp.movies.box';
const kFavoriteMoviesBox = 'mvp.movies.favorite_movies';
const kFavoriteTvSeriesBox = 'mvp.movies.favorite_tvs';
const kRecentSearchesBox = 'mvp.movies.recent_searches';
const kHiddenMoviesBox = 'mvp.movies.hidden';

class LocalStorage {
  Future<bool> init() async {
    try {
      await Hive.initFlutter();
      await Hive.openBox(kDefaultHiveBox);
      await Hive.openBox(kFavoriteMoviesBox);
      await Hive.openBox(kFavoriteTvSeriesBox);
      await Hive.openBox(kRecentSearchesBox);
      await Hive.openBox(kHiddenMoviesBox);
      return true;
    } catch (e) {
      print('LocalStorage init error $e');
      return false;
    }
  }

  Future<void> reset() async {
    await appBox.clear();
    await recentSearchesBox.clear();
    await favoriteMoviesBox.clear();
    await favoriteTvSeriesBox.clear();
    await hiddenMoviesBox.clear();
    return;
  }

  /// Boxes
  Box get appBox => Hive.box(kDefaultHiveBox);

  Box get recentSearchesBox => Hive.box(kRecentSearchesBox);

  Box get favoriteMoviesBox => Hive.box(kFavoriteMoviesBox);

  Box get favoriteTvSeriesBox => Hive.box(kFavoriteTvSeriesBox);

  Box get hiddenMoviesBox => Hive.box(kHiddenMoviesBox);
}
