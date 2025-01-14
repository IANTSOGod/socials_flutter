import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socials/components/Custom/Inputs.dart';
import 'package:socials/components/Events/input_eye_event.dart';
import 'package:socials/components/States/input_eye_state.dart';
import 'package:socials/components/bloc/input_eye_bloc.dart';

class InputEye extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const InputEye(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InputEyeBloc(),
      child: BlocListener<InputEyeBloc, InputEyeState>(
        listener: (context, state) {},
        child: Stack(
          children: [
            BlocBuilder<InputEyeBloc, InputEyeState>(builder: (context, state) {
              return Inputs(
                  controller: controller,
                  currentLabel: labelText,
                  obscrure: state.isShow,
                  currentError: "",
              );
            }),
            Positioned(
                top: 0,
                left: 300,
                child: BlocBuilder<InputEyeBloc, InputEyeState>(
                    builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        context
                            .read<InputEyeBloc>()
                            .add(ChangeCurrentEye(showEye: !state.isShow));
                      },
                      icon: (state.isShow)
                          ? const Icon(Icons.remove_red_eye_rounded)
                          : const Icon(Icons.remove_red_eye_outlined));
                }))
          ],
        ),
      ),
    );
  }
}
