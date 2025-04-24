import '../../domain/entities/terminal_command.dart';

class TerminalOutputModel {
  final String output;
  final DateTime timestamp;

  TerminalOutputModel({required this.output, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  TerminalCommand toEntity() {
    return TerminalCommand(output);
  }
}
