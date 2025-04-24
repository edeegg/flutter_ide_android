import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sdk_version.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/sdk_remote_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final SdkRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OnboardingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SdkVersion>>> getSdkVersions() async {
    if (!await networkInfo.isConnected) {
      return Left(ConnectionFailure('Sem conexão com a internet'));
    }
    try {
      final versions = await remoteDataSource.fetchSdkVersions();
      return Right(versions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SdkVersion>>> getAndroidSdkVersions() async {
    if (!await networkInfo.isConnected) {
      return Left(ConnectionFailure('Sem conexão com a internet'));
    }
    try {
      final versions = await remoteDataSource.fetchAndroidSdkVersions();
      return Right(versions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
