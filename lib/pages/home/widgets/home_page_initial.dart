import 'dart:ui';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/home/cubit/home_page_cubit.dart';
import 'package:mvp_movies/pages/search/pages/search_page.dart';
import 'package:dismissible_page/dismissible_page.dart';

class HomePageInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add the Movies You Love',
            style: theme.textTheme.headline5,
          ),
          SizedBox(height: 20.w),
          Text(
            'This is the page for your favorite movies, start adding ones to fill it up',
            style: theme.textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.w),
          AccentButton(
            title: 'Explore',
            onTap: () => context.pushTransparentRoute(SearchPage()),
          ),
        ],
      ),
    );
  }
}

class AccentButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  AccentButton({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      borderRadius: BorderRadius.circular(12.w),
      onTap: onTap,
      child: Container(
        width: 161.w,
        padding: EdgeInsets.symmetric(vertical: 16.w),
        decoration: BoxDecoration(
          color: theme.accentColor,
          borderRadius: BorderRadius.circular(12.w),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: theme.textTheme.button,
        ),
      ),
    );
  }
}
