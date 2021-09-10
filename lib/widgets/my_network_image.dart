import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:shimmer/shimmer.dart';

class MyNetworkImage extends StatelessWidget {
  final String imageUrl;
  final ImageWidgetBuilder imageBuilder;
  final PlaceholderWidgetBuilder placeholder;
  final ProgressIndicatorBuilder progressIndicatorBuilder;
  final LoadingErrorWidgetBuilder errorWidget;
  final Duration placeholderFadeInDuration;
  final Duration fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final double width;
  final double height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final Map<String, String> httpHeaders;
  final bool useOldImageOnUrlChange;
  final Color color;
  final BlendMode colorBlendMode;
  final FilterQuality filterQuality;
  final int memCacheWidth;
  final int memCacheHeight;
  final double radius;
  final bool cacheEnabled;
  final bool zoomEnabled;
  final ValueChanged<Uint8List> onBytesLoaded;

  MyNetworkImage({
    @required this.imageUrl,
    this.httpHeaders,
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.useOldImageOnUrlChange = false,
    this.color,
    this.filterQuality = FilterQuality.low,
    this.colorBlendMode,
    this.placeholderFadeInDuration,
    this.memCacheWidth,
    this.memCacheHeight,
    this.radius = 0,
    this.cacheEnabled = true,
    this.zoomEnabled = true,
    this.onBytesLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final size = MediaQuery.of(context).size;
        final maxWidth = min(size.width, constraints.maxWidth);
        final maxHeight = min(size.height, constraints.maxHeight);

        Widget box({Widget child, DecorationImage image, Color color}) {
          return Container(
            child: child,
            height: height ?? maxHeight,
            width: width ?? maxWidth,
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color ?? context.theme.primaryColor,
              borderRadius: BorderRadius.circular(radius),
              image: image,
            ),
          );
        }

        final pHolder = Shimmer.fromColors(
          baseColor: context.theme.primaryColor.withOpacity(.1),
          highlightColor: context.theme.accentColor.withOpacity(.001),
          child: box(),
        );

        final eHolder = box(
          color: color ?? context.theme.accentColor.withOpacity(.03),
          child: Icon(Icons.info),
        );

        return CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) {
            return box(
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
              color: color,
            );
          },
          placeholder: (context, url) => pHolder,
          errorWidget: (context, url, error) => eHolder,
        );
      },
    );
  }
}
