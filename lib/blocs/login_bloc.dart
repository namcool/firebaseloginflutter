import 'package:firebaseloginbloc/events/login_event.dart';
import 'package:firebaseloginbloc/repositories/user_repository.dart';
import 'package:firebaseloginbloc/states/login_state.dart';
import 'package:firebaseloginbloc/validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({UserRepository userRepository}) : assert(userRepository != null),
    _userRepository = userRepository,
    super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async* {
    // TODO: implement mapEventToState
    final loginState = state;
    if(loginEvent is LoginEventEmailChanged) {
      yield loginState.cloneAndUpdate(isValidEmail: Validators.isValidEmail(loginEvent.email));
    }
  }
}