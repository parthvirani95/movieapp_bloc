import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/common/constants/theme.dart';
import 'package:movieapp_bloc/data/data_sources/language_local_data_source.dart';
import 'package:movieapp_bloc/data/data_sources/theme_local_data_source.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/repositories/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final LanguageLocalDataSource languageLocalDataSource;
  final ThemeLocalDataSource themeLocalDataSource;

  AppRepositoryImpl({
    required this.languageLocalDataSource,
    required this.themeLocalDataSource,
  });

  @override
  Future<Either<AppError, String>> getPreferredLanguage() async {
    try {
      final response = await languageLocalDataSource.getPreferredLanguage();
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateLanguage(String language) async {
    try {
      final response = await languageLocalDataSource.updateLanguage(language);
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, Themes>> getPreferredTheme() async {
    try {
      final response = await themeLocalDataSource.getPreferredTheme();
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateTheme(Themes themes) async {
    try {
      final response = await themeLocalDataSource.updateTheme(themes);
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }
}
