import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/common/constants/theme.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/repositories/app_repository.dart';
import 'package:movieapp_bloc/domain/usecases/usecase.dart';

class UpdateTheme extends UseCase<void, Themes> {
  final AppRepository appRepository;

  UpdateTheme({required this.appRepository});

  @override
  Future<Either<AppError, void>> call(Themes params) async {
    return await appRepository.updateTheme(params);
  }
}
