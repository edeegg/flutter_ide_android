import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';


abstract class TerminalRepository {
  Future<Either<Failure, void>> startTerminal(String workDir);
  Future<Either<Failure, void>> writeToTerminal(String data);
  Future<Either<Failure, void>> resizeTerminal(int width, int height);
}
