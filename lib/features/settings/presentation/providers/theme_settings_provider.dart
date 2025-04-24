import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../../../core/util/enums.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/update_setting.dart';
import '../../../core/error/failures.dart';

class ThemeSettingsProvider extends ChangeNotifier {
  final GetSettings _getSettings;
  final UpdateSetting _updateSetting;

  ThemeOption _selected = ThemeOption.system;
  ThemeOption get selected => _selected;

  ThemeSettingsProvider(this._getSettings, this._updateSetting) {
    load();
  }

  Future<void> load() async {
    final res = await _getSettings(NoParams());
    res.fold(
      (_) {},
      (settings) {
        _selected = settings.themeOption;
        notifyListeners();
      },
    );
  }

  void select(ThemeOption option) {
    _selected = option;
    _save();
    notifyListeners();
  }

  Future<void> _save() async {
    final settings = SettingsEntity(themeOption: _selected);
    await _updateSetting(settings);
  }
}
