import 'package:cached_network_image/cached_network_image.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/results/core/search_params.dart';
import 'package:mvp_movies/pages/search/widgets/search_field.dart';
import 'package:mvp_movies/pages/suggestions/cubit/suggestions_bloc.dart';
import 'package:mvp_movies/widgets/buttons.dart';

class SearchPageAppBar extends StatelessWidget {
  final TextEditingController controller;
  final SuggestionsBloc searchBloc;
  final VoidCallback onBack;
  final bool enabled;
  final bool autoFocus;
  final String image;
  final String hint;
  final FocusNode focusNode;
  final double rightPadding;

  SearchPageAppBar({
    this.controller,
    this.searchBloc,
    this.onBack,
    this.enabled = true,
    this.autoFocus = true,
    this.image,
    this.hint,
    this.focusNode,
    this.rightPadding,
  });

  void onChanged(String s) {
    if (s.isNotEmpty && s.escaped.isNotEmpty) {
      searchBloc.add(SuggestionsEventTyping(s));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'search_appbar_hero',
      child: Row(
        children: [
          AppBackButton(onBack: onBack),
          Expanded(
            child: SearchField(
              controller: controller,
              enabled: enabled,
              focusNode: focusNode,
              onChanged: onChanged,
              autofocus: autoFocus,
              hint: hint,
              leading: image != null ? SearchAppBarPhoto(image: image) : null,
              onSubmitted: (s) {
                if (s.isEmpty || s.replaceAll(' ', '').isEmpty) return;
                controller.clear();
                context.searchToResults(SearchParams(keyword: s));
              },
            ),
          ),
          SizedBox(width: rightPadding ?? 20.w),
        ],
      ),
    );
  }
}

class SearchAppBarPhoto extends StatelessWidget {
  final String image;

  SearchAppBarPhoto({this.image});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      height: 33.w,
      width: 33.w,
      margin: EdgeInsets.all(7.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: theme.backgroundColor,
      ),
      alignment: Alignment.center,
      child: CachedNetworkImage(
        imageUrl: image,
        width: 31.w,
        height: 31.w,
        // radius: 8.w,
      ),
    );
  }
}
