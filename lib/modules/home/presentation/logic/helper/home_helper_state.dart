abstract class HomeHelperState {}

class HomeHelperInitialState extends HomeHelperState{}

class HomeHelperLoadedState extends HomeHelperState{}

class HomeHelperFailureState extends HomeHelperState{
  final String errorMessage;

  HomeHelperFailureState({required this.errorMessage});
}