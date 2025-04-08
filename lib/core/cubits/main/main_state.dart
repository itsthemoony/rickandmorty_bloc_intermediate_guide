part of 'main_cubit.dart';

@immutable
class MainState extends Equatable {
  final int currentIndex;
  final ThemeData theme;
  final bool themeToggle;
  const MainState(
      {required this.currentIndex,
      required this.theme,
      required this.themeToggle});


  MainState copyWith({
    int? currentIndex,
    ThemeData? theme,
    bool? themeToggle,
  }) {
    return MainState(
      currentIndex: currentIndex ?? this.currentIndex,
      theme: theme ?? this.theme,
      themeToggle: themeToggle ?? this.themeToggle,
    );
  }

  factory MainState.initial() {
    return MainState(currentIndex: 0, theme: lightTheme, themeToggle: false);
  }

  @override
  List<Object?> get props => [currentIndex, theme, themeToggle];
}
