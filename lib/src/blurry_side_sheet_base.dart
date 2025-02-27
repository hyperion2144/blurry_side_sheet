import 'dart:ui';

import 'package:flutter/material.dart';

/// Displays a Material Design 3 side sheet as a general dialog.
///
/// The [header] is a required string for the title of the side sheet.
///
/// The [body] is a required widget for the content of the side sheet.
///
/// The [barrierDismissible] boolean value determines if the dialog can be dismissed
/// by tapping outside of it or not. By default, it is set to false.
///
/// The [addDivider] boolean value determines if the side sheet should display
/// a divider between the body and action buttons or not. By default, it is set to `true`.
///
/// By default, it is set to 'Back'.
///
/// Example:
/// ```
/// await showSideSheet(
///   context: context,
///   header: 'Edit Profile',
///   body: ProfileEditForm(),
///   addDivider: true,
/// );
/// ```
Future<void> showModalSideSheet(
  BuildContext context, {
  required Widget body,
  required String header,
  bool barrierDismissible = false,
  bool addDivider = true,
  Duration? transitionDuration,
  double sigma = 20,
  double borderRadius = 16,
  Color barrierColor = Colors.black,
  Widget? closeButton,
  Widget? cancelButton,
  TextStyle? titleStyle,
  Widget? backButton,
  List<Widget> actions = const [],
  MainAxisAlignment actionsMainAxisAlignment = MainAxisAlignment.end,
}) async {
  showGeneralDialog(
    context: context,
    transitionDuration: transitionDuration ?? Duration(milliseconds: 500),
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor.withOpacity(0.3),
    barrierLabel: 'Material 3 side sheet',
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(
          animation,
        ),
        child: child,
      );
    },
    pageBuilder: (context, animation1, animation2) {
      return BackdropFilter(
        blendMode: BlendMode.src,
        filter: ImageFilter.blur(
          sigmaX: sigma,
          sigmaY: sigma,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: SideSheetMaterial3(
            borderRadius: borderRadius,
            header: header,
            body: body,
            addDivider: addDivider,
            backButton: backButton,
            closeButton: closeButton,
            titleStyle: titleStyle,
            actions: actions,
            actionsMainAxisAlignment: actionsMainAxisAlignment,
          ),
        ),
      );
    },
  );
}

class SideSheetMaterial3 extends StatelessWidget {
  final String header;
  final double borderRadius;
  final Widget body;
  final Widget? closeButton;
  final Widget? backButton;
  final bool addDivider;
  final TextStyle? titleStyle;
  final List<Widget> actions;
  final MainAxisAlignment actionsMainAxisAlignment;

  const SideSheetMaterial3({
    super.key,
    required this.borderRadius,
    required this.header,
    required this.body,
    required this.addDivider,
    this.closeButton,
    this.titleStyle,
    required this.actions,
    required this.actionsMainAxisAlignment,
    this.backButton,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Material(
      elevation: 1,
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      borderRadius:
          BorderRadius.horizontal(left: Radius.circular(borderRadius)),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 256,
          maxWidth: size.width <= 600 ? size.width : 400,
          minHeight: size.height,
          maxHeight: size.height,
        ),
        child: Column(
          children: [
            _buildHeader(
              context,
              closeButton,
              titleStyle ?? textTheme.titleSmall,
            ),
            Expanded(
              child: body,
            ),
            Visibility(
              visible: actions.isNotEmpty,
              child: _buildFooter(
                context,
                actionsMainAxisAlignment,
                actions,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    Widget? closeButton,
    TextStyle? titleStyle,
  ) {
    bool addCloseIconButton = closeButton != null;
    return Padding(
      padding: EdgeInsets.fromLTRB(addCloseIconButton ? 16 : 24, 16, 16, 16),
      child: Row(
        children: [
          if (backButton != null)
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: backButton,
            ),
          Text(
            header,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titleStyle,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(width: addCloseIconButton ? 12 : 8),
          ),
          if (addCloseIconButton) closeButton,
        ],
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    MainAxisAlignment mainAxisAlignment,
    List<Widget> actions,
  ) {
    return Column(
      children: [
        Visibility(
          visible: addDivider,
          child: const Divider(
            indent: 24,
            endIndent: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 16, 24, 24),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: actions,
          ),
        ),
      ],
    );
  }
}
