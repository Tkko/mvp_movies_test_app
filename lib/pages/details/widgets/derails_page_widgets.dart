import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/results/core/movie_item_model.dart';
import 'package:mvp_movies/widgets/buttons.dart';
import 'package:mvp_movies/widgets/my_network_image.dart';

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
