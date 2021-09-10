import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/app/constants.dart';
import 'package:mvp_movies/pages/error/pages/error_page.dart';
import 'package:mvp_movies/pages/home/pages/home_page.dart';
import 'package:mvp_movies/pages/splash/pages/splash_page.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  /// App Routes
  Map<String, WidgetBuilder> appRoutes = {
    AppRoutes.SPLASH: (_) => SplashPage(),
    AppRoutes.ERROR: (_) => ErrorPage(),
    AppRoutes.HOME: (_) => HomePage(),
  };

  final appNavigatorKey = GlobalKey<NavigatorState>();

  BuildContext get appContext => appNavigatorKey.currentContext;

  final appThemes = AppThemes();

  @override
  Widget build(BuildContext context) {
    return NetworkOverlay(
      theme: appThemes.theme,
      child: MaterialApp(
        title: 'Mvp Movies',
        navigatorKey: appNavigatorKey,
        theme: appThemes.theme,
        routes: appRoutes,
        initialRoute: AppRoutes.HOME,
      ),
    );
  }
}
