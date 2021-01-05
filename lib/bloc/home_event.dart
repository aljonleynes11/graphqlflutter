part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class FetchHomeEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}