import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/app/app_page_routes.dart';
import 'package:mvp_movies/pages/results/pages/results_page.dart';
import 'package:mvp_movies/pages/search/recent_searches/core/recent_searches_cubit.dart';
import 'package:mvp_movies/pages/results/core/search_params.dart';

typedef IndexedBuilder = Widget Function(int index);

extension StateExt on State {
  ThemeData get theme => Theme.of(context);

  TextTheme get textTheme => this.theme.textTheme;
}

extension NumberExt on int {
  List<Widget> asList({@required IndexedBuilder builder}) {
    return List.generate(this, (i) => builder.call(i));
  }

  List<Widget> asSeparatedList({
    @required IndexedBuilder separatorBuilder,
    @required IndexedBuilder builder,
  }) {
    final itemCount = max(0, this * 2 - 1);
    return [for (int i = 0; i < itemCount; i += 1) i].map((index) {
      final int itemIndex = index ~/ 2;
      return index.isEven
          ? builder.call(itemIndex)
          : separatorBuilder.call(itemIndex);
    }).toList();
  }
}

extension StringExt on String {
  String get escaped =>
      this.characters.where((e) => !'_.- <>'.contains(e)).join();

  String get svg => 'assets/svg/$this.svg';

  String get png => 'assets/png/$this.png';

  String get jpg => 'assets/png/$this.jpg';
}

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => this.theme.textTheme;

  EdgeInsetsGeometry get devicePadding =>
      MediaQueryData.fromWindow(window).padding;

  double get bottomPadding => MediaQueryData.fromWindow(window).padding.bottom;

  double get topPadding => MediaQueryData.fromWindow(window).padding.top;

  bool get deviceNeedTopPadding =>
      kIsWeb || Platform.isAndroid ? true : this.topPadding < 35;

  double get relativeTopPadding =>
      this.topPadding + (deviceNeedTopPadding ? 12.w : 0);

  bool get deviceNeedBottomPadding =>
      kIsWeb || Platform.isAndroid ? true : this.bottomPadding < 20;

  double get relativeBottomPadding =>
      this.bottomPadding + (deviceNeedBottomPadding ? 8.w : 0);

  NavigatorState get nav => Navigator.of(this);

  bool get canPop => Navigator.canPop(this);

  void pop([res]) => nav.pop(res);

  Future push(Widget page, {String name}) {
    return nav.push(CupertinoAppRoute(
      builder: (_) => page,
      settings: RouteSettings(name: '${name ?? page}'),
    ));
  }

  /// See [pushTransparentRoute] Docs
  Future pushReplacement(Widget page, {String name}) =>
      nav.pushReplacement(CupertinoAppRoute(
        builder: (_) => page,
        settings: RouteSettings(name: '${name ?? page}'),
      ));

  Future popAndPushNamed(String page) => nav.popAndPushNamed(page);

  Future pushNamed(String routeName, {Object arguments}) =>
      nav.pushNamed(routeName, arguments: arguments);

  Future pushReplacementNamed(String routeName, {Object arguments}) =>
      nav.pushReplacementNamed(routeName, arguments: arguments);

  /// Navigate from [SearchPage] to [ResultsPage]
  void searchToResults(SearchParams searchParams) {
    FocusScope.of(this).unfocus();
    this.read<RecentSearchesCubit>().onSearch(searchParams.keyword);
    this.pushReplacement(ResultsPage(searchParams));
  }
}
