import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/widgets/layouts.dart';
import 'package:shimmer/shimmer.dart';

class ResultsPageGridShimmer extends StatelessWidget {
  const ResultsPageGridShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableGrid(
          crossAxisCount: 2,
          mainAxisSpacing: 7.w,
          crossAxisSpacing: 8.w,
          children: [
            ...6.asList(builder: (i) {
              return AnimationConfiguration.staggeredList(
                position: i,
                duration: const Duration(milliseconds: 250),
                child: SlideAnimation(
                  verticalOffset: 100,
                  child: FadeInAnimation(
                    child: const ResultsPageGridShimmerItem(),
                  ),
                ),
              );
            })
          ],
        ),
      ],
    );
  }
}

class ResultsPageGridShimmerItem extends StatelessWidget {
  const ResultsPageGridShimmerItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      width: 164.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        color: theme.backgroundColor,
      ),
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerShimmerWidget(
            height: 148.w,
            width: 164.w,
            radius: 8.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 11.w, bottom: 16.w),
            child: ContainerShimmerWidget(
              height: 10.w,
              width: 63.w,
              radius: 4.w,
            ),
          ),
          ContainerShimmerWidget(
            height: 12.w,
            width: 89.w,
            radius: 4.w,
          ),
          SizedBox(height: 4.w),
          ContainerShimmerWidget(
            height: 12.w,
            width: 127.w,
            radius: 4.w,
          ),
          SizedBox(height: 17.w),
          ContainerShimmerWidget(
            height: 14.w,
            width: 58.w,
            radius: 4.w,
          ),
        ],
      ),
    );
  }
}

class ContainerShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final bool isDarker;

  ContainerShimmerWidget({
    this.height,
    this.width,
    this.radius,
    this.isDarker = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.w),
      ),
      child: Shimmer.fromColors(
        period: Duration(seconds: 1),
        baseColor: theme.scaffoldBackgroundColor,
        highlightColor: theme.backgroundColor,
        child: Container(color: theme.backgroundColor),
      ),
    );
  }
}
