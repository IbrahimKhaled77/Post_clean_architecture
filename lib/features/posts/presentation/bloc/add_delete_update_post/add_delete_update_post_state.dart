import 'package:equatable/equatable.dart';

abstract class PostControllerState extends Equatable {}

class PostControllerInitialState extends PostControllerState {
  @override
  List<Object?> get props => [];
}

class PostControllerLoadingState extends PostControllerState {
  @override
  List<Object?> get props => [];
}

class PostControllerSuccessState extends PostControllerState {
  final String massageSuccess;

  PostControllerSuccessState({required this.massageSuccess});

  @override
  List<Object?> get props => [massageSuccess];
}

class PostControllerErrorState extends PostControllerState {
  final String massageError;

  PostControllerErrorState({required this.massageError});

  @override
  List<Object?> get props => [massageError];
}
