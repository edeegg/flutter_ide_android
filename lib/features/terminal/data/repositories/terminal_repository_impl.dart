import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/terminal_repository.dart';
import '../datasources/terminal_remote_data_source.dart';

class TerminalRepositoryImpl implements TerminalRepository {
  final TerminalRemoteDataSource remoteDataSource;

  TerminalRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> startTerminal(String workDir) async {
    try {
      await remoteDataSource.startTerminal(workDir);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> writeToTerminal(String data) async {
    try {
      await remoteDataSource.writeToTerminal(data);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resizeTerminal(int width, int height) async {
    try {
      await remoteDataSource.resize(width, height);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
