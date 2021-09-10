import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/cubits/data_state.dart';

import 'movie_item_model.dart';

class MovieItemProvider extends ChangeNotifier {
  bool isMovie;
  int id;
  MovieItemModel item;
  DataState _state = DataInitial();
  bool isFavorite = false;
  bool isHidden = false;

  MovieItemProvider({
    this.isMovie = true,
    this.id,
    this.item,
  }) {
    if (item != null) {
      id = item.id;
      isMovie = item.isMovie;
      state = DataLoaded();
    } else {
      init();
    }
  }

  DataState get state => _state;

  set state(DataState value) {
    if (value == _state) return;
    if (value is DataLoaded) {
      initFavoriteState();
      initVisibilityState();
    }
    _state = value;
    notifyListeners();
  }

  void initFavoriteState() {
    isFavorite = [
      ...storage.favoriteMoviesBox.values,
      ...storage.favoriteTvSeriesBox.values,
    ].contains(id);
  }

  void initVisibilityState() {
    isHidden = storage.hiddenMoviesBox.values.contains(id);
  }

  bool get showInResults {
    return item.showInResults && !isHidden;
  }

  void init() async {
    if (state is DataLoading) return;
    if (isMovie) {
      getMovie();
    } else {
      getTv();
    }
  }

  void getMovie() async {
    try {
      final res = await apiClient.getMovie(this.id);
      if (res is ApiSuccessResponse) {
        item = MovieItemModel.fromJson(res.body);
        state = DataLoaded();
      } else {
        _onError();
      }
    } catch (e) {
      _onError();
    }
  }

  void getTv() async {
    try {
      final res = await apiClient.getTv(this.id);
      if (res is ApiSuccessResponse) {
        item = MovieItemModel.fromJson(res.body);
        state = DataLoaded();
      } else {
        _onError();
      }
    } catch (e) {
      _onError();
    }
  }

  void toggleFavorite() {
    final favorites = storage.favoriteMoviesBox.values;
    if (favorites.contains(id)) {
      removeFavorite(id);
    } else {
      addFavorite(id);
    }
    initFavoriteState();
    notifyListeners();
  }

  void toggleVisibility() {
    final items = storage.hiddenMoviesBox.values;
    if (items.contains(id)) {
      show(id);
    } else {
      hide(id);
    }
    initVisibilityState();
    notifyListeners();
  }

  void _onError([String message]) {
    print(message);
    state = DataFailed(message);
  }

  void removeFavorite(int id) {
    if (isMovie) {
      final idx = storage.favoriteMoviesBox.values.asList().indexOf(id);
      if (idx != -1) {
        storage.favoriteMoviesBox.deleteAt(idx);
      } else {
        final idx = storage.favoriteTvSeriesBox.values.asList().indexOf(id);
        if (idx != -1) {
          storage.favoriteTvSeriesBox.deleteAt(idx);
        }
      }
    }
  }

  void addFavorite(int id) {
    if (isMovie) {
      storage.favoriteMoviesBox.add(id);
    } else {
      storage.favoriteTvSeriesBox.add(id);
    }
  }

  void show(int id) {
    final idx = storage.hiddenMoviesBox.values.asList().indexOf(id);
    if (idx != -1) {
      storage.hiddenMoviesBox.deleteAt(idx);
    }
  }

  void hide(int id) {
    storage.hiddenMoviesBox.add(id);
  }
}
