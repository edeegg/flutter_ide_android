import '../../../core/util/enums.dart';

class SettingsEntity {
  final ThemeOption themeOption;
  final bool highlightError;
  final bool autoComplete;
  final bool codeBlock;
  final bool lineHighlight;
  final double fontSize;
  final bool autoLineBreak;
  final bool trimSpaces;
  final List<String> extensions;
  final String customSymbols;
  final bool lineNumbers;
  final String fontFamily;
  final bool autoSave;
  final List<CompilePlatform> compilePlatforms;
  final CompileMode compileMode;
  final CompileArch compileArch;

  SettingsEntity({
    this.themeOption = ThemeOption.system,
    this.highlightError = false,
    this.autoComplete = false,
    this.codeBlock = false,
    this.lineHighlight = false,
    this.fontSize = 14.0,
    this.autoLineBreak = false,
    this.trimSpaces = false,
    this.extensions = const [],
    this.customSymbols = '',
    this.lineNumbers = false,
    this.fontFamily = 'Roboto',
    this.autoSave = false,
    this.compilePlatforms = const [],
    this.compileMode = CompileMode.debug,
    this.compileArch = CompileArch.arm,
  });

  factory SettingsEntity.fromJson(String jsonStr) => throw UnimplementedError();
  String toJson() => throw UnimplementedError();
}
