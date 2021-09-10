import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/results/core/movie_item_provider.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  bool _dirty = false;

  HomePageCubit() : super(HomePageStateInitial()) {
    init();
  }

  void init() {
    final List<MovieItemProvider> items = [];
    final movies = storage.favoriteMoviesBox.values;
    final tvSeries = storage.favoriteTvSeriesBox.values;

    if (movies.isNotEmpty) {
      items.addAll(movies.map<MovieItemProvider>(
          (id) => MovieItemProvider(id: id, isMovie: true)));
    }

    if (tvSeries.isNotEmpty) {
      items.addAll(tvSeries.map<MovieItemProvider>(
          (id) => MovieItemProvider(id: id, isMovie: false)));
    }

    if (items.isEmpty) {
      emit(HomePageStateInitial());
    } else {
      emit(HomePageStateLoaded(items));
    }
  }

  void markAsDirty() {
    _dirty = true;
  }

  void initIfDirty() {
    print('initIfDirty');
    if (_dirty) {
      _dirty = false;
      init();
    }
  }
}
