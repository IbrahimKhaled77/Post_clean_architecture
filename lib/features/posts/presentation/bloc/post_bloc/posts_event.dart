import 'package:equatable/equatable.dart';

abstract class PostGetEvent extends Equatable {}

class GetAllPostEvent extends PostGetEvent {
  @override
  List<Object?> get props => [];
}

class RefreshPostEvent extends PostGetEvent {
  @override
  List<Object?> get props => [];
}
