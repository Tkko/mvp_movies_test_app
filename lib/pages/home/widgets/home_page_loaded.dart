import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/cubits/data_state.dart';
import 'package:mvp_movies/pages/results/core/movie_item_provider.dart';
import 'package:mvp_movies/pages/results/widgets/results_shimmers.dart';
import 'package:mvp_movies/pages/results/widgets/results_grid_item.dart';

class HomePageLoaded extends StatelessWidget {
  final List<MovieItemProvider> items;

  HomePageLoaded(this.items);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(16.w),
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 10.w,
      crossAxisCount: 2,
      childAspectRatio: .51,
      children: items.map((itemProvider) {
        return ChangeNotifierProvider.value(
          value: itemProvider,
          child: HomePageMovieItem(itemProvider),
        );
      }).asList(),
    );
  }
}

class HomePageMovieItem extends StatelessWidget {
  final MovieItemProvider itemProvider;

  HomePageMovieItem(this.itemProvider);

  @override
  Widget build(BuildContext context) {
    final state = context.select((MovieItemProvider p) => p.state);
    if (state is DataLoaded) {
      return ChangeNotifierProvider.value(
        value: itemProvider,
        child: ResultsGridItem(itemProvider.item),
      );
    }
    return ResultsPageGridShimmerItem();
  }
}
