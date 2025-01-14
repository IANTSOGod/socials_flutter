import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:socials/components/Custom/Inputs.dart';
import 'package:socials/components/Custom/LinkLine.dart';
import 'package:socials/components/Custom/errorText.dart';
import 'package:socials/components/Custom/input_eye.dart';
import 'package:socials/components/Events/login_event.dart';
import 'package:socials/components/States/login_state.dart';
import 'package:socials/components/bloc/login_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) => {
            if (state.isSuccess) {context.go('/home')}
          },
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 30, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Inputs(
                    controller: _emailController,
                    currentLabel: "Email",
                    obscrure: false,
                    currentError: "",
                  ),
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    if (state.errorMessage.isNotEmpty) {
                      return Errortext(title: state.errorMessage);
                    } else {
                      return const SizedBox(
                        height: 0,
                      );
                    }
                  }),
                  const SizedBox(
                    height: 40,
                  ),
                  InputEye(
                      controller: _passwordController, labelText: 'Password'),
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    if (state.errorMessage.isNotEmpty) {
                      return Errortext(title: state.errorMessage);
                    } else {
                      return const SizedBox(
                        height: 0,
                      );
                    }
                  }),
                  const Linkline(),
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    if (state.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: ShadButton(
                          icon: SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          width: 300,
                          child: Text('Please wait'),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ShadButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            context.read<LoginBloc>().add(LoginSubmitted(
                                email: email, password: password));
                          }
                        },
                        width: 300,
                        backgroundColor:
                            ShadTheme.of(context).colorScheme.primary,
                        child: const Text("Log in"),
                      ),
                    );
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
