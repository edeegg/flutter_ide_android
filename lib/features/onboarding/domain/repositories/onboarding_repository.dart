import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/sdk_version.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, List<SdkVersion>>> getSdkVersions();
  Future<Either<Failure, List<SdkVersion>>> getAndroidSdkVersions();
}
