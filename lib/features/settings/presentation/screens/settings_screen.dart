import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _selectedOption;

  
  final Map<String, Widget> _optionWidgets = {
    'Geral': const ThemeSettingsWidget(),
    'Editor': const EditorSettingsWidget(),
    'Terminal': const EditorSettingsWidget(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            leading: _selectedOption != null
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        _selectedOption = null;
                      });
                    },
                  )
                : null,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _selectedOption ?? 'Settings',
                style: const TextStyle(fontSize: 20),
              ),
              background: Container(
                color: Colors.blueAccent,
              ),
            ),
          ),
     
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _selectedOption == null
                    ? _buildMenu()    
                    : _optionWidgets[_selectedOption],
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildMenu() {
    return ListView(
      key: const ValueKey('menu'),
      children: [
        for (final title in _optionWidgets.keys)
          Card(
            child: ListTile(
              title: Text(title),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                setState(() {
                  _selectedOption = title;
                });
              },
            ),
          ),
      ],
    );
  }
}
