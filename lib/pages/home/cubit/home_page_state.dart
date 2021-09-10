part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageStateInitial extends HomePageState {}

class HomePageStateLoading extends HomePageState {}

class HomePageStateLoaded extends HomePageState {
  final List<MovieItemProvider> items;

  HomePageStateLoaded(this.items);
}
