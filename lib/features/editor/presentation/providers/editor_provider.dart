/* 
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';

class EditorProvider extends ChangeNotifier {
  final codeController = CodeController(
    // linguagem padrão: Dart
    language: dart,
    theme: monokaiSublimeTheme,
    text: '// Comece a digitar seu código aqui...',
  );

  void formatDocument() {
    // Aqui poderia usar um formatter externo
    notifyListeners();
  }

  String get currentCode => codeController.text;
}
 */