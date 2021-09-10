import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/home/cubit/home_page_cubit.dart';
import 'package:mvp_movies/pages/search/pages/search_page.dart';
import 'package:mvp_movies/pages/results/core/search_params.dart';
import 'package:mvp_movies/pages/search/widgets/search_app_bar.dart';
import 'package:dismissible_page/dismissible_page.dart';

class ResultsPageAppbar extends StatelessWidget {
  final TextEditingController controller;
  final SearchParams searchParams;

  ResultsPageAppbar({this.controller, this.searchParams});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      automaticallyImplyLeading: false,
      collapsedHeight: 58.w,
      titleSpacing: 0,
      title: GestureDetector(
        onTap: () {
          context.pushTransparentRoute(SearchPage());
        },
        child: SearchPageAppBar(
          onBack: () {
            context.read<HomePageCubit>().initIfDirty();
            context.pop();
          },
          controller: controller,
          enabled: false,
          hint: searchParams.searchFieldTitle,
        ),
      ),
    );
  }
}

class StaggeredScaleAnimation extends StatelessWidget {
  final Widget child;
  final int index;

  StaggeredScaleAnimation({this.child, this.index});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 250),
      child: ScaleAnimation(
        child: FadeInAnimation(child: child),
      ),
    );
  }
}
