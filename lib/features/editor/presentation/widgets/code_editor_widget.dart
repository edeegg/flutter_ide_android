/* 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:re_editor/re_editor.dart';
import '../providers/editor_provider.dart';

class CodeEditorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EditorProvider>();
    return CodeTheme(
      data: monokaiSublimeTheme,
      child: CodeField(
        controller: vm.codeController,
        textStyle: TextStyle(fontFamily: 'SourceCode'),
      ),
    );
  }
}
 */