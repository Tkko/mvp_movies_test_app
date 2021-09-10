import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp_movies/app/app.dart';

class SvgButton extends StatelessWidget {
  final VoidCallback onTap;
  final String svg;
  final double svgWidth, radius, padding;
  final Color backgroundColor, svgColor;

  SvgButton({
    this.backgroundColor,
    this.svgColor,
    this.svg,
    this.onTap,
    this.svgWidth,
    this.radius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius ?? 50.w),
      child: InkWell(
        canRequestFocus: false,
        borderRadius: BorderRadius.circular(radius ?? 50.w),
        onTap: onTap,
        child: LayoutBuilder(
          builder: (_, BoxConstraints c) {
            return Ink(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius ?? 50.w),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: min(c.maxWidth, padding ?? 12.w),
                vertical: min(c.maxHeight, padding ?? 12.w),
              ),
              child: SvgPicture.asset(
                svg.svg,
                color: svgColor ?? context.theme.primaryColorLight,
                width: svgWidth ?? 20.w,
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  final VoidCallback onBack;

  AppBackButton({this.onBack});

  @override
  Widget build(BuildContext context) {
    return SvgButton(
      svg: 'arrow_left',
      onTap: onBack ?? () => Navigator.canPop(context) ? context.pop() : null,
    );
  }
}

class TxtButton extends StatelessWidget {
  final VoidCallback onTap;
  final Text child;

  TxtButton({
    @required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.w),
      child: Container(
        height: 35.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
