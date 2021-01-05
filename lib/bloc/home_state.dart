part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  QueryResult result;
  Country country;
  HomeLoaded({@required this.country});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class HomeError extends HomeState {
  String message;

  HomeError({@required this.message});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}