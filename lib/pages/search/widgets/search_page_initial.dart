import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/search/recent_searches/core/recent_searches_cubit.dart';
import 'package:mvp_movies/pages/search/recent_searches/recent_searches.dart';

class SearchPageInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecentSearchesCubit, RecentSearchesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.isNotEmpty) {
          return RecentSearches(state: state);
        }

        return Padding(
          padding: EdgeInsets.only(top: 150.w),
          child: Text('Start Typing'),
        );
      },
    );
  }
}
