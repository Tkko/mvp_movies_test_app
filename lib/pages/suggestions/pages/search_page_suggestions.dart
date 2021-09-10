import 'dart:math';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/results/core/search_params.dart';
import 'package:mvp_movies/pages/suggestions/cubit/suggestions_bloc.dart';

class SearchPageSuggestions extends StatelessWidget {
  final SuggestionsStateLoaded state;
  final bool reversed;

  SearchPageSuggestions(this.state, {this.reversed = false});

  @override
  Widget build(BuildContext context) {
    final bottom = max(MediaQuery.of(context).viewInsets.bottom, 100.w);

    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: bottom),
        physics: RangeMaintainingScrollPhysics(),
        itemCount: state.items.length,
        itemBuilder: (_, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 150),
            child: SlideAnimation(
              verticalOffset: 30,
              child: FadeInAnimation(
                child: SearchPageSuggestionItem(item: state.items[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchPageSuggestionItem extends StatelessWidget {
  final SuggestionModel item;

  SearchPageSuggestionItem({this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.searchToResults(SearchParams.fromSuggestion(item)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.w),
        child: Text(
          item.name,
          style: context.theme.textTheme.subtitle2,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: context.theme.backgroundColor),
          ),
        ),
      ),
    );
  }
}
