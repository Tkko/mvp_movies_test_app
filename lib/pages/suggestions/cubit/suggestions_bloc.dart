import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mvp_movies/app/app.dart';
import 'package:mvp_movies/app/core/http_request_handler/http_request_handler.dart';
import 'package:rxdart/rxdart.dart';

part 'suggestions_state.dart';

@immutable
class SuggestionsEvent {}

class SuggestionsEventTyping extends SuggestionsEvent {
  final String keyword;

  SuggestionsEventTyping(this.keyword);
}

class SuggestionsBloc extends Bloc<SuggestionsEvent, SuggestionsState> {
  SuggestionsBloc() : super(SuggestionsStateInitial());

  @override
  Stream<SuggestionsState> mapEventToState(
    SuggestionsEvent event,
  ) async* {
    if (event is SuggestionsEventTyping) {
      yield* _typing(event);
    }
  }

  Stream<SuggestionsState> _typing(SuggestionsEventTyping event) async* {
    yield SuggestionsStateLoading(event.keyword);
    final res = await _search(event.keyword);
    if (res.isEmpty) {
      res.add(SuggestionModel(name: event.keyword));
    }
    yield SuggestionsStateLoaded(res);
  }
  // https://api.themoviedb.org/3/search/keyword?api_key=bac8d2c9671125eef704c95b74934869&query=nake&page=1
  // https://api.themoviedb.org/3/search/keyword/?api_key=bac8d2c9671125eef704c95b74934869&query=nak&page=1

  Future<List<SuggestionModel>> _search(String query) async {
    final res = await apiClient.keywords({
      'query': query,
      'page': 1,
    });
    try {
      if (res is ApiSuccessResponse) {
        return res.data
            .map<SuggestionModel>((e) => SuggestionModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print('Future<List<SuggestionModel>> _search  $e');
    }
    return [];
  }

  @override
  Stream<Transition<SuggestionsEvent, SuggestionsState>> transformEvents(
      Stream<SuggestionsEvent> events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 200))
        .switchMap((transitionFn));
  }
}
