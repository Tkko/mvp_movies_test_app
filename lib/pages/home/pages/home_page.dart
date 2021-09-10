import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/home/cubit/home_page_cubit.dart';
import 'package:mvp_movies/pages/home/widgets/home_page_initial.dart';
import 'package:mvp_movies/pages/home/widgets/home_page_loaded.dart';
import 'package:mvp_movies/pages/search/pages/search_page.dart';
import 'package:mvp_movies/widgets/buttons.dart';
import 'package:dismissible_page/dismissible_page.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is HomePageStateLoaded) {
            return HomePageLoaded(state.items);
          }
          return HomePageInitial();
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    final theme = context.theme;
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      centerTitle: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Padding(
        padding: EdgeInsets.only(left: 28.w),
        child: Text(
          'Fav Movies',
          style: theme.textTheme.headline6,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: SvgButton(
            svg: 'search',
            onTap: () => context.pushTransparentRoute(SearchPage()),
          ),
        ),
      ],
    );
  }
}
