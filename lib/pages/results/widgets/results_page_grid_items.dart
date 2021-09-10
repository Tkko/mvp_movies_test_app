import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/results/core/movie_item_provider.dart';
import 'package:mvp_movies/pages/results/widgets/results_shimmers.dart';
import 'package:mvp_movies/pages/results/widgets/results_grid_item.dart';

class ResultsPageGridItems extends StatelessWidget {
  final PagingController<int, MovieItemProvider> controller;

  ResultsPageGridItems({this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 100.w),
      sliver: PagedSliverGrid<int, MovieItemProvider>(
        pagingController: controller,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
          crossAxisCount: 2,
          childAspectRatio: .51,
        ),
        builderDelegate: PagedChildBuilderDelegate<MovieItemProvider>(
          itemBuilder: (_, itemProvider, ___) => ChangeNotifierProvider.value(
            value: itemProvider,
            child: ResultsGridItem(itemProvider.item),
          ),
          firstPageProgressIndicatorBuilder: (_) =>
              const ResultsPageGridShimmer(),
          newPageProgressIndicatorBuilder: (_) =>
              const ResultsPageGridShimmerItem(),
          newPageErrorIndicatorBuilder: (_) => const ResultsNotFound(),
          noItemsFoundIndicatorBuilder: (_) => const ResultsNotFound(),
        ),
      ),
    );
  }
}

class ResultsNotFound extends StatelessWidget {
  const ResultsNotFound();

  @override
  Widget build(BuildContext context) {
    return Text('Not found');
  }
}
