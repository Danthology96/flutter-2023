import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:forms_app_bloc/infrastructure/inputs/inputs.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    emit(state.copyWith(
      formStatus: FormStatus.validating,
      username: UsernameInput.dirty(value: state.username.value),
      email: EmailInput.dirty(value: state.email.value),
      password: PasswordInput.dirty(value: state.password.value),
      isValid: Formz.validate([state.username, state.password, state.email]),
    ));
    debugPrint("Submit: $state");
  }

  void usernameChanged(String value) {
    final username = UsernameInput.dirty(value: value);

    emit(state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.password, state.email])));
  }

  void emailChanged(String value) {
    final email = EmailInput.dirty(value: value);
    emit(state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password, state.username])));
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value: value);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username, state.email])));
  }
}
