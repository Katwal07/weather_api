abstract class HelperState {}

class HelperInitialState extends HelperState{}

class HelperLoadedState extends HelperState{}

class HelperFailureState extends HelperState{
  final String errorMessage;

  HelperFailureState({required this.errorMessage});
}