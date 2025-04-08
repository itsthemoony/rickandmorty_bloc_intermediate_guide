import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../utils/config/theme/themes.dart';
part 'main_state.dart';

class MainCubit extends HydratedCubit<MainState> {
  MainCubit() : super(MainState.initial());

  void onTap({required int index}) {
    emit(state.copyWith(currentIndex: index));
  }

  void toggleTheme() {
    emit(state.copyWith(
        theme: state.theme == lightTheme ? darkTheme : lightTheme,
        themeToggle: state.theme == lightTheme ? true : false));
  }

  @override
  MainState? fromJson(Map<String, dynamic> json) {
    final theme = json['theme'] == 'light' ? lightTheme : darkTheme;
    final themeToggle = json['theme'] == 'light' ? false : true;
    return MainState(currentIndex: 0, theme: theme, themeToggle: themeToggle);
  }

  @override
  Map<String, dynamic>? toJson(MainState state) {
    return {
      'theme': state.theme == lightTheme ? 'light' : 'dark',
    };
  }
}
