part of 'recent_searches_cubit.dart';

@immutable
class RecentSearchesState {
  final List<String> recentSearches;
  final List<SearchParams> savedSearches;
  final DataState dataState;

  bool get isEmpty => recentSearches.isEmpty && savedSearches.isEmpty;

  bool get isNotEmpty => !isEmpty;

  bool get hasRecentSearches => recentSearches.isNotEmpty;

  bool get hasSavedSearches => savedSearches.isNotEmpty;

  RecentSearchesState({
    this.recentSearches = const [],
    this.savedSearches = const [],
    this.dataState = const DataInitial(),
  });

  RecentSearchesState copyWith({
    List<String> recentSearches,
    List<SearchParams> savedSearches,
    DataState dataState,
  }) {
    return RecentSearchesState(
      recentSearches: recentSearches ?? this.recentSearches,
      savedSearches: savedSearches ?? this.savedSearches,
      dataState: dataState ?? this.dataState,
    );
  }

  RecentSearchesState addRecent(String item) {
    return this.copyWith(
      recentSearches: [item, ...this.recentSearches],
      dataState: DataLoaded(),
    );
  }

  RecentSearchesState clearRecentKeywords() => this.copyWith(
        recentSearches: [],
        dataState: savedSearches.isNotEmpty ? DataLoaded() : DataInitial(),
      );
}

class SavedSearch {
  SavedSearch({
    this.id,
    this.userId,
    this.searchKey,
    this.searchParams,
    this.createDate,
    this.subscription,
  });

  final SearchParams searchParams;
  final int id;
  final int userId;
  final String searchKey;
  final DateTime createDate;
  final subscription;

  factory SavedSearch.fromJson(Map<String, dynamic> json) => SavedSearch(
        id: json.i('id'),
        userId: json.i('user_id'),
        searchKey: json.s('search_key'),
        searchParams: SearchParams.fromJson(json['search_params']),
        createDate: json.dt('create_date'),
        subscription: json["subscription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "search_key": searchKey,
        "create_date": createDate.toIso8601String(),
        "subscription": subscription,
      };
}
