import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/update_setting.dart';

class EditorSettingsRepository extends ChangeNotifier {
  final GetSettings _getSettings;
  final UpdateSetting _updateSetting;

  
  bool highlightError = false;
  bool autoComplete = false;
  bool codeBlock = false;
  bool lineHighlight = false;
  double fontSize = 14;
  bool autoLineBreak = false;
  bool trimSpaces = false;
  List<String> extensions = [];
  String customSymbols = '';
  bool lineNumbers = false;
  String fontFamily = 'Roboto';
  bool autoSave = false;

  EditorSettingsRepository(this._getSettings, this._updateSetting) {
    load();
  }

  Future<void> load() async {
    final res = await _getSettings(NoParams());
    res.fold((_) {}, (s) {
      highlightError = s.highlightError;
      autoComplete = s.autoComplete;
      codeBlock = s.codeBlock;
      lineHighlight = s.lineHighlight;
      fontSize = s.fontSize;
      autoLineBreak = s.autoLineBreak;
      trimSpaces = s.trimSpaces;
      extensions = s.extensions;
      customSymbols = s.customSymbols;
      lineNumbers = s.lineNumbers;
      fontFamily = s.fontFamily;
      autoSave = s.autoSave;
      notifyListeners();
    });
  }

  void toggleHighlightError(bool v) { highlightError = v; _save(); notifyListeners(); }
  void toggleAutoComplete(bool v) { autoComplete = v; _save(); notifyListeners(); }
  

  Future<void> _save() async {
    final s = SettingsEntity(
      highlightError: highlightError,
      autoComplete: autoComplete,
      codeBlock: codeBlock,
      lineHighlight: lineHighlight,
      fontSize: fontSize,
      autoLineBreak: autoLineBreak,
      trimSpaces: trimSpaces,
      extensions: extensions,
      customSymbols: customSymbols,
      lineNumbers: lineNumbers,
      fontFamily: fontFamily,
      autoSave: autoSave,
    );
    await _updateSetting(s);
  }
}
