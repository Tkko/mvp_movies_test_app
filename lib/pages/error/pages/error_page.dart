import 'package:mvp_movies/app/app.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error Occurred', style: context.textTheme.bodyText1),
      ),
    );
  }
}
