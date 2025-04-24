import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entities/settings_entity.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsEntity> getSettings();
  Future<void> saveSettings(SettingsEntity settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences prefs;
  SettingsLocalDataSourceImpl(this.prefs);

  static const _key = 'app_settings';

  @override
  Future<SettingsEntity> getSettings() async {
    final json = prefs.getString(_key);
    if (json == null) return SettingsEntity(); // defaults
    return SettingsEntity.fromJson(json);
  }

  @override
  Future<void> saveSettings(SettingsEntity settings) async {
    await prefs.setString(_key, settings.toJson());
  }
}
