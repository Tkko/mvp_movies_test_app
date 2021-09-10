import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/details/widgets/derails_page_widgets.dart';
import 'package:mvp_movies/pages/details/widgets/details_page_info.dart';
import 'package:mvp_movies/pages/results/core/movie_item_model.dart';

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
