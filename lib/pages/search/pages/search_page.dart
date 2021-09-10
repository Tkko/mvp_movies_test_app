import 'package:dismissible_page/dismissible_page.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/pages/search/recent_searches/core/recent_searches_cubit.dart';
import 'package:mvp_movies/pages/search/widgets/search_page_initial.dart';
import 'package:mvp_movies/pages/search/widgets/search_page_loading.dart';
import 'package:mvp_movies/pages/results/core/search_params.dart';
import 'package:mvp_movies/pages/search/widgets/search_app_bar.dart';
import 'package:mvp_movies/pages/suggestions/cubit/suggestions_bloc.dart';
import 'package:mvp_movies/pages/suggestions/pages/search_page_suggestions.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final reversedSearch = true;
  final searchBloc = SuggestionsBloc();
  final queryCtrl = TextEditingController();
  final searchFocus = FocusNode();
  final SearchParams searchParams = SearchParams();

  @override
  void initState() {
    if (searchParams?.keyword?.isNotEmpty ?? false) {
      queryCtrl.text = searchParams.keyword;
      searchBloc.add(SuggestionsEventTyping(searchParams.keyword));
    }
    context.read<RecentSearchesCubit>().init();

    super.initState();
  }

  @override
  void dispose() {
    queryCtrl.dispose();
    searchFocus.unfocus();
    searchFocus.dispose();
    super.dispose();
  }

  void onDismiss() {
    FocusScope.of(context).unfocus();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismiss: onDismiss,
      child: BlocProvider.value(
        value: searchBloc,
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: context.relativeTopPadding,
                width: 375.w,
              ),
              SearchPageAppBar(
                searchBloc: searchBloc,
                controller: queryCtrl,
              ),
              SizedBox(height: 8.w),
              SearchPageBody(controller: queryCtrl),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPageBody extends StatefulWidget {
  final TextEditingController controller;

  SearchPageBody({this.controller});

  @override
  _SearchPageBodyState createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  TextEditingController get controller => widget.controller;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.text.isEmpty) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SuggestionsBloc, SuggestionsState>(
        builder: (context, state) {
          final isInitial =
              controller.text.isEmpty || state is SuggestionsStateInitial;

          if (isInitial) {
            return SearchPageInitial();
          }

          if (state is SuggestionsStateLoaded) {
            return SearchPageSuggestions(state);
          }

          if (state is SuggestionsStateFailed) {
            return Text('SearchFailed');
          }
          return SearchPageLoading();
        },
      ),
    );
  }
}
