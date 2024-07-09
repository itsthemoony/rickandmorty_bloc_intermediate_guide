import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/cubits/main/main_cubit.dart';
import '../../../constants/constants.dart';
import '../../../utils/widgets/texts/rm_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: RMPaddings.p16, vertical: RMPaddings.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RMHeader(text: RMTexts.settings),
              const SizedBox(height: RMSizes.s20),
              BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(RMTexts.theme,
                          style: Theme.of(context).textTheme.titleMedium),
                      CupertinoSwitch(
                        value: state.themeToggle,
                        onChanged: (_) {
                          context.read<MainCubit>().toggleTheme();
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
