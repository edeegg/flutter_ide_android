import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../../core/util/enums.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/update_setting.dart';
import '../../domain/entities/settings_entity.dart';

class CompileSettingsRepository extends ChangeNotifier {
  final GetSettings _getSettings;
  final UpdateSetting _updateSetting;

  List<CompilePlatform> platforms = [];
  CompileMode mode = CompileMode.debug;
  CompileArch arch = CompileArch.arm;

  CompileSettingsRepository(this._getSettings, this._updateSetting) {
    load();
  }

  Future<void> load() async {
    final res = await _getSettings(NoParams());
    res.fold((_) {}, (s) {
      platforms = s.compilePlatforms;
      mode = s.compileMode;
      arch = s.compileArch;
      notifyListeners();
    });
  }

  void togglePlatform(CompilePlatform p) {
    if (platforms.contains(p)) platforms.remove(p);
    else platforms.add(p);
    _save(); notifyListeners();
  }

  void selectMode(CompileMode m) { mode = m; _save(); notifyListeners(); }
  void selectArch(CompileArch a) { arch = a; _save(); notifyListeners(); }

  Future<void> _save() async {
    final s = SettingsEntity(
      compilePlatforms: platforms,
      compileMode: mode,
      compileArch: arch,
    );
    await _updateSetting(s);
  }
}
