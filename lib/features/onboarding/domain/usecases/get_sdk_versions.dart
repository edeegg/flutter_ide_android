import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/sdk_version.dart';
import '../repositories/onboarding_repository.dart';

class GetSdkVersions implements UseCase<List<SdkVersion>, NoParams> {
  final OnboardingRepository repository;

  GetSdkVersions(this.repository);

  @override
  Future<Either<Failure, List<SdkVersion>>> call(NoParams params) =>
      repository.getSdkVersions();
}
