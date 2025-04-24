import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/settings_entity.dart';
import '../../viewmodels/theme_settings_viewmodel.dart';

class ThemeSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final vm = Provider.of<ThemeSettingsViewModel>(c);
    return Scaffold(
      appBar: AppBar(title: Text('Tema')),
      body: ListView(
        children: ThemeOption.values.map((opt) {
          return RadioListTile<ThemeOption>(
            title: Text(opt.toString().split('.').last),
            value: opt,
            groupValue: vm.selected,
            onChanged: vm.select,
          );
        }).toList(),
      ),
    );
  }
}
