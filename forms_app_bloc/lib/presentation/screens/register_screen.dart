import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app_bloc/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app_bloc/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo usuario"),
      ),
      body: BlocProvider(
          create: (context) => RegisterCubit(), child: const _RegisterView()),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const FlutterLogo(size: 50),
            _RegisterForm(),
          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final email = registerCubit.state.email;
    final password = registerCubit.state.password;
    return Form(
        child: Column(
      children: [
        CustomTextFormField(
          label: "Nombre de usuario",
          icon: Icons.person,
          onChanged: registerCubit.usernameChanged,
          errorText: username.errorMessage,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: "Correo electrónico",
          icon: Icons.email_rounded,
          onChanged: registerCubit.emailChanged,
          errorText: email.errorMessage,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          label: "Contraseña",
          icon: Icons.password_rounded,
          onChanged: registerCubit.passwordChanged,
          errorText: password.errorMessage,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        FilledButton.tonalIcon(
          onPressed: () {
            registerCubit.onSubmit();
          },
          icon: const Icon(Icons.save),
          label: const Text("Crear usuario"),
        )
      ],
    ));
  }
}
