import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;
  //contructor
  RegisterState({
    @required this.isValidEmail,
    @required this.isValidPassword,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure
  });
  //each state is an object, or static object,
  //Can be created by using static/factory method
  factory RegisterState.initial() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false
    );
  }
  //Loading state
  factory RegisterState.loading() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false
    );
  }
  //Failure state
  factory RegisterState.failure() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true
    );
  }
  //Success state
  factory RegisterState.success() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false
    );
  }
  //Clone an object of LoginState ?
  RegisterState cloneWith({
    bool isValidEmail,
    bool isValidPassword,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
        isValidEmail: isValidEmail ?? this.isValidEmail, //if isValidEmail == null => isValidEmail unchanged!
        isValidPassword: isValidPassword ?? this.isValidPassword,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }
  //How to clone and update an object
  RegisterState cloneAndUpdate ({
    bool isValidEmail,
    bool isValidPassword,}) {
    return cloneWith(
        isValidEmail: isValidEmail,
        isValidPassword: isValidPassword
    );
  }
}