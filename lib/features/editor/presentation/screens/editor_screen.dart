import 'package:flutter/material.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
/*     return ChangeNotifierProvider<EditorProvider>(
      create: (_) => Provider.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editor de Código'),
          actions: [
            IconButton(
              icon: Icon(Icons.format_align_left),
              onPressed: () => context.read<EditorProvider>().formatDocument(),
            ),
          ],
        ),
        body: CodeEditorWidget(),
      ),
    ); */
  }
}
