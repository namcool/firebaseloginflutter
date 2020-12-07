import 'package:firebaseloginbloc/events/authentication_event.dart';
import 'package:firebaseloginbloc/repositories/user_repository.dart';
import 'package:firebaseloginbloc/states/authentication_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository}) : assert(userRepository != null),
  _userRepository = userRepository,
  super(AuthenticationStateInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent authenticationEvent) async* {
    // TODO: implement mapEventToState
    if(authenticationEvent is AuthenticationEventStarted) {
      final isSignedIn = _userRepository.isSignIn();
      if(isSignedIn == true) {
        final firebaseUser = await _userRepository.getUser();
        yield AuthenticationStateSuccess(firebaseUser: firebaseUser);
      } else {
        yield AuthenticationStateFailure();
      }
    } else if(authenticationEvent is AuthenticationEventLoggedIn) {
      yield AuthenticationStateSuccess(firebaseUser: await _userRepository.getUser());
    } else if(authenticationEvent is AuthenticationEventLoggedOut) {
      _userRepository.signOut();
      yield AuthenticationStateFailure();
    }
  }
}