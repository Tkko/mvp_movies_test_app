import 'dart:convert';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/suggestions/cubit/suggestions_bloc.dart';

import 'movie_item_model.dart';
import 'movie_item_provider.dart';

class SearchParams {
  final String keyword;
  int page = 1;
  int totalCount = 0;

  SearchParams({this.page = 1, this.keyword});

  final controller = PagingController<int, MovieItemProvider>(firstPageKey: 1);

  factory SearchParams.fromJson(Map<String, dynamic> json) {
    return SearchParams();
  }

  factory SearchParams.fromSuggestion(SuggestionModel item) {
    return SearchParams(
      keyword: item.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'query': keyword,
      'include_adult': true,
    };
  }

  String get searchFieldTitle =>
      (keyword?.isNotEmpty ?? false) ? keyword : 'Search';

  void getItems(final int page) async {
    try {
      this.page = page;
      print(jsonEncode(toJson()));
      final res = await apiClient.multiSearch(this.toJson());
      if (!controller.hasListeners) return;
      if (res is ApiSuccessResponse) {
        totalCount = res.body.i('total_results');
        final displayedItemsCount = (controller.itemList?.length ?? 0);
        final hasNewItems = displayedItemsCount < totalCount;
        final newItems = hasNewItems
            ? res.data
                .map<MovieItemProvider>((e) {
                  return MovieItemProvider(
                    item: MovieItemModel.fromJson(e),
                  );
                })
                .asList()
                .where((item) => (item as MovieItemProvider).showInResults)
                .asList()
            : <MovieItemProvider>[];

        final fetchedCount = newItems.length + displayedItemsCount;

        if (totalCount <= fetchedCount || newItems.isEmpty) {
          controller.appendLastPage(newItems);
        } else {
          controller.appendPage(newItems, controller.nextPageKey + 1);
        }
      } else {
        setError('res.message');
      }
    } catch (e) {
      setError('$e');
    }
  }

  void setError(String message) {
    try {
      print('SearchResultsCubit getItems $message');
      if (controller.hasListeners) {
        controller.error = message;
      }
    } catch (e) {
      print('setError $e');
    }
  }

  /// 🛁🛁 dispose controller after results page is no longer visible 🛁🛁
  void clear() {
    controller.dispose();
  }

  /// refresh [ResultsPage]
  void refresh() {
    controller.refresh();
  }
}
