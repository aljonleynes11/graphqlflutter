import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:graphqltest/model/Country.dart';
import 'package:graphqltest/repository/graphql_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GraphQLService graphql;
  HomeBloc({@required this.graphql});
  @override
  // TODO: implement initialState
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchHomeEvent) {
      yield HomeLoading();
      String query = r'''
      query {
        countries {
            name
            capital
        }
      }
        ''';
      try {
        final _result = await graphql.performQuery(query);
        print(_result.data['countries']);
        Country _country = Country.fromJson(_result.data);
        yield HomeLoaded(country: _country);
      } catch (e) {
        print(e);
        yield HomeError(message:e.toString());
      }
    }
  }
}
