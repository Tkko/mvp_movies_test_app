import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/details/details_page.dart';
import 'package:mvp_movies/pages/home/cubit/home_page_cubit.dart';
import 'package:mvp_movies/pages/results/core/movie_item_model.dart';
import 'package:mvp_movies/pages/results/core/movie_item_provider.dart';
import 'package:mvp_movies/widgets/buttons.dart';
import 'package:mvp_movies/widgets/layouts.dart';
import 'package:mvp_movies/widgets/my_network_image.dart';

class ResultsGridItem extends StatelessWidget {
  final MovieItemModel item;

  ResultsGridItem(this.item);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      onTap: () => context.push(DetailsPage(item)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.w),
          color: theme.backgroundColor,
        ),
        padding: EdgeInsets.all(2.w),
        child: Stack(
          children: [
            Column(
              children: [
                Hero(
                  tag: item.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4.w),
                    ),
                    child: MyNetworkImage(
                      imageUrl: item.cover,
                      width: 160.w,
                      height: 213.w,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SeparatedColumn(
                    separator: SizedBox(height: 8.w),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.w),
                      Row(
                        children: [
                          SvgPicture.asset('star'.svg),
                          SizedBox(width: 3.w),
                          Text(
                            item.rating,
                            style: theme.textTheme.bodyText2,
                          ),
                        ],
                      ),
                      Text(
                        item.title,
                        maxLines: 1,
                        style: theme.textTheme.headline6.copyWith(fontSize: 16),
                      ),
                      Text(
                        item.description,
                        maxLines: 2,
                        style: theme.textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const MovieItemActionButtons(),
          ],
        ),
      ),
    );
  }
}

class MovieItemActionButtons extends StatelessWidget {
  const MovieItemActionButtons();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Positioned(
      left: 90.w,
      top: 200.w,
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Selector<MovieItemProvider, bool>(
            selector: (_, p) => p.isHidden,
            builder: (_, isHidden, __) {
              return SvgButton(
                backgroundColor: isHidden
                    ? theme.accentColor
                    : theme.primaryColorLight.withOpacity(.6),
                svg: 'eye',
                padding: 5.w,
                svgWidth: 16.w,
                onTap: () {
                  context.read<MovieItemProvider>().toggleVisibility();
                },
              );
            },
          ),
          SizedBox(width: 8.w),
          Selector<MovieItemProvider, bool>(
            selector: (_, p) => p.isFavorite,
            builder: (_, isFavorite, __) {
              return SvgButton(
                backgroundColor: isFavorite
                    ? theme.accentColor
                    : theme.primaryColorLight.withOpacity(.6),
                svg: 'heart',
                padding: 5.w,
                svgWidth: 16.w,
                onTap: () {
                  context.read<MovieItemProvider>().toggleFavorite();
                  context.read<HomePageCubit>().markAsDirty();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
