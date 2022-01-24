import 'package:dartz/dartz.dart';
import 'package:movieapp_bloc/common/constants/theme.dart';
import 'package:movieapp_bloc/domain/entities/app_error.dart';
import 'package:movieapp_bloc/domain/entities/no_params.dart';
import 'package:movieapp_bloc/domain/repositories/app_repository.dart';
import 'package:movieapp_bloc/domain/usecases/usecase.dart';

class GetPreferredTheme extends UseCase<Themes, NoParams> {
  final AppRepository appRepository;

  GetPreferredTheme({required this.appRepository});

  @override
  Future<Either<AppError, Themes>> call(NoParams params) async {
    return await appRepository.getPreferredTheme();
  }
}
