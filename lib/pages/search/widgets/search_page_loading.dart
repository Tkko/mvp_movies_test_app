import 'dart:math';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/search/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

class SearchPageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      children: [
        ...5.asList(builder: (_) {
          final width = (Random().nextDouble() * 300.w).clamp(100, 300);
          return SearchPageListItemContainer(
            child: Container(
              height: 10.w,
              width: width.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Shimmer.fromColors(
                period: Duration(seconds: 1),
                baseColor: theme.scaffoldBackgroundColor,
                highlightColor: theme.backgroundColor,
                child: Container(color: theme.backgroundColor),
              ),
            ),
          );
        }),
      ],
    );
  }
}
