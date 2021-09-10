import 'package:mvp_movies/app/app.dart';

class FillBottomPadding extends StatelessWidget {
  const FillBottomPadding();

  @override
  Widget build(BuildContext context) => SizedBox(height: context.bottomPadding);
}

class FillTopPadding extends StatelessWidget {
  const FillTopPadding();

  @override
  Widget build(BuildContext context) => SizedBox(height: context.topPadding);
}
