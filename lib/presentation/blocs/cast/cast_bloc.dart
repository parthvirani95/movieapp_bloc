import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/cast_entity.dart';
import 'package:movieapp_bloc/domain/entities/movie_params.dart';
import 'package:movieapp_bloc/domain/usecases/get_cast.dart';

part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCast getCast;

  CastBloc({required this.getCast}) : super(CastInitial()) {
    on<CastEvent>((event, emit) async {
      if (event is LoadCastEvent) {
        Either<AppError, List<CastEntity>> eitherResponse = await getCast(MovieParams(id: event.movieId));
        emit(eitherResponse.fold((error) => CastError(), (casts) => CastLoaded(casts: casts)));
      }
    });
  }
}
