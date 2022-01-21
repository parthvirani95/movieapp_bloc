import 'package:equatable/equatable.dart';

class MovieSearchParams extends Equatable {
  final String query;

  MovieSearchParams({required this.query});

  @override
  List<Object?> get props => [this.query];
}
