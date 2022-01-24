import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/common/constants/theme.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';

abstract class AppRepository {
  Future<Either<AppError, void>> updateLanguage(String language);
  Future<Either<AppError, String>> getPreferredLanguage();

  Future<Either<AppError, void>> updateTheme(Themes theme);
  Future<Either<AppError, Themes>> getPreferredTheme();
}
