import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/search/widgets/widgets.dart';
import 'package:mvp_movies/widgets/buttons.dart';
import '../../results/core/search_params.dart';
import 'core/recent_searches_cubit.dart';

class RecentSearches extends StatelessWidget {
  final RecentSearchesState state;

  RecentSearches({this.state});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 10.w, bottom: 100.w),
      physics: RangeMaintainingScrollPhysics(),
      children: [
        if (state.hasRecentSearches) ...[
          RecentlySearchedKeywordsHeader(),
          ...state.recentSearches.map((item) {
            return RecentSearchedKeywordItem(item);
          }),
        ]
      ],
    );
  }
}

class RecentSearchedKeywordItem extends StatelessWidget {
  final String item;

  RecentSearchedKeywordItem(this.item);

  @override
  Widget build(BuildContext context) {
    return SearchPageListItemContainer(
      onTap: () => context.searchToResults(SearchParams(keyword: item)),
      onCancel: () {
        context.read<RecentSearchesCubit>().removeRecentSearch(item);
      },
      child: Expanded(
        child: Text(
          item,
          style: context.theme.textTheme.subtitle2,
        ),
      ),
    );
  }
}

class RecentlySearchedKeywordsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    void onClear() {
      context.read<RecentSearchesCubit>().clearResentSearches();
    }

    return SizedBox(
      height: 48.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20.w),
          Text(
            'Recent Searches',
            style: theme.textTheme.subtitle1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          TxtButton(
            onTap: onClear,
            child: Text(
              'Clear all',
              style: theme.textTheme.button.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
    );
  }
}
