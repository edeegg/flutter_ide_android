import '../../domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({
    required ThemeOption themeOption,
    required bool highlightError,
    
  }) : super(
          themeOption: themeOption,
          highlightError: highlightError,
         
        );

  factory SettingsModel.fromJson(String jsonStr) {
    final Map<String, dynamic> json = jsonDecode(jsonStr);
    return SettingsModel(
      themeOption: ThemeOption.values[json['themeOption']],
      highlightError: json['highlightError'],
    
    );
  }

  String toJson() {
    final map = {
      'themeOption': themeOption.index,
      'highlightError': highlightError,
      
    };
    return jsonEncode(map);
  }
}
