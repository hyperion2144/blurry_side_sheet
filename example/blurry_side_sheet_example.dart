import 'package:blurry_side_sheet/blurry_side_sheet.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        useMaterial3: true, // Important
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: FilledButton(
            onPressed: () {
              showModalSideSheet(
                // Required
                context,
                // Pass your content widget (required)
                body: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),

                // Required
                header: 'Edit user',

                barrierDismissible: false,
                addBackIconButton: false,
                addCloseIconButton: true,
                addActions: true,
                addDivider: true,
                confirmActionTitle: 'Update',
                cancelActionTitle: 'Cancel',
                confirmActionOnPressed: () {},
                transitionDuration: Duration(milliseconds: 500),
                closeButtonTooltip: 'Close',
                backButtonTooltip: 'Back',
              );
            },
            child: Text('show side sheet'),
          ),
        ),
      ),
    );
  }
}
