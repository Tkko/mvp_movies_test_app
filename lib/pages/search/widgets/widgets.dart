import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/widgets/buttons.dart';

class SearchPageListItemContainer extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final VoidCallback onCancel;

  SearchPageListItemContainer({this.onTap, this.child, this.onCancel});

  @override
  Widget build(BuildContext context) {
    final withOnCancel = onCancel != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 375.w,
        height: 60.w,
        padding: EdgeInsets.only(left: 20.w, right: withOnCancel ? 0 : 20.w),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          border: Border(
            bottom:
                BorderSide(width: 1.w, color: context.theme.backgroundColor),
          ),
        ),
        child: Row(
          children: [
            child,
            if (withOnCancel)
              SvgButton(
                svg: 'close',
                onTap: onCancel,
                padding: 20,
              ),
          ],
        ),
      ),
    );
  }
}
