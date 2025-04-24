
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/editor_settings_provider.dart';
import '../widgets/common_dialogs.dart';

class EditorSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final vm = Provider.of<EditorSettingsProvider>(c);
    return Scaffold(
      appBar: AppBar(title: Text('Editor')),
      body: ListView(children: [
        SwitchListTile(
          title: Text('Destaque de Erro'),
          value: vm.highlightError,
          onChanged: vm.toggleHighlightError,
        ),
        SwitchListTile(
          title: Text('Auto completar'),
          value: vm.autoComplete,
          onChanged: vm.toggleAutoComplete,
        ),
        SwitchListTile(
          title: Text('Bloco de Código'),
          value: vm.codeBlock,
          onChanged: vm.toggleCodeBlock,
        ),
        SwitchListTile(
          title: Text('Line Highlight'),
          value: vm.lineHighlight,
          onChanged: vm.toggleLineHighlight,
        ),
        ListTile(
          title: Text('Tamanho da Fonte (${vm.fontSize.toInt()})'),
          onTap: () => showFontSizeDialog(c, vm),
        ),
        SwitchListTile(
          title: Text('Quebra de Linha Automática'),
          value: vm.autoLineBreak,
          onChanged: vm.toggleAutoLineBreak,
        ),
        SwitchListTile(
          title: Text('Remover Espaços'),
          value: vm.trimSpaces,
          onChanged: vm.toggleTrimSpaces,
        ),
        ListTile(
          title: Text('Importar Extensões'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Símbolos Customizados'),
          subtitle: Text(vm.customSymbols),
          onTap: () => showCustomSymbolsDialog(c, vm),
        ),
        SwitchListTile(
          title: Text('Números de Linhas'),
          value: vm.lineNumbers,
          onChanged: vm.toggleLineNumbers,
        ),
        ListTile(
          title: Text('Fonte: ${vm.fontFamily}'),
          onTap: () => showFontFamilyDialog(c, vm),
        ),
        SwitchListTile(
          title: Text('Auto Save'),
          value: vm.autoSave,
          onChanged: vm.toggleAutoSave,
        ),
      ]),
    );
  }
}
