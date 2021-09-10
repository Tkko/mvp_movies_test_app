part of 'suggestions_bloc.dart';

class SuggestionsState {}

class SuggestionsStateInitial extends SuggestionsState {}

class SuggestionsStateLoaded extends SuggestionsState {
  final List<SuggestionModel> items;

  SuggestionsStateLoaded(this.items);
}

class SuggestionsStateLoading extends SuggestionsState {
  final String query;

  SuggestionsStateLoading(this.query);
}

class SuggestionsStateFailed extends SuggestionsState {}

class SuggestionModel {
  final String name;
  final int id;

  SuggestionModel({this.name, this.id});

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      name: json.s('name'),
      id: json.i('id'),
    );
  }
}
