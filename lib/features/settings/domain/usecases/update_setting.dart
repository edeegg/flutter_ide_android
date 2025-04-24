import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class UpdateSetting implements UseCase<void, SettingsEntity> {
  final SettingsRepository repository;
  UpdateSetting(this.repository);

  @override
  Future<Either<Failure, void>> call(SettingsEntity settings) {
    return repository.updateSetting(settings);
  }
}
