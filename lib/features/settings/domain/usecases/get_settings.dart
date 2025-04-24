import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetSettings implements UseCase<SettingsEntity, NoParams> {
  final SettingsRepository repository;
  GetSettings(this.repository);

  @override
  Future<Either<Failure, SettingsEntity>> call(NoParams _) {
    return repository.getSettings();
  }
}
