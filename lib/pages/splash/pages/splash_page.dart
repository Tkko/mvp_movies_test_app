import 'package:mvp_movies/app/app.dart';

class SplashPage extends StatelessWidget {
  const SplashPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RefreshProgressIndicator(),
      ),
    );
  }
}
