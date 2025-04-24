import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';

import '../../data/datasources/terminal_remote_data_source.dart';
import '../../domain/entities/terminal_command.dart';
import '../../domain/usecases/execute_command.dart';

class TerminalProvider extends ChangeNotifier {
  final ExecuteCommand executeCommand;
  final TerminalRemoteDataSource remoteDataSource;
  String workDirectory = '/data/data/com.termux/files/usr';

  TerminalProvider({
    required this.executeCommand,
    required this.remoteDataSource,
  }) {
    initTerminal();
  }

  Terminal get terminal => remoteDataSource.terminal;
  TerminalController get controller => remoteDataSource.controller;

  Future<void> initTerminal() async {
    await remoteDataSource.startTerminal(workDirectory);
  }

  Future<void> sendCommand(String input) async {
    final cmd = TerminalCommand('$input\n');
    final result = await executeCommand(cmd);
    result.fold(
      (failure) {},
      (sucess) {},
    );
  }

  void resize(int width, int height) {
    executeCommand.call(TerminalCommand(''));
    notifyListeners();
  }
}
