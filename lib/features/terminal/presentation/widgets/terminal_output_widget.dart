import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xterm/xterm.dart';

import '../providers/terminal_provider.dart';

class TerminalOutputWidget extends StatelessWidget {
  const TerminalOutputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final provider = context.read<TerminalProvider>();
    return TerminalView(
      textScaler: const TextScaler.linear(0.8),
      provider.remoteDataSource.terminal,
      controller: provider.remoteDataSource.controller,
      autofocus: true,
      backgroundOpacity: 0.0,
      /*    theme: TerminalTheme(
        cursor: colors.primary,
        selection: colors.primaryContainer,
        foreground: colors.surface,
        background: colors.surface,
        black: Colors.black,
        white: Colors.white,
        red: Colors.red,
        green: Colors.green,
        yellow: Colors.yellow,
        blue: Colors.blue,
        magenta: Colors.purple,
        cyan: Colors.cyan,
        brightBlack: colors.onSurfaceVariant,
        brightRed: colors.errorContainer,
        brightGreen: colors.secondaryContainer,
        brightYellow: colors.tertiaryContainer,
        brightBlue: colors.primaryContainer,
        brightMagenta: colors.tertiaryContainer,
        brightCyan: colors.secondaryContainer,
        brightWhite: colors.onSurface,
        searchHitBackground: colors.secondaryContainer.withOpacity(0.5),
        searchHitBackgroundCurrent: colors.primaryContainer.withOpacity(0.5),
        searchHitForeground: colors.onSecondaryContainer,
      ), */
      onSecondaryTapDown: (details, offset) async {
        final selection = provider.remoteDataSource.controller.selection;
        if (selection != null) {
          final text =
              provider.remoteDataSource.terminal.buffer.getText(selection);
          provider.remoteDataSource.controller.clearSelection();
          await Clipboard.setData(ClipboardData(text: text));
        } else {
          final data = await Clipboard.getData('text/plain');
          final text = data?.text;
          if (text != null) {
            provider.remoteDataSource.terminal.paste(text);
          }
        }
      },
    );
  }
}
