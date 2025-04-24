import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDS;
  SettingsRepositoryImpl(this.localDS);

  @override
  Future<Either<Failure, SettingsEntity>> getSettings() async {
    try {
      final s = await localDS.getSettings();
      return Right(s);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateSetting(SettingsEntity settings) async {
    try {
      await localDS.saveSettings(settings);
      return Right(null);
    } catch (_) {
      return Left(CacheFailure());
    }
  }
}
