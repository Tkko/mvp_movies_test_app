import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/app/core/api_client/api_constants.dart';

class MovieItemModel {
  MovieItemModel({
    this.adult,
    this.gender,
    this.id,
    this.mediaType,
    this.name,
    this.popularity,
    this.posterPath,
    this.profilePath,
    this.voteAverage,
    this.overview,
  });

  final bool adult;
  final int gender;
  final int id;
  final String mediaType;
  final String posterPath;
  final String name;
  final double popularity;
  final double voteAverage;
  final String profilePath;
  final String overview;

  String get rating {
    if (voteAverage != null) {
      return '$voteAverage/10';
    }
    return 'NA';
  }

  bool get isMovie => mediaType == 'movie';

  bool get isTvShow => mediaType == 'tv';

  bool get showInResults => isMovie || isTvShow;

  String get cover => '${ENVIRONMENT.IMAGE_URL}$posterPath';

  String get description => overview ?? 'Non Provided';

  String get title => name ?? 'Non Provided';

  factory MovieItemModel.fromJson(Map<String, dynamic> json) => MovieItemModel(
        adult: json.b('adult'),
        gender: json.i('gender'),
        id: json.i('id'),
        mediaType: json.s('media_type'),
        posterPath: json.s('poster_path'),
        name: json.s('name'),
        popularity: json.d('popularity'),
        overview: json.s('overview'),
        voteAverage: json.d('vote_average'),
        profilePath: json.s('profile_path'),
      );
}
