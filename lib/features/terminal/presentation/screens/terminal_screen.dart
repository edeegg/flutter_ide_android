import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/terminal_provider.dart';
import '../widgets/terminal_output_widget.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  _TerminalScreenState createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<TerminalProvider>();

    provider.executeCommand.repository.startTerminal(provider.workDirectory);
    //  provider.sendCommand('/data/data/com.termux/files/home');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(child: TerminalOutputWidget()),
        ],
      ),
    );
  }
}
