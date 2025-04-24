import 'dart:convert';

import 'package:flutter_pty/flutter_pty.dart';
import 'package:xterm/xterm.dart';

abstract class TerminalRemoteDataSource {
  Terminal get terminal;
  TerminalController get controller;
  Future<void> startTerminal(String workDir);
  Future<void> writeToTerminal(String data);
  Future<void> resize(int width, int height);
}

class TerminalRemoteDataSourceImpl implements TerminalRemoteDataSource {
  Pty? _pty;
  @override
  final Terminal terminal;
  @override
  final TerminalController controller;

  TerminalRemoteDataSourceImpl()
      : terminal = Terminal(maxLines: 10000),
        controller = TerminalController();

  @override
  Future<void> startTerminal(String workDir) async {
    _pty = Pty.start(
      'bash'
     // '/data/data/com.termux/files/usr/bin/bash',
      arguments: [],
      environment: {
    //    'HOME': '/data/data/com.termux/files/home',
      //  'TERMUX_PREFIX': '/data/data/com.termux/files/usr',
    //    'TERM': 'xterm-256color',
       // 'PATH': '/data/data/com.termux/files/usr/bin',
        // 'LD_PRELOAD': '/data/data/com.termux/files/usr/lib/libtermux-exec.so',
      },
      workingDirectory: workDir,
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );
    _pty?.output
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen((data) {
      terminal.write(data);
    });
    _pty?.exitCode.then((code) {
      terminal.write('\nProcess exited with code $code\n');
    });
    terminal.onOutput = (data) {
      _pty?.write(const Utf8Encoder().convert(data));
    };

    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      _pty?.resize(height, width);
    };
  }

  @override
  Future<void> writeToTerminal(String data) async {
    _pty?.write(const Utf8Encoder().convert(data));
  }

  @override
  Future<void> resize(int width, int height) async {
    _pty?.resize(height, width);
  }
}
