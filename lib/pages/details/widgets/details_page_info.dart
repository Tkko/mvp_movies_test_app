import 'package:flutter_svg/svg.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/results/core/movie_item_model.dart';
import 'package:mvp_movies/widgets/layouts.dart';

class DetailsPageInfo extends StatelessWidget {
  final MovieItemModel item;

  DetailsPageInfo(this.item);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Positioned(
      bottom: 0,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 230.w,
          maxHeight: 500.w,
        ),
        width: 375.w,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.w),
          ),
        ),
        child: SeparatedColumn(
          separator: SizedBox(height: 10.w),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              maxLines: 1,
              style: theme.textTheme.headline6,
            ),
            Row(
              children: [
                SvgPicture.asset('star'.svg, width: 13.w),
                SizedBox(width: 5.w),
                Text(
                  item.rating,
                  style: theme.textTheme.bodyText1,
                ),
              ],
            ),
            Text(
              item.description,
              style: theme.textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
