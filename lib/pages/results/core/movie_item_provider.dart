import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/cubits/data_state.dart';

import 'movie_item_model.dart';

class MovieItemProvider extends ChangeNotifier {
  bool isMovie;
  int id;
  MovieItemModel item;
  DataState _state = DataInitial();
  bool _favoritesLoading = false;
  bool _visibilityLoading = false;
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

  List<int> get _favorites => [
        ...storage.favoriteMoviesBox.values,
        ...storage.favoriteTvSeriesBox.values,
      ];

  void initFavoriteState() {
    isFavorite = _favorites.contains(id);
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

  void toggleFavorite() async {
    if (_favoritesLoading) return;
    _favoritesLoading = true;
    if (_favorites.contains(id)) {
      await removeFavorite(id);
    } else {
      await addFavorite(id);
    }
    _favoritesLoading = false;
    initFavoriteState();
    notifyListeners();
  }

  void toggleVisibility() async {
    if (_visibilityLoading) return;
    final items = storage.hiddenMoviesBox.values;
    _visibilityLoading = true;
    if (items.contains(id)) {
      await show(id);
    } else {
      await hide(id);
    }
    _visibilityLoading = false;
    initVisibilityState();
    notifyListeners();
  }

  void _onError([String message]) {
    print(message);
    state = DataFailed(message);
  }

  Future<void> removeFavorite(int id) {
    if (isMovie) {
      final idx = storage.favoriteMoviesBox.values.asList().indexOf(id);
      if (idx != -1) {
        return storage.favoriteMoviesBox.deleteAt(idx);
      }
    } else {
      final idx = storage.favoriteTvSeriesBox.values.asList().indexOf(id);
      if (idx != -1) {
        return storage.favoriteTvSeriesBox.deleteAt(idx);
      }
    }
    return null;
  }

  Future<int> addFavorite(int id) {
    if (isMovie) {
      return storage.favoriteMoviesBox.add(id);
    } else {
      return storage.favoriteTvSeriesBox.add(id);
    }
  }

  Future<void> show(int id) {
    final idx = storage.hiddenMoviesBox.values.asList().indexOf(id);
    if (idx != -1) {
      return storage.hiddenMoviesBox.deleteAt(idx);
    }
    return null;
  }

  Future<int> hide(int id) {
    return storage.hiddenMoviesBox.add(id);
  }
}
