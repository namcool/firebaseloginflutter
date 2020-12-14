import 'package:firebaseloginbloc/events/register_event.dart';
import 'package:firebaseloginbloc/repositories/user_repository.dart';
import 'package:firebaseloginbloc/states/register_state.dart';
import 'package:firebaseloginbloc/validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  //constructor
  RegisterBloc({UserRepository userRepository}) : assert(userRepository != null),
  _userRepository = userRepository,
  super(RegisterState.initial());

  //Give 2 adjacent events a "debounce time"
  //Thêm khoảng trễ giữa 2 lần nhấn
  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(Stream<RegisterEvent> registerEvents, transitionFunction) {
    // TODO: implement transformEvents
    final debounceStream = registerEvents.where((event) {
      return (event is RegisterEventEmailChanged || event is RegisterEventPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    final nonDebounceStream = registerEvents.where((event) {
      return (event is! RegisterEventEmailChanged || event is! RegisterEventPasswordChanged);
    });

    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]),transitionFunction);
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent registerEvent) async* {
    // TODO: implement mapEventToState
    final registerState = state;
    if (registerEvent is RegisterEventEmailChanged) {
      yield registerState.cloneAndUpdate(isValidEmail: Validators.isValidEmail(registerEvent.email));
    } else if(registerEvent is RegisterEventPasswordChanged) {
      yield registerState.cloneAndUpdate(isValidPassword: Validators.isValidPassword(registerEvent.password));
    } else if(registerEvent is RegisterEventPressed) {
      yield RegisterState.loading();
      try {
        await _userRepository.createUserWithEmailAndPassword(
          registerEvent.email,
          registerEvent.password
        );
        yield RegisterState.success();
      } catch(exception) {
        print(exception.toString());
        yield RegisterState.failure();
      }
    }
  }
}