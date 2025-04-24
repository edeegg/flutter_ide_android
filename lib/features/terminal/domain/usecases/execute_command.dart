import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/terminal_command.dart';
import '../repositories/terminal_repository.dart';

class ExecuteCommand implements UseCase<void, TerminalCommand> {
  final TerminalRepository repository;
  ExecuteCommand({required this.repository});

  @override
  Future<Either<Failure, void>> call(TerminalCommand params) {
    return repository.writeToTerminal(params.command);
  }
}
