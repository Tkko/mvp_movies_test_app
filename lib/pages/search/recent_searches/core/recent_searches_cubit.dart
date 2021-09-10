import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/cubits/data_state.dart';
import 'package:mvp_movies/pages/results/core/search_params.dart';

part 'recent_searches_state.dart';

class RecentSearchesCubit extends Cubit<RecentSearchesState> {
  RecentSearchesCubit() : super(RecentSearchesState());

  void init() {
    getRecentSearches();
  }

  void clear() {
    storage.recentSearchesBox.clear();
    emit(RecentSearchesState());
  }

  void onSearch(String item) {
    if (item?.isNotEmpty ?? false) {
      if (state.recentSearches.contains(item)) return;
      _removeAfterLimit();
      storage.recentSearchesBox.add(item);
      emit(state.addRecent(item));
    }
  }

  void _removeAfterLimit() {
    if (storage.recentSearchesBox.length >= 150) {
      storage.recentSearchesBox.deleteAt(
        storage.recentSearchesBox.keys.first,
      );
    }
  }

  void clearResentSearches() {
    storage.recentSearchesBox.clear();
    emit(state.clearRecentKeywords());
  }

  void removeRecentSearch(String item) async {
    final newItems = state.recentSearches.where((e) => e != item).asList();
    if (newItems.isEmpty) {
      clearResentSearches();
    } else {
      emit(state.copyWith(recentSearches: newItems));
      final idx = storage.recentSearchesBox.values.asList().indexOf(item);
      if (idx != -1) {
        storage.recentSearchesBox.deleteAt(idx);
      }
    }
  }

  void getRecentSearches() async {
    final items = storage.recentSearchesBox.values;
    emit(state.copyWith(
      recentSearches: items.map<String>((e) => '$e').asList().reversed.asList(),
      dataState: DataLoaded(),
    ));
  }
}
