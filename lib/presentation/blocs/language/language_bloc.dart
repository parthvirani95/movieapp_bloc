import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp_bloc/common/constants/languages.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/language_entity.dart';
import 'package:movieapp_bloc/domain/entities/no_params.dart';
import 'package:movieapp_bloc/domain/usecases/get_preferred_language.dart';
import 'package:movieapp_bloc/domain/usecases/update_language.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetPreferredLanguage getPreferredLanguage;
  final UpdateLanguage updateLanguage;

  LanguageBloc({
    required this.getPreferredLanguage,
    required this.updateLanguage,
  }) : super(LanguageLoaded(Locale(Languages.languages[0].code))) {
    on<LanguageEvent>((event, emit) {});
    on<ToggleLanguageEvent>((event, emit) async {
      await updateLanguage(event.language.code);
      add(LoadPreferredLanguageEvent());
      // emit(LanguageLoaded(Locale(event.language.code)));
    });
    on<LoadPreferredLanguageEvent>((event, emit) async {
      final response = await getPreferredLanguage(NoParams());

      emit(
        response.fold(
          (l) => LanguageError(appErrorType: l.errorType),
          (r) => LanguageLoaded(Locale(r)),
        ),
      );
    });
  }
}
