import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/results/core/movie_item_model.dart';
import 'package:mvp_movies/widgets/buttons.dart';
import 'package:mvp_movies/widgets/layouts.dart';
import 'package:mvp_movies/widgets/my_network_image.dart';

class DetailsPage extends StatelessWidget {
  final MovieItemModel item;

  DetailsPage(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DetailsPageCover(this.item),
          const DetailsPageBackButton(),
          DetailsPageInfo(item),
        ],
      ),
    );
  }
}

class DetailsPageCover extends StatelessWidget {
  final MovieItemModel item;

  DetailsPageCover(this.item);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 200.w,
      child: Hero(
        tag: item.id,
        child: MyNetworkImage(
          imageUrl: item.cover,
        ),
      ),
    );
  }
}

class DetailsPageBackButton extends StatelessWidget {
  const DetailsPageBackButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24.w,
      top: context.topPadding,
      child: SvgButton(
        onTap: context.pop,
        svg: 'arrow_left',
        padding: 8.w,
        backgroundColor: context.theme.primaryColor.withOpacity(.8),
      ),
    );
  }
}

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
