import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp_bloc/common/constants/languages.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/language_entity.dart';
import 'package:movieapp_bloc/domain/entities/no_params.dart';
import 'package:movieapp_bloc/domain/usecases/get_preferred_language.dart';
import 'package:movieapp_bloc/domain/usecases/update_language.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final GetPreferredLanguage getPreferredLanguage;
  final UpdateLanguage updateLanguage;

  LanguageCubit({
    required this.getPreferredLanguage,
    required this.updateLanguage,
  }) : super(LanguageLoaded(Locale(Languages.languages[0].code))) {}
  void toggleLanguage(LanguageEntity language) async {
    await updateLanguage(language.code);
    loadPreferredLanguage();
  }

  Future<void> loadPreferredLanguage() async {
    final response = await getPreferredLanguage(NoParams());
    emit(
      response.fold(
        (l) => LanguageError(appErrorType: l.errorType),
        (r) => LanguageLoaded(Locale(r)),
      ),
    );
  }
}
