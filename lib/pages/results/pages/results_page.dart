import 'package:mvp_movies/pages/home/cubit/home_page_cubit.dart';
import 'package:mvp_movies/pages/results/widgets/results_page_grid_items.dart';
import 'package:mvp_movies/pages/results/widgets/results_page_appbar.dart';
import 'package:mvp_movies/pages/results/core/search_params.dart';
import 'package:mvp_movies/app/app.dart';

class ResultsPage extends StatefulWidget {
  final SearchParams searchParams;

  ResultsPage(this.searchParams);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> with WidgetsBindingObserver {
  final keywordCtrl = TextEditingController();
  final scrollCtrl = ScrollController();
  SearchParams searchParams;

  @override
  void initState() {
    searchParams = widget.searchParams ?? SearchParams();
    keywordCtrl.text = searchParams.keyword;
    searchParams.controller.addPageRequestListener((pageKey) {
      searchParams.getItems(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollCtrl.dispose();
    searchParams.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomePageCubit>().initIfDirty();
        return true;
      },
      child: Material(
        color: theme.scaffoldBackgroundColor,
        child: RefreshIndicator(
          displacement: 56.w,
          onRefresh: () {
            searchParams.refresh();
            return Future.delayed(Duration(milliseconds: 100));
          },
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: scrollCtrl,
            slivers: <Widget>[
              ResultsPageAppbar(
                controller: keywordCtrl,
                searchParams: searchParams,
              ),
              ResultsPageGridItems(controller: searchParams.controller)
            ],
          ),
        ),
      ),
    );
  }
}
