part of 'cast_bloc.dart';

abstract class CastState extends Equatable {
  const CastState();
}

class CastInitial extends CastState {
  @override
  List<Object> get props => [];
}

class CastError extends CastState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CastLoaded extends CastState {
  final List<CastEntity> casts;

  CastLoaded({required this.casts});
  @override
  List<Object?> get props => [casts];
}
